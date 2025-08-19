<?php

namespace App\Http\Controllers\Member;

use App\Http\Controllers\Controller;
use App\Models\Member;
use Illuminate\Http\Request;
use Carbon\Carbon;

class ReferralController extends Controller
{
    /**
     * Display referral summary for the authenticated member
     */
    public function summary(Request $request)
    {
        $member = auth()->user()->member;
<<<<<<< HEAD

        // Get date range from request or default to current month
        $startDate = $request->get('start_date', now()->startOfMonth()->format('Y-m-d'));
        $endDate = $request->get('end_date', now()->endOfMonth()->format('Y-m-d'));

        // Get selected level filter (default to all levels)
        $selectedLevel = $request->get('level', 'all');

=======
        
        // Get date range from request or default to current month
        $startDate = $request->get('start_date', now()->startOfMonth()->format('Y-m-d'));
        $endDate = $request->get('end_date', now()->endOfMonth()->format('Y-m-d'));
        
        // Get selected level filter (default to all levels)
        $selectedLevel = $request->get('level', 'all');
        
>>>>>>> 88683a79a8561339598c5a454c661ead1363a03e
        // Get all referral levels data
        $referralData = [];
        $totalReferrals = 0;
        $totalBonusEarned = 0;
<<<<<<< HEAD

        for ($level = 1; $level <= 11; $level++) {
            $referrals = $member->getReferralsByLevel($level);

            // Filter by date range if provided
            if ($startDate && $endDate) {
                $referrals = $referrals->whereBetween('created_at', [
                    Carbon::parse($startDate)->startOfDay(),
                    Carbon::parse($endDate)->endOfDay()
                ]);
            }

            $referralCount = $referrals->count();

=======
        
        for ($level = 1; $level <= 11; $level++) {
            $referrals = $member->getReferralsByLevel($level);
            
            // Filter by date range if provided
            if ($startDate && $endDate) {
                if ($referrals instanceof \Illuminate\Database\Eloquent\Builder) {
                    // For query builders (level 1)
                    $referrals = $referrals->whereBetween('created_at', [
                        Carbon::parse($startDate)->startOfDay(),
                        Carbon::parse($endDate)->endOfDay()
                    ]);
                } else {
                    // For collections (levels > 1)
                    $referrals = $referrals->whereBetween('created_at', [
                        Carbon::parse($startDate)->startOfDay(),
                        Carbon::parse($endDate)->endOfDay()
                    ]);
                }
            }
            
            $referralCount = $referrals->count();
            
>>>>>>> 88683a79a8561339598c5a454c661ead1363a03e
            // Calculate bonus earned from this level
            $bonusEarned = $member->referralBonusLogs()
                ->where('level', $level)
                ->when($startDate && $endDate, function($query) use ($startDate, $endDate) {
                    return $query->whereBetween('created_at', [
                        Carbon::parse($startDate)->startOfDay(),
                        Carbon::parse($endDate)->endOfDay()
                    ]);
                })
                ->sum('amount');
<<<<<<< HEAD

=======
            
>>>>>>> 88683a79a8561339598c5a454c661ead1363a03e
            if ($referralCount > 0 || $bonusEarned > 0) {
                $referralData[$level] = [
                    'level' => $level,
                    'count' => $referralCount,
                    'bonus_earned' => $bonusEarned,
                    'referrals' => $referrals instanceof \Illuminate\Database\Eloquent\Builder ? $referrals->get() : $referrals
                ];
<<<<<<< HEAD

=======
                
>>>>>>> 88683a79a8561339598c5a454c661ead1363a03e
                $totalReferrals += $referralCount;
                $totalBonusEarned += $bonusEarned;
            }
        }
<<<<<<< HEAD

=======
        
>>>>>>> 88683a79a8561339598c5a454c661ead1363a03e
        // Filter by specific level if requested
        if ($selectedLevel !== 'all' && is_numeric($selectedLevel)) {
            $referralData = array_filter($referralData, function($data) use ($selectedLevel) {
                return $data['level'] == $selectedLevel;
            });
        }
<<<<<<< HEAD

// Get recent referral bonus logs for activity feed with pagination
=======
        
        // Get recent referral bonus logs for activity feed
>>>>>>> 88683a79a8561339598c5a454c661ead1363a03e
        $recentBonusLogs = $member->referralBonusLogs()
            ->with('referredMember')
            ->when($startDate && $endDate, function($query) use ($startDate, $endDate) {
                return $query->whereBetween('created_at', [
                    Carbon::parse($startDate)->startOfDay(),
                    Carbon::parse($endDate)->endOfDay()
                ]);
            })
            ->latest()
<<<<<<< HEAD
            ->paginate(10, ['*'], 'bonus_page');

=======
            ->take(10)
            ->get();
        
>>>>>>> 88683a79a8561339598c5a454c661ead1363a03e
        return view('members.referral-summary', compact(
            'member',
            'referralData',
            'totalReferrals',
            'totalBonusEarned',
            'recentBonusLogs',
            'startDate',
            'endDate',
            'selectedLevel'
        ));
    }
<<<<<<< HEAD

=======
    
>>>>>>> 88683a79a8561339598c5a454c661ead1363a03e
    /**
     * Get referral details for a specific level (AJAX)
     */
    public function levelDetails(Request $request, $level)
    {
        $member = auth()->user()->member;
        $startDate = $request->get('start_date');
        $endDate = $request->get('end_date');
<<<<<<< HEAD

        $referrals = $member->getReferralsByLevel($level);

        // Filter by date range if provided
        if ($startDate && $endDate) {
            $referrals = $referrals->whereBetween('created_at', [
                Carbon::parse($startDate)->startOfDay(),
                Carbon::parse($endDate)->endOfDay()
            ]);
        }

=======
        
        $referrals = $member->getReferralsByLevel($level);
        
        // Filter by date range if provided
        if ($startDate && $endDate) {
            if ($referrals instanceof \Illuminate\Database\Eloquent\Builder) {
                // For query builders (level 1)
                $referrals = $referrals->whereBetween('created_at', [
                    Carbon::parse($startDate)->startOfDay(),
                    Carbon::parse($endDate)->endOfDay()
                ]);
            } else {
                // For collections (levels > 1)
                $referrals = $referrals->whereBetween('created_at', [
                    Carbon::parse($startDate)->startOfDay(),
                    Carbon::parse($endDate)->endOfDay()
                ]);
            }
        }
        
>>>>>>> 88683a79a8561339598c5a454c661ead1363a03e
        return response()->json([
            'level' => $level,
            'referrals' => ($referrals instanceof \Illuminate\Database\Eloquent\Builder ? $referrals->get() : $referrals)->map(function($referral) {
                return [
                    'id' => $referral->id,
                    'name' => $referral->full_name,
                    'mobile_number' => $referral->mobile_number,
                    'status' => $referral->status,
                    'created_at' => $referral->created_at->format('Y-m-d H:i'),
                    'created_at_human' => $referral->created_at->diffForHumans()
                ];
            })
        ]);
    }
<<<<<<< HEAD
}
=======
}
>>>>>>> 88683a79a8561339598c5a454c661ead1363a03e
