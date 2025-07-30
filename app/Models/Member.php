<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Support\Facades\DB;
use App\Models\User;
use App\Models\Wallet;
use App\Models\WalletTransaction;
use App\Models\Loan;
use App\Models\Order;
use App\Models\Ticket;
use App\Models\RewardWinner;
use App\Models\ReferralBonusLog;
use App\Models\ReferralConfiguration;

class Member extends Model
{
    use HasFactory;

    protected $fillable = [
        'first_name',
        'middle_name',
        'last_name',
        'birthday',
        'mobile_number',
        'occupation',
        'photo',
        'address',
        'status',
        'role',
        'sponsor_id',
        'loan_eligible',
    ];

    protected $casts = [
        'loan_eligible' => 'boolean',
    ];

    // ─── Relationships ─────────────────────────────────────────────

    public function user()
    {
        return $this->hasOne(User::class, 'member_id');
    }

    public function sponsor()
    {
        return $this->belongsTo(Member::class, 'sponsor_id');
    }

    public function sponsoredMembers()
    {
        return $this->hasMany(Member::class, 'sponsor_id');
    }

    public function wallet() // main wallet
    {
        return $this->hasOne(Wallet::class)->where('type', 'main');
    }

    public function cashbackWallet()
    {
        return $this->hasOne(Wallet::class)->where('type', 'cashback');
    }

    public function allWallets()
    {
        return $this->hasMany(Wallet::class);
    }

    public function transactions()
    {
        return $this->hasManyThrough(WalletTransaction::class, Wallet::class);
    }

    public function rewardWins()
    {
        return $this->hasMany(RewardWinner::class);
    }

    public function tickets()
    {
        return $this->hasMany(Ticket::class);
    }

    public function referralBonusLogs()
    {
        return $this->hasMany(ReferralBonusLog::class);
    }

    public function loans()
    {
        return $this->hasMany(Loan::class);
    }

    public function orders()
    {
        return $this->hasMany(Order::class);
    }
    
    public function membershipCode()
    {
        return $this->hasOneThrough(
            \App\Models\MembershipCode::class,
            \App\Models\User::class,
            'member_id', // Foreign key on users table
            'used_by',   // Foreign key on membership_codes table
            'id',        // Local key on members table
            'id'         // Local key on users table
        );
    }

    // ─── Accessors ────────────────────────────────────────────────

    public function getFullNameAttribute()
    {
        return "{$this->first_name} {$this->last_name}";
    }

    public function getAgeAttribute()
    {
        return now()->diffInYears($this->birthday);
    }

    public function getPhotoUrlAttribute()
    {
        return $this->photo ? asset('storage/' . $this->photo) : asset('images/default-profile.png');
    }

    public function getSponsorNameAttribute()
    {
        return $this->sponsor?->full_name ?? 'No Sponsor';
    }

    public function getRoleNameAttribute()
    {
        return match ($this->role) {
            'admin' => 'Administrator',
            'staff' => 'Staff',
            'member' => 'Member',
            default => 'Unknown Role',
        };
    }

    public function getWalletBalanceAttribute()
    {
        return $this->wallet?->balance ?? 0;
    }

    public function getCashbackBalanceAttribute()
    {
        return $this->cashbackWallet?->balance ?? 0;
    }

    public function getWalletTransactionsAttribute()
    {
        return $this->wallet?->transactions ?? collect();
    }

    public function getCashbackTransactionsAttribute()
    {
        return $this->cashbackWallet?->transactions ?? collect();
    }

    // ─── Booted: Wallet Creation + Bonuses ─────────────────────────

    protected static function booted()
    {
        static::created(function ($member) {
            DB::transaction(function () use ($member) {
                // Create main & cashback wallets
                $member->allWallets()->createMany([
                    [
                        'wallet_id' => Wallet::generateWalletId(),
                        'type' => 'main',
                        'balance' => 0,
                    ],
                    [
                        'wallet_id' => Wallet::generateWalletId(),
                        'type' => 'cashback',
                        'balance' => 0,
                    ],
                ]);

                // Apply referral bonuses (cashback wallet)
                if ($member->sponsor) {
                    // Get active configuration
                    $config = ReferralConfiguration::getActive();
                    if (!$config) {
                        // Fallback to default values if no configuration exists
                        $member->sponsor->cashbackWallet?->credit(
                            env('LEVEL_1_BONUS', 25),
                            "Direct referral bonus from {$member->full_name}"
                        );
                        
                        ReferralBonusLog::create([
                            'member_id' => $member->sponsor->id,
                            'referred_member_id' => $member->id,
                            'level' => 1,
                            'amount' => env('LEVEL_1_BONUS', 25),
                            'description' => "Direct referral bonus from {$member->full_name}"
                        ]);

                        $level2 = $member->sponsor->sponsor;
                        if ($level2) {
                            $level2->cashbackWallet?->credit(
                                env('LEVEL_2_BONUS', 15),
                                "2nd level referral bonus from {$member->full_name}"
                            );
                            
                            ReferralBonusLog::create([
                                'member_id' => $level2->id,
                                'referred_member_id' => $member->id,
                                'level' => 2,
                                'amount' => env('LEVEL_2_BONUS', 15),
                                'description' => "2nd level referral bonus from {$member->full_name}"
                            ]);

                            $level3 = $level2->sponsor;
                            if ($level3) {
                                $level3->cashbackWallet?->credit(
                                    env('LEVEL_3_BONUS', 10),
                                    "3rd level referral bonus from {$member->full_name}"
                                );
                                
                                ReferralBonusLog::create([
                                    'member_id' => $level3->id,
                                    'referred_member_id' => $member->id,
                                    'level' => 3,
                                    'amount' => env('LEVEL_3_BONUS', 10),
                                    'description' => "3rd level referral bonus from {$member->full_name}"
                                ]);
                            }
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
                }
            });
        });
    }
}
