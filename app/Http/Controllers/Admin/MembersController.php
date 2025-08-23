<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Member;
use App\Models\ReferralBonusLog;
use App\Models\ReferralConfiguration;
use App\Services\ReferralBonusService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use App\Models\Loan;

class MembersController extends Controller
{
    public function index()
    {
        $members = Member::with(['sponsor', 'membershipCode'])->get(); // eager load sponsor and membership code
        return view('admin.members.index', compact('members'));
    }

    public function create()
    {
        $sponsors = Member::where('status', 'Approved')->get();
        return view('admin.members.create', compact('sponsors'));
    }

    public function store(Request $request)
    {
        // Log the request data for debugging
        \Log::info('Admin member store request data:', $request->all());

        try {
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

            // Log validated data
            \Log::info('Validated data:', $validated);
        } catch (\Illuminate\Validation\ValidationException $e) {
            // Log validation errors
            \Log::error('Validation errors:', $e->errors());
            return redirect()->back()->withErrors($e->errors())->withInput();
        }

        // Save photo to storage/photos
        if ($request->hasFile('photo')) {
            $filename = uniqid() . '.' . $request->file('photo')->getClientOriginalExtension();
            $request->file('photo')->move(storage_path('photos'), $filename);
            $validated['photo'] = $filename;
        }

        $validated['loan_eligible'] = $request->has('loan_eligible');

        // Capitalize first letter of specified fields
        $validated['first_name'] = ucfirst(strtolower($validated['first_name']));
        $validated['middle_name'] = $validated['middle_name'] ? ucfirst(strtolower($validated['middle_name'])) : null;
        $validated['last_name'] = ucfirst(strtolower($validated['last_name']));
        $validated['occupation'] = $validated['occupation'] ? ucfirst(strtolower($validated['occupation'])) : null;

        try {
            // Create member
            $member = Member::create($validated);
            \Log::info('Member created:', $member->toArray());

            // Create user account
            $user = \App\Models\User::create([
                'name' => $validated['first_name'] . ' ' . $validated['last_name'],
                'email' => $validated['mobile_number'] . '@ebili.online',
                'mobile_number' => $validated['mobile_number'],
                'password' => \Hash::make('password123'), // Default password
                'role' => $validated['role'],
                'member_id' => $member->id,
                'status' => $validated['status'],
            ]);
            \Log::info('User created:', $user->toArray());

            // Award referral bonuses if member is created with "Approved" status
            if ($validated['status'] === 'Approved') {
                ReferralBonusService::awardReferralBonuses($member);
            }

            return redirect()->route('members.index')->with('success', 'Member created successfully.');
        } catch (\Exception $e) {
            \Log::error('Error creating member:', ['message' => $e->getMessage(), 'trace' => $e->getTraceAsString()]);
            return redirect()->back()->with('error', 'Failed to create member: ' . $e->getMessage())->withInput();
        }
    }

    public function edit(Member $member)
    {
        $sponsors = Member::where('status', 'Approved')->get();
        return view('admin.members.edit', compact('member', 'sponsors'));
    }

    public function update(Request $request, Member $member)
    {
        // Log the request data for debugging
        \Log::info('Admin member update request data:', $request->all());

        try {
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
            ];

            $validated = $request->validate($rules);

            // Log validated data
            \Log::info('Validated data:', $validated);
        } catch (\Illuminate\Validation\ValidationException $e) {
            // Log validation errors
            \Log::error('Validation errors:', $e->errors());
            return redirect()->back()->withErrors($e->errors())->withInput();
        }

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

        // Capitalize first letter of specified fields
        $validated['first_name'] = ucfirst(strtolower($validated['first_name']));
        $validated['middle_name'] = $validated['middle_name'] ? ucfirst(strtolower($validated['middle_name'])) : null;
        $validated['last_name'] = ucfirst(strtolower($validated['last_name']));
        $validated['occupation'] = $validated['occupation'] ? ucfirst(strtolower($validated['occupation'])) : null;
        $validated['address'] = $validated['address'] ? ucfirst(strtolower($validated['address'])) : null;

        try {
            $oldStatus = $member->status;
            $member->update($validated);
            \Log::info('Member updated:', $member->toArray());

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
                \Log::info('User updated:', $user->toArray());
            }

            // ✅ If status changed from Pending to Approved, credit referral bonuses
            if ($oldStatus === 'Pending' && $validated['status'] === 'Approved' && $member->sponsor) {
                // Check if bonuses haven't been awarded yet to prevent duplicates
                if (!ReferralBonusService::bonusesAlreadyAwarded($member)) {
                    ReferralBonusService::awardReferralBonuses($member);
                }
            }

            return redirect()->route('members.index')->with('success', 'Member updated.');
        } catch (\Exception $e) {
            \Log::error('Error updating member:', ['message' => $e->getMessage(), 'trace' => $e->getTraceAsString()]);
            return redirect()->back()->with('error', 'Failed to update member: ' . $e->getMessage())->withInput();
        }
    }

    public function show(Member $member)
    {
        $member->load('sponsor', 'user');
        return view('admin.members.show', compact('member'));
    }

    public function destroy(Member $member)
    {
        try {
            \Log::info('Deleting member:', $member->toArray());

            if ($member->photo) {
                $photoPath = storage_path('photos/' . $member->photo);
                if (file_exists($photoPath)) {
                    unlink($photoPath);
                }
            }

            $member->delete();
            \Log::info('Member deleted successfully');

            return redirect()->route('members.index')->with('success', 'Member deleted.');
        } catch (\Exception $e) {
            \Log::error('Error deleting member:', ['message' => $e->getMessage(), 'trace' => $e->getTraceAsString()]);
            return redirect()->back()->with('error', 'Failed to delete member: ' . $e->getMessage());
        }
    }
}
