<?php
namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Member;
use App\Models\User;
use App\Models\MembershipCode;
use App\Models\ReferralBonusLog;
use App\Models\ReferralConfiguration;
use App\Services\ReferralBonusService;
use App\Notifications\MemberApprovedNotification;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class MemberApprovalController extends Controller
{
    public function index()
    {
        $pendingMembers = Member::where('status', 'Pending')->get();
        $sponsors = Member::where('status', 'Approved')->get();
        $availableCodes = MembershipCode::where('used', false)->get();

        return view('admin.members.pending', compact('pendingMembers', 'sponsors', 'availableCodes'));
    }

    public function approve(Request $request, $id)
{
    $request->validate([
        'sponsor_id' => 'required|exists:members,id',
        'membership_code' => 'required|exists:membership_codes,code',
    ]);

    $member = Member::findOrFail($id);
    $user = User::where('member_id', $member->id)->firstOrFail();
    $code = MembershipCode::where('code', $request->membership_code)->where('used', false)->first();

    if (!$code) {
        return back()->withErrors(['membership_code' => 'Code is invalid or already used.']);
    }

    $member->update([
        'sponsor_id' => $request->sponsor_id,
        'status' => 'Approved',
    ]);

    $user->update(['status' => 'Approved']);

    $code->update([
        'used' => true,
        'used_by' => $user->id,
        'used_at' => now(),
    ]);

    // Apply referral bonuses since member is now approved
    if ($member->sponsor) {
        // Check if bonuses haven't been awarded yet to prevent duplicates
        if (!ReferralBonusService::bonusesAlreadyAwarded($member)) {
            ReferralBonusService::awardReferralBonuses($member);
        }
    }

    // 🔔 Send notification and broadcast
    $user->notify(new \App\Notifications\MemberApprovedNotification());
    event(new \App\Events\MemberApproved($user->id, 'Your membership has been approved!'));

    return back()->with('success', 'Member approved, notified, and referral bonuses distributed.');
}

    public function reject($id)
    {
        $member = Member::findOrFail($id);
        $user = User::where('member_id', $member->id)->firstOrFail();

        $member->update(['status' => 'Rejected']);
        $user->update(['status' => 'Rejected']);

        return back()->with('success', 'Member rejected.');
    }

}