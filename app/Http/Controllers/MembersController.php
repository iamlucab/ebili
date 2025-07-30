<?php

namespace App\Http\Controllers;

use App\Models\Member;
use App\Models\ReferralBonusLog;
use App\Models\ReferralConfiguration;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use App\Models\Loan;

class MembersController extends Controller
{
    public function index()
    {
        $members = Member::with('sponsor')->get(); // eager load sponsor
        return view('members.index', compact('members'));
    }

    public function create()
    {
        $sponsors = Member::all();
        return view('members.create', compact('sponsors'));
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'first_name'    => 'required|string|max:255',
            'middle_name'   => 'nullable|string|max:255',
            'last_name'     => 'required|string|max:255',
            'birthday'      => 'required|date',
            'mobile_number' => 'required|unique:members,mobile_number',
            'occupation'    => 'nullable|string|max:255',
            'photo'         => 'nullable|image|max:2048',
            'role'          => 'required|in:Admin,Staff,Member',
            'sponsor_id'    => 'nullable|exists:members,id',
            'status'        => 'required|in:Pending,Approved',
        ]);

        // Save photo to storage/photos
        if ($request->hasFile('photo')) {
            $filename = uniqid() . '.' . $request->file('photo')->getClientOriginalExtension();
            $request->file('photo')->move(storage_path('photos'), $filename);
            $validated['photo'] = $filename;
        }

        $validated['loan_eligible'] = $request->has('loan_eligible');

        Member::create($validated);

        return redirect()->route('members.index')->with('success', 'Member created.');
    }

    public function edit(Member $member)
    {
        $sponsors = Member::all();
        return view('members.edit', compact('member', 'sponsors'));
    }

 public function update(Request $request, Member $member)
{
    $rules = [
        'first_name'    => 'required|string|max:255',
        'middle_name'   => 'nullable|string|max:255',
        'last_name'     => 'required|string|max:255',
        'birthday'      => 'required|date',
        'mobile_number' => 'required|unique:members,mobile_number,' . $member->id,
        'email'         => 'nullable|email|unique:users,email,' . ($member->user->id ?? 'NULL'),
        'new_password'  => 'nullable|string|min:6',
        'occupation'    => 'nullable|string|max:255',
        'address'       => 'nullable|string|max:255',
        'photo'         => 'nullable|image|max:2048',
        'role'          => 'required|in:Admin,Staff,Member',
        'sponsor_id'    => 'nullable|exists:members,id',
        'status'        => 'required|in:Pending,Approved',
        'membership_code' => [
            'required',
            'string',
            'exists:membership_codes,code',
            function ($attribute, $value, $fail) use ($member) {
                $code = \App\Models\MembershipCode::where('code', $value)->first();
                
                // If the member already has this code, it's valid
                $currentCode = $member->membershipCode ? $member->membershipCode->code : null;
                if ($value === $currentCode) {
                    return;
                }
                
                // Otherwise, check if the code is unused
                if (!$code || $code->used) {
                    $fail('The membership code is invalid or already used.');
                }
            },
        ],
    ];
    
    $validated = $request->validate($rules);

    // Handle photo update
    if ($request->hasFile('photo')) {
        if ($member->photo) {
            $oldPath = storage_path('photos/' . $member->photo);
            if (file_exists($oldPath)) {
                unlink($oldPath);
            }
        }

        $filename = uniqid() . '.' . $request->file('photo')->getClientOriginalExtension();
        $request->file('photo')->move(storage_path('photos'), $filename);
        $validated['photo'] = $filename;
    }

    $validated['loan_eligible'] = $request->has('loan_eligible');

    $oldStatus = $member->status;
    $member->update($validated);

    // ✅ Ensure associated user is updated too
    $user = $member->user ?? \App\Models\User::where('member_id', $member->id)->first();

    if ($user) {
        $updateData = [
            'status'        => $validated['status'],
            'role'          => $validated['role'],
            'mobile_number' => $validated['mobile_number'],
            'name'          => $validated['first_name'] . ' ' . $validated['last_name'],
            'member_id'     => $member->id,
        ];

        // Update email if provided
        if (!empty($validated['email'])) {
            $updateData['email'] = $validated['email'];
        }

        // Update password if provided
        if (!empty($validated['new_password'])) {
            $updateData['password'] = Hash::make($validated['new_password']);
        }

        $user->update($updateData);
    }
    
    // Handle membership code
    $currentCode = $member->membershipCode ? $member->membershipCode->code : null;
    
    // If the code is different from the current one, update it
    if ($request->membership_code !== $currentCode) {
        // If there's a current code, release it
        if ($currentCode) {
            \App\Models\MembershipCode::where('code', $currentCode)
                ->update(['used' => false, 'used_by' => null, 'used_at' => null]);
        }
        
        // Assign the new code
        $code = \App\Models\MembershipCode::where('code', $request->membership_code)->first();
        if ($code && $user) {
            $code->update([
                'used' => true,
                'used_by' => $user->id,
                'used_at' => now(),
            ]);
        }
    }

    // ✅ If status changed from Pending to Approved, credit referral bonuses
    if ($oldStatus === 'Pending' && $validated['status'] === 'Approved' && $member->sponsor) {
        DB::beginTransaction();
        try {
            // Get active configuration
            $config = ReferralConfiguration::getActive();
            
            if (!$config) {
                // Fallback to default values if no configuration exists
                $layer1 = $member->sponsor;
                $layer2 = $layer1->sponsor ?? null;
                $layer3 = $layer2->sponsor ?? null;

                if ($layer1 && $layer1->wallet) {
                    $layer1->wallet->credit(env('LEVEL_1_BONUS', 25), "Direct referral bonus from {$member->full_name}");
                    ReferralBonusLog::create([
                        'member_id'          => $layer1->id,
                        'referred_member_id' => $member->id,
                        'level'              => 1,
                        'amount'             => env('LEVEL_1_BONUS', 25),
                        'description'        => "Direct referral bonus from {$member->full_name}"
                    ]);
                }

                if ($layer2 && $layer2->wallet) {
                    $layer2->wallet->credit(env('LEVEL_2_BONUS', 15), "2nd level referral bonus from {$member->full_name}");
                    ReferralBonusLog::create([
                        'member_id'          => $layer2->id,
                        'referred_member_id' => $member->id,
                        'level'              => 2,
                        'amount'             => env('LEVEL_2_BONUS', 15),
                        'description'        => "2nd level referral bonus from {$member->full_name}"
                    ]);
                }

                if ($layer3 && $layer3->wallet) {
                    $layer3->wallet->credit(env('LEVEL_3_BONUS', 10), "3rd level referral bonus from {$member->full_name}");
                    ReferralBonusLog::create([
                        'member_id'          => $layer3->id,
                        'referred_member_id' => $member->id,
                        'level'              => 3,
                        'amount'             => env('LEVEL_3_BONUS', 10),
                        'description'        => "3rd level referral bonus from {$member->full_name}"
                    ]);
                }
            } else {
                // Use dynamic configuration
                $sponsor = $member->sponsor;
                $level = 1;
                
                // Calculate all bonus amounts once
                $bonuses = $config->getAllBonuses();
                
                while ($sponsor && $level <= $config->max_level) {
                    $bonusAmount = $bonuses[$level] ?? 0;
                    
                    if ($bonusAmount > 0 && $sponsor->wallet) {
                        $levelText = $level == 1 ? "Direct" : "{$level}nd level";
                        $sponsor->wallet->credit(
                            $bonusAmount,
                            "{$levelText} referral bonus from {$member->full_name}"
                        );
                        
                        ReferralBonusLog::create([
                            'member_id' => $sponsor->id,
                            'referred_member_id' => $member->id,
                            'level' => $level,
                            'amount' => $bonusAmount,
                            'description' => "{$levelText} referral bonus from {$member->full_name}"
                        ]);
                    }
                    
                    $sponsor = $sponsor->sponsor;
                    $level++;
                }
            }

            DB::commit();
        } catch (\Exception $e) {
            DB::rollBack();
            \Log::error('Referral bonus failed during approval: ' . $e->getMessage());
        }
    }

    return redirect()->route('members.index')->with('success', 'Member updated.');
}



    public function show($id)
    {
        $member = Member::with('sponsor', 'user')->findOrFail($id);
        return view('admin.members.show', compact('member'));
    }

    public function destroy(Member $member)
    {
        if ($member->photo) {
            $photoPath = storage_path('photos/' . $member->photo);
            if (file_exists($photoPath)) {
                unlink($photoPath);
            }
        }

        $member->delete();

        return redirect()->route('members.index')->with('success', 'Member deleted.');
    }
}
