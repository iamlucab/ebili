<?php

namespace App\Http\Controllers;

use App\Models\Voter;
use App\Models\Member;
use App\Models\User;
use App\Services\ReferralBonusService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use App\Models\MembershipCode;
use Illuminate\Database\QueryException;


class MemberRegistrationController extends Controller


{
    public function create()
{
    $user = auth()->user();

    // If admin/staff, show sponsor dropdown
    if ($user->role === 'Admin' || $user->role === 'Staff') {
        $sponsors = Member::all();
        return view('members.register', compact('sponsors'));
    }

    // If member, don't need sponsor list (they're the sponsor)
    return view('members.register');
}
 public function store(Request $request)
{
    $user = auth()->user();
    $isMember = $user->role === 'Member';

    $request->validate([
        'first_name'      => 'required|string|max:191',
        'middle_name'     => 'nullable|string|max:191',
        'last_name'       => 'required|string|max:191',
        'birthday'        => 'required|date',
        'mobile_number'   => 'required|unique:members,mobile_number|unique:users,mobile_number',
        'occupation'      => 'nullable|string|max:191',
        'photo'           => 'nullable|image|max:2048',
        'role'            => 'required|in:Member,Staff,Admin',
        'sponsor_id'      => $isMember ? 'nullable' : 'required|exists:members,id',
        'membership_code' => [
            'required',
            'string',
            'exists:membership_codes,code',
            function ($attribute, $value, $fail) {
                $code = MembershipCode::where('code', $value)->first();
                if (!$code || $code->used) {
                    $fail('The membership code is invalid or already used.');
                }
            },
        ],
    ], [
        'mobile_number.unique' => 'This mobile number is already registered.',
        'membership_code.exists' => 'The membership code does not exist.',
    ]);

    $photoPath = null;
    if ($request->hasFile('photo')) {
        $photoPath = $request->file('photo')->store('', 'public');
    }

    $sponsorId = $isMember ? $user->member->id : $request->sponsor_id;

    try {
        $member = Member::create([
            'first_name'    => ucfirst(strtolower($request->first_name)),
            'middle_name'   => $request->middle_name ? ucfirst(strtolower($request->middle_name)) : null,
            'last_name'     => ucfirst(strtolower($request->last_name)),
            'birthday'      => $request->birthday,
            'mobile_number' => $request->mobile_number,
            'occupation'    => $request->occupation ? ucfirst(strtolower($request->occupation)) : null,
            'photo'         => $photoPath,
            'role'          => $request->role,
            'sponsor_id'    => $sponsorId,
            'voter_id'      => null,
            'status'        => 'Approved', // ✅ set Member status
        ]);

        $createdUser = User::create([
            'name'          => $member->first_name . ' ' . $member->last_name,
            'email'         => $request->mobile_number . '@ebili.online', //
            'mobile_number' => $request->mobile_number,
            'password'      => Hash::make('secret123'),
            'role'          => $request->role,
            'member_id'     => $member->id,
            'status'        => 'Approved', // ✅ set User status
        ]);

        // Mark membership code as used
        $membershipCode = MembershipCode::where('code', $request->membership_code)->first();
        $membershipCode->update([
            'used'     => true,
            'used_by'  => $createdUser->id,
            'used_at'  => now(),
        ]);

        // Award referral bonuses since member is automatically approved
        ReferralBonusService::awardReferralBonuses($member);

    } catch (QueryException $e) {
        if ($e->errorInfo[1] == 1062) {
            return back()->withInput()->withErrors([
                'mobile_number' => 'This mobile number is already registered.',
            ]);
        }
        throw $e;
    }

    return redirect()->back()->with('success', 'Member registered successfully!');
}


public function checkMobile(Request $request)
{
    $mobile = $request->query('mobile_number');

    $exists = Member::where('mobile_number', $mobile)->where('status', 'Approved')->exists()
        || User::where('mobile_number', $mobile)->where('status', 'Approved')->exists();

    return response()->json(['exists' => $exists]);
}


}
