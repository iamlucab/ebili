<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\MembershipCodeRequest;
use App\Models\MembershipCode;

class MembershipCodeRequestController extends Controller
{
    public function index()
    {
        $requests = MembershipCodeRequest::with(['member.user', 'reservedCodes'])
            ->latest()
            ->paginate(10);

        return view('admin.membership-code-requests.index', compact('requests'));
    }

    public function show(MembershipCodeRequest $membershipCodeRequest)
    {
        $membershipCodeRequest->load(['member.user', 'reservedCodes']);
        return view('admin.membership-code-requests.show', compact('membershipCodeRequest'));
    }

    public function approve(Request $request, MembershipCodeRequest $membershipCodeRequest)
    {
        // Validate that we have enough available codes
        $availableCodes = MembershipCode::available()->count();

        if ($availableCodes < $membershipCodeRequest->quantity) {
            return redirect()->back()->with('error', 'Not enough available codes to fulfill this request.');
        }

        // Get available codes
        $codes = MembershipCode::available()->limit($membershipCodeRequest->quantity)->get();

        // Reserve the codes for this request
        foreach ($codes as $code) {
            $code->markAsReserved($membershipCodeRequest->id);

            // Link the code to the request
            $membershipCodeRequest->reservedCodes()->attach($code->id, [
                'reserved_at' => now()
            ]);
        }

        // Update request status
        $membershipCodeRequest->update([
            'status' => 'approved'
        ]);

        // If payment method was Wallet, log the transaction in member's wallet history
        if ($membershipCodeRequest->payment_method === 'Wallet') {
            $member = $membershipCodeRequest->member;
            $wallet = $member->wallet;

            if ($wallet) {
                // Add a transaction record for the approval
                $wallet->transactions()->create([
                    'type' => 'debit',
                    'amount' => $membershipCodeRequest->total_amount,
                    'description' => 'Membership code request approved - ' . $membershipCodeRequest->quantity . ' codes',
                    'member_id' => $member->id,
                ]);
            }
        }

        return redirect()->back()->with('success', 'Request approved and codes reserved successfully.');
    }

    public function reject(Request $request, MembershipCodeRequest $membershipCodeRequest)
    {
        // Release any reserved codes
        foreach ($membershipCodeRequest->reservedCodes as $code) {
            $code->releaseReservation();
        }

        // Clear the pivot table entries
        $membershipCodeRequest->reservedCodes()->detach();

        // Update request status
        $membershipCodeRequest->update([
            'status' => 'rejected'
        ]);

        return redirect()->back()->with('success', 'Request rejected and codes released.');
    }

    public function assignCodes(Request $request, MembershipCodeRequest $membershipCodeRequest)
    {
        // Validate the request
        $request->validate([
            'code_ids' => 'required|array',
            'code_ids.*' => 'exists:membership_codes,id'
        ]);

        // Check if the request already has assigned codes
        if ($membershipCodeRequest->reservedCodes()->count() > 0) {
            return redirect()->back()->with('error', 'Codes have already been assigned to this request.');
        }

        // Get the codes
        $codes = MembershipCode::whereIn('id', $request->code_ids)->get();

        // Check if we have the right quantity
        if ($codes->count() != $membershipCodeRequest->quantity) {
            return redirect()->back()->with('error', 'Incorrect number of codes selected.');
        }

        // Check if all codes are available
        foreach ($codes as $code) {
            if ($code->used || $code->reserved) {
                return redirect()->back()->with('error', 'One or more selected codes are not available.');
            }
        }

        // Reserve the codes for this request
        foreach ($codes as $code) {
            $code->markAsReserved($membershipCodeRequest->id);

            // Link the code to the request in the pivot table
            $membershipCodeRequest->reservedCodes()->attach($code->id, [
                'reserved_at' => now(),
                'assigned_at' => now()
            ]);
        }

        // Update request status to approved if it's still pending
        if ($membershipCodeRequest->status === 'pending') {
            $membershipCodeRequest->update([
                'status' => 'approved'
            ]);
        }

        return redirect()->back()->with('success', 'Codes assigned to member successfully.');
    }

    public function getAvailableCodes(Request $request)
    {
        $query = MembershipCode::available();

        // If unused parameter is explicitly set, ensure we only get unused codes
        if ($request->has('unused') && $request->unused) {
            $query->where('used', false);
        }

        if ($request->has('search') && $request->search) {
            $query->where('code', 'like', '%' . $request->search . '%');
        }

        // Limit to 50 results for performance
        $codes = $query->limit(50)->get(['id', 'code']);

        return response()->json([
            'data' => $codes
        ]);
    }
}
