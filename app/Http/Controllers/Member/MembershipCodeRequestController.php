<?php

namespace App\Http\Controllers\Member;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\MembershipCodeRequest;
use App\Models\Wallet;

class MembershipCodeRequestController extends Controller
{
    public function index()
    {
        $member = auth()->user()->member;
        $requests = MembershipCodeRequest::where('member_id', $member->id)
            ->with('reservedCodes')
            ->latest()
            ->paginate(10);

        return view('members.membership-code-request.index', compact('requests'));
    }

    public function create()
    {
        $member = auth()->user()->member;
        $wallet = $member->wallet;
        $amountPerCode = \App\Models\Setting::get('amount_per_code', 100); // Get from settings or default to 100

        // Get member's code requests with reserved codes
        $membershipCodeRequests = MembershipCodeRequest::where('member_id', $member->id)
            ->with('reservedCodes')
            ->latest()
            ->get();

        // Flatten all reserved codes from all requests
        $reservedCodes = $membershipCodeRequests->flatMap->reservedCodes;

        return view('members.membership-code-request.create', compact(
            'wallet',
            'amountPerCode',
            'reservedCodes',
            'membershipCodeRequests'
        ));
    }

    public function store(Request $request)
    {
        $member = auth()->user()->member;

        $request->validate([
            'quantity' => 'required|integer|min:1|max:100',
            'payment_method' => 'required|in:GCash,Bank,Wallet',
            'proof' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
            'note' => 'nullable|string|max:500'
        ]);

        $amountPerCode = \App\Models\Setting::get('amount_per_code', 100); // Get from settings or default to 100
        $totalAmount = $request->quantity * $amountPerCode;

        // Handle proof upload
        $proofPath = null;
        if ($request->hasFile('proof')) {
            $proofPath = $request->file('proof')->store('payment_proofs', 'public');
        }

        // Create membership code request
        $membershipCodeRequest = MembershipCodeRequest::create([
            'member_id' => $member->id,
            'quantity' => $request->quantity,
            'amount_per_code' => $amountPerCode,
            'total_amount' => $totalAmount,
            'payment_method' => $request->payment_method,
            'proof_path' => $proofPath,
            'note' => $request->note,
            'status' => 'pending'
        ]);

        return redirect()->route('member.membership-code-request.index')
            ->with('success', 'Membership code request submitted successfully. Please wait for admin approval.');
    }
}
