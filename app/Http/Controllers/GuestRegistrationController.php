<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Member;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Database\QueryException;

class GuestRegistrationController extends Controller
{
    public function create()
    {
        return view('members.guest-register');
    }

    public function store(Request $request)
    {
        $request->validate([
            'first_name'    => 'required|string|max:191',
            'middle_name'   => 'nullable|string|max:191',
            'last_name'     => 'required|string|max:191',
            'birthday'      => 'required|date',
            'mobile_number' => 'required|string|max:11|regex:/^09\d{9}$/',
            'occupation'    => 'nullable|string|max:191',
            'photo'         => 'nullable|image|max:2048',
            'password'      => 'required|string|min:6',
        ]);

        // ✅ Check if mobile is already registered
        if (
            Member::where('mobile_number', $request->mobile_number)->exists() ||
            User::where('mobile_number', $request->mobile_number)->exists()
        ) {
            return back()->withErrors(['mobile_number' => 'Mobile number is already registered.'])->withInput();
        }

        $photoPath = $request->hasFile('photo')
            ? $request->file('photo')->store('', 'public')
            : null;

        $member = Member::create([
            'first_name'    => $request->first_name,
            'middle_name'   => $request->middle_name,
            'last_name'     => $request->last_name,
            'birthday'      => $request->birthday,
            'mobile_number' => $request->mobile_number,
            'occupation'    => $request->occupation,
            'photo'         => $photoPath,
            'role'          => 'Member',
            'status'        => 'Pending',
            'loan_eligible' => false,
        ]);

        User::create([
            'name'          => $member->first_name . ' ' . $member->last_name,
            'email'         => $request->mobile_number . '@ebili.online',
            'mobile_number' => $request->mobile_number,
            'password'      => Hash::make($request->password),
            'role'          => 'Member',
            'member_id'     => $member->id,
            'status'        => 'Pending',
        ]);

        return redirect()->route('guest.register')->with('success', 'Registration submitted! Wait for admin approval.');
    }

    /**
     * Show referral registration form
     */
    public function createWithReferral($sponsor_id)
    {
        // Validate sponsor exists and is approved
        $sponsor = Member::where('id', $sponsor_id)
            ->where('status', 'Approved')
            ->first();

        if (!$sponsor) {
            return redirect()->route('guest.register')
                ->with('error', 'Invalid referral link. Please register normally.');
        }

        return view('members.referral-register', compact('sponsor', 'sponsor_id'));
    }

    /**
     * Store referral registration
     */
    public function storeWithReferral(Request $request, $sponsor_id)
    {
        $request->validate([
            'first_name'    => 'required|string|max:191',
            'middle_name'   => 'nullable|string|max:191',
            'last_name'     => 'required|string|max:191',
            'birthday'      => 'required|date',
            'mobile_number' => 'required|string|max:11|regex:/^09\d{9}$/',
            'occupation'    => 'nullable|string|max:191',
            'photo'         => 'nullable|image|max:2048',
            'password'      => 'required|string|min:6|confirmed',
            'sponsor_id'    => 'required|exists:members,id',
        ]);

        // Validate sponsor exists and is approved
        $sponsor = Member::where('id', $sponsor_id)
            ->where('status', 'Approved')
            ->first();

        if (!$sponsor) {
            return back()->withErrors(['sponsor_id' => 'Invalid sponsor. Please contact support.'])->withInput();
        }

        // ✅ Check if mobile is already registered
        if (
            Member::where('mobile_number', $request->mobile_number)->exists() ||
            User::where('mobile_number', $request->mobile_number)->exists()
        ) {
            return back()->withErrors(['mobile_number' => 'Mobile number is already registered.'])->withInput();
        }

        $photoPath = $request->hasFile('photo')
            ? $request->file('photo')->store('photos', 'public')
            : null;

        $member = Member::create([
            'first_name'    => $request->first_name,
            'middle_name'   => $request->middle_name,
            'last_name'     => $request->last_name,
            'birthday'      => $request->birthday,
            'mobile_number' => $request->mobile_number,
            'occupation'    => $request->occupation,
            'photo'         => $photoPath,
            'role'          => 'Member',
            'status'        => 'Pending',
            'sponsor_id'    => $sponsor_id, // Set the sponsor
            'loan_eligible' => false,
        ]);

        User::create([
            'name'          => $member->first_name . ' ' . $member->last_name,
            'email'         => $request->mobile_number . '@ebili.online',
            'mobile_number' => $request->mobile_number,
            'password'      => Hash::make($request->password),
            'role'          => 'Member',
            'member_id'     => $member->id,
            'status'        => 'Pending',
        ]);

        return redirect()->route('guest.register.referral', $sponsor_id)
            ->with('success', 'Registration submitted! You and your sponsor will receive bonuses once approved.');
    }
}
