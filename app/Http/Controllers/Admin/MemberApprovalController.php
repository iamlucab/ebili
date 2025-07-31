<?php
namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Member;
use App\Models\User;
use App\Models\MembershipCode;
use App\Models\ReferralBonusLog;
use App\Models\ReferralConfiguration;
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
        DB::beginTransaction();
        try {
            // Get active configuration
            $config = ReferralConfiguration::getActive();
            
            if (!$config) {
                // Fallback to default values if no configuration exists
                $layer1 = $member->sponsor;
                $layer2 = $layer1->sponsor ?? null;
                $layer3 = $layer2->sponsor ?? null;

                if ($layer1 && $layer1->cashbackWallet) {
                    $layer1->cashbackWallet->credit(env('LEVEL_1_BONUS', 25), "Direct referral bonus from {$member->full_name}");
                    ReferralBonusLog::create([
                        'member_id'          => $layer1->id,
                        'referred_member_id' => $member->id,
                        'level'              => 1,
                        'amount'             => env('LEVEL_1_BONUS', 25),
                        'description'        => "Direct referral bonus from {$member->full_name}"
                    ]);
                }

                if ($layer2 && $layer2->cashbackWallet) {
                    $layer2->cashbackWallet->credit(env('LEVEL_2_BONUS', 15), "2nd level referral bonus from {$member->full_name}");
                    ReferralBonusLog::create([
                        'member_id'          => $layer2->id,
                        'referred_member_id' => $member->id,
                        'level'              => 2,
                        'amount'             => env('LEVEL_2_BONUS', 15),
                        'description'        => "2nd level referral bonus from {$member->full_name}"
                    ]);
                }

                if ($layer3 && $layer3->cashbackWallet) {
                    $layer3->cashbackWallet->credit(env('LEVEL_3_BONUS', 10), "3rd level referral bonus from {$member->full_name}");
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
                    
                    if ($bonusAmount > 0 && $sponsor->cashbackWallet) {
                        $levelText = $level == 1 ? "Direct" : "{$level}nd level";
                        $sponsor->cashbackWallet->credit(
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