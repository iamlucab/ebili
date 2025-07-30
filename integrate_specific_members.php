<?php

require_once 'vendor/autoload.php';

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use App\Models\Member;
use App\Models\User;
use App\Models\Wallet;
use App\Models\WalletTransaction;
use App\Models\CashInRequest;
use App\Models\ReferralBonusLog;

/**
 * Integration script for specific members from amigos-latest.sql
 * 
 * This script integrates the following specific members and their related data:
 * - Bernie Baldesco (10026)
 * - Cindy Bandao (10027) 
 * - Nor Umpar (10028)
 * - Ariel Capili (10029)
 * - Mary Ann Olbez (10030)
 * - Renz Licarte (10031)
 * - Margie Palacio (10032)
 * - Leah Perez (10033)
 * - Melanie Guiday (10034)
 */

class SpecificMemberIntegrator
{
    private $specificMembers = [
        10026 => [
            'first_name' => 'Bernie',
            'middle_name' => 'Paraguya', 
            'last_name' => 'Baldesco',
            'birthday' => '1980-04-04',
            'mobile_number' => '09465935416',
            'occupation' => 'Businessman',
            'address' => null,
            'photo' => null,
            'role' => 'Member',
            'sponsor_id' => 16,
            'voter_id' => null,
            'loan_eligible' => 0,
            'status' => 'Approved'
        ],
        10027 => [
            'first_name' => 'Cindy',
            'middle_name' => 'Polison',
            'last_name' => 'Bandao', 
            'birthday' => '1998-02-23',
            'mobile_number' => '09914528619',
            'occupation' => 'Saleswoman',
            'address' => null,
            'photo' => null,
            'role' => 'Member',
            'sponsor_id' => 10026,
            'voter_id' => null,
            'loan_eligible' => 0,
            'status' => 'Approved'
        ],
        10028 => [
            'first_name' => 'Nor',
            'middle_name' => 'U',
            'last_name' => 'Umpar',
            'birthday' => '1982-04-04', 
            'mobile_number' => '09099200018',
            'occupation' => 'Lawyer',
            'address' => null,
            'photo' => null,
            'role' => 'Member',
            'sponsor_id' => 16,
            'voter_id' => null,
            'loan_eligible' => 0,
            'status' => 'Approved'
        ],
        10029 => [
            'first_name' => 'Ariel',
            'middle_name' => 'Besmar',
            'last_name' => 'Capili',
            'birthday' => '1967-10-19',
            'mobile_number' => '09171852313',
            'occupation' => null,
            'address' => null,
            'photo' => null,
            'role' => 'Member',
            'sponsor_id' => 10028,
            'voter_id' => null,
            'loan_eligible' => 0,
            'status' => 'Approved'
        ],
        10030 => [
            'first_name' => 'Mary Ann',
            'middle_name' => 'Pagas',
            'last_name' => 'Olbez',
            'birthday' => '1982-10-25',
            'mobile_number' => '09264663844',
            'occupation' => null,
            'address' => null,
            'photo' => null,
            'role' => 'Member',
            'sponsor_id' => 16,
            'voter_id' => null,
            'loan_eligible' => 0,
            'status' => 'Approved'
        ],
        10031 => [
            'first_name' => 'Renz',
            'middle_name' => 'Lim',
            'last_name' => 'Licarte',
            'birthday' => '1988-05-11',
            'mobile_number' => '09763632594',
            'occupation' => 'Engineer',
            'address' => null,
            'photo' => null,
            'role' => 'Member',
            'sponsor_id' => 16,
            'voter_id' => null,
            'loan_eligible' => 0,
            'status' => 'Approved'
        ],
        10032 => [
            'first_name' => 'Margie',
            'middle_name' => 'Navea',
            'last_name' => 'Palacio',
            'birthday' => '1993-07-12',
            'mobile_number' => '09670891993',
            'occupation' => 'Business owner',
            'address' => null,
            'photo' => null,
            'role' => 'Member',
            'sponsor_id' => 16,
            'voter_id' => null,
            'loan_eligible' => 0,
            'status' => 'Approved'
        ],
        10033 => [
            'first_name' => 'Leah',
            'middle_name' => 'Maldepeña',
            'last_name' => 'Perez',
            'birthday' => '1989-01-21',
            'mobile_number' => '09198649321',
            'occupation' => 'Supervisor',
            'address' => null,
            'photo' => null,
            'role' => 'Member',
            'sponsor_id' => 10032,
            'voter_id' => null,
            'loan_eligible' => 0,
            'status' => 'Approved'
        ],
        10034 => [
            'first_name' => 'MELANIE',
            'middle_name' => 'MORAN',
            'last_name' => 'GUIDAY',
            'birthday' => '1988-12-01',
            'mobile_number' => '09165210706',
            'occupation' => 'Real Estate Salesperson',
            'address' => null,
            'photo' => null,
            'role' => 'Member',
            'sponsor_id' => 10028,
            'voter_id' => null,
            'loan_eligible' => 0,
            'status' => 'Approved'
        ]
    ];

    private $specificUsers = [
        11045 => [
            'name' => 'Bernie Baldesco',
            'mobile_number' => '09465935416',
            'email' => '09465935416@coop.local',
            'role' => 'Member',
            'member_id' => 10026,
            'status' => 'Approved'
        ],
        11046 => [
            'name' => 'Cindy Bandao',
            'mobile_number' => '09914528619',
            'email' => '09914528619@coop.local',
            'role' => 'Member',
            'member_id' => 10027,
            'status' => 'Approved'
        ],
        11047 => [
            'name' => 'Nor Umpar',
            'mobile_number' => '09099200018',
            'email' => '09099200018@coop.local',
            'role' => 'Member',
            'member_id' => 10028,
            'status' => 'Approved'
        ],
        11048 => [
            'name' => 'Ariel Capili',
            'mobile_number' => '09171852313',
            'email' => '09171852313@coop.local',
            'role' => 'Member',
            'member_id' => 10029,
            'status' => 'Approved'
        ],
        11049 => [
            'name' => 'Mary Ann Olbez',
            'mobile_number' => '09264663844',
            'email' => '09264663844@coop.local',
            'role' => 'Member',
            'member_id' => 10030,
            'status' => 'Approved'
        ],
        11050 => [
            'name' => 'Renz Licarte',
            'mobile_number' => '09763632594',
            'email' => '09763632594@coop.local',
            'role' => 'Member',
            'member_id' => 10031,
            'status' => 'Approved'
        ],
        11051 => [
            'name' => 'Margie Palacio',
            'mobile_number' => '09670891993',
            'email' => '09670891993@coop.local',
            'role' => 'Member',
            'member_id' => 10032,
            'status' => 'Approved'
        ],
        11052 => [
            'name' => 'Leah Perez',
            'mobile_number' => '09198649321',
            'email' => '09198649321@coop.local',
            'role' => 'Member',
            'member_id' => 10033,
            'status' => 'Approved'
        ],
        11053 => [
            'name' => 'Melanie Guiday',
            'mobile_number' => '09165210706',
            'email' => '09165210706@coop.local',
            'role' => 'Member',
            'member_id' => 10034,
            'status' => 'Approved'
        ]
    ];

    private $specificWallets = [
        // Bernie Baldesco (10026)
        26 => ['type' => 'main', 'member_id' => 10026, 'wallet_id' => 'WALLET-687F388ED45A0', 'balance' => 0.00],
        27 => ['type' => 'cashback', 'member_id' => 10026, 'wallet_id' => 'WALLET-687F388ED45A2', 'balance' => 25.00],
        
        // Cindy Bandao (10027)
        28 => ['type' => 'main', 'member_id' => 10027, 'wallet_id' => 'WALLET-687F38D835794', 'balance' => 0.00],
        29 => ['type' => 'cashback', 'member_id' => 10027, 'wallet_id' => 'WALLET-687F38D835797', 'balance' => 0.00],
        
        // Nor Umpar (10028)
        30 => ['type' => 'main', 'member_id' => 10028, 'wallet_id' => 'WALLET-687F393B42C13', 'balance' => 0.00],
        31 => ['type' => 'cashback', 'member_id' => 10028, 'wallet_id' => 'WALLET-687F393B42C16', 'balance' => 50.00],
        
        // Ariel Capili (10029)
        32 => ['type' => 'main', 'member_id' => 10029, 'wallet_id' => 'WALLET-687F3974D5BA1', 'balance' => 0.00],
        33 => ['type' => 'cashback', 'member_id' => 10029, 'wallet_id' => 'WALLET-687F3974D5BA4', 'balance' => 0.00],
        
        // Mary Ann Olbez (10030)
        34 => ['type' => 'main', 'member_id' => 10030, 'wallet_id' => 'WALLET-687F39B119356', 'balance' => 0.00],
        35 => ['type' => 'cashback', 'member_id' => 10030, 'wallet_id' => 'WALLET-687F39B119359', 'balance' => 0.00],
        
        // Renz Licarte (10031)
        36 => ['type' => 'main', 'member_id' => 10031, 'wallet_id' => 'WALLET-687F39EB801AE', 'balance' => 0.00],
        37 => ['type' => 'cashback', 'member_id' => 10031, 'wallet_id' => 'WALLET-687F39EB801B0', 'balance' => 0.00],
        
        // Margie Palacio (10032)
        38 => ['type' => 'main', 'member_id' => 10032, 'wallet_id' => 'WALLET-687F3A208CD7A', 'balance' => 0.00],
        39 => ['type' => 'cashback', 'member_id' => 10032, 'wallet_id' => 'WALLET-687F3A208CD7D', 'balance' => 25.00],
        
        // Leah Perez (10033)
        40 => ['type' => 'main', 'member_id' => 10033, 'wallet_id' => 'WALLET-687F3ACFC7BFA', 'balance' => 0.00],
        41 => ['type' => 'cashback', 'member_id' => 10033, 'wallet_id' => 'WALLET-687F3ACFC7C01', 'balance' => 0.00],
        
        // Melanie Guiday (10034)
        42 => ['type' => 'main', 'member_id' => 10034, 'wallet_id' => 'WALLET-6880005F782C9', 'balance' => 0.00],
        43 => ['type' => 'cashback', 'member_id' => 10034, 'wallet_id' => 'WALLET-6880005F782CC', 'balance' => 0.00]
    ];

    private $walletTransactions = [
        // Referral bonuses and transactions from the SQL file
        16 => ['wallet_id' => 27, 'member_id' => null, 'type' => 'credit', 'amount' => 25.00, 'source' => null, 'description' => 'Direct referral bonus from Cindy Bandao', 'created_at' => '2025-07-22 07:08:08'],
        17 => ['wallet_id' => 31, 'member_id' => null, 'type' => 'credit', 'amount' => 25.00, 'source' => null, 'description' => 'Direct referral bonus from Ariel Capili', 'created_at' => '2025-07-22 07:10:44'],
        18 => ['wallet_id' => 31, 'member_id' => null, 'type' => 'credit', 'amount' => 25.00, 'source' => null, 'description' => 'Direct referral bonus from MELANIE GUIDAY', 'created_at' => '2025-07-23 12:19:27'],
        19 => ['wallet_id' => 39, 'member_id' => null, 'type' => 'credit', 'amount' => 25.00, 'source' => null, 'description' => 'Direct referral bonus from Leah Perez', 'created_at' => '2025-07-22 07:16:31']
    ];

    private $cashInRequests = [
        2 => [
            'member_id' => 10034,
            'amount' => 100.00,
            'payment_method' => 'GCash',
            'note' => null,
            'proof_path' => 'proofs/NnYNGX7kLhJ9ieWp3Ofcw4KqWl0XJDcSfJrQrQbG.jpg',
            'status' => 'Pending',
            'created_at' => '2025-07-23 18:34:31'
        ],
        3 => [
            'member_id' => 10034,
            'amount' => 100.00,
            'payment_method' => 'GCash',
            'note' => null,
            'proof_path' => 'proofs/4QJvF5Yz3KolhSqKEDuKEemZ7QgkGuyUHkkOumh5.jpg',
            'status' => 'Pending',
            'created_at' => '2025-07-23 18:34:36'
        ]
    ];

    public function integrate()
    {
        echo "Starting integration of specific members from amigos-latest.sql...\n";
        
        DB::beginTransaction();
        
        try {
            $this->integrateMembers();
            $this->integrateUsers();
            $this->integrateWallets();
            $this->integrateWalletTransactions();
            $this->integrateCashInRequests();
            
            DB::commit();
            echo "✅ Integration completed successfully!\n";
            
        } catch (Exception $e) {
            DB::rollback();
            echo "❌ Integration failed: " . $e->getMessage() . "\n";
            throw $e;
        }
    }

    private function integrateMembers()
    {
        echo "Integrating members...\n";
        
        foreach ($this->specificMembers as $memberId => $memberData) {
            // Check if member already exists
            $existingMember = Member::find($memberId);
            
            if ($existingMember) {
                echo "  - Member {$memberData['first_name']} {$memberData['last_name']} (ID: {$memberId}) already exists, updating...\n";
                $existingMember->update($memberData);
            } else {
                echo "  - Creating member {$memberData['first_name']} {$memberData['last_name']} (ID: {$memberId})...\n";
                
                // Temporarily disable model events to prevent automatic wallet creation
                Member::withoutEvents(function () use ($memberId, $memberData) {
                    $member = new Member($memberData);
                    $member->id = $memberId;
                    $member->created_at = '2025-07-22 07:06:54'; // Use original timestamp
                    $member->updated_at = '2025-07-22 07:06:54';
                    $member->save();
                });
            }
        }
        
        echo "  ✅ Members integration completed\n";
    }

    private function integrateUsers()
    {
        echo "Integrating users...\n";
        
        foreach ($this->specificUsers as $userId => $userData) {
            // Check if user already exists
            $existingUser = User::find($userId);
            
            if ($existingUser) {
                echo "  - User {$userData['name']} (ID: {$userId}) already exists, updating...\n";
                $existingUser->update($userData);
            } else {
                echo "  - Creating user {$userData['name']} (ID: {$userId})...\n";
                
                $user = new User($userData);
                $user->id = $userId;
                $user->password = Hash::make('password123'); // Default password
                $user->created_at = '2025-07-22 07:06:55';
                $user->updated_at = '2025-07-22 07:06:55';
                $user->save();
            }
        }
        
        echo "  ✅ Users integration completed\n";
    }

    private function integrateWallets()
    {
        echo "Integrating wallets...\n";
        
        foreach ($this->specificWallets as $walletId => $walletData) {
            // Check if wallet already exists
            $existingWallet = Wallet::find($walletId);
            
            if ($existingWallet) {
                echo "  - Wallet ID {$walletId} already exists, updating balance...\n";
                $existingWallet->update(['balance' => $walletData['balance']]);
            } else {
                $memberName = $this->getMemberName($walletData['member_id']);
                echo "  - Creating {$walletData['type']} wallet for {$memberName} (Wallet ID: {$walletId})...\n";
                
                $wallet = new Wallet($walletData);
                $wallet->id = $walletId;
                $wallet->created_at = '2025-07-22 07:06:54';
                $wallet->updated_at = '2025-07-22 07:06:54';
                $wallet->save();
            }
        }
        
        echo "  ✅ Wallets integration completed\n";
    }

    private function integrateWalletTransactions()
    {
        echo "Integrating wallet transactions...\n";
        
        foreach ($this->walletTransactions as $transactionId => $transactionData) {
            // Check if transaction already exists
            $existingTransaction = WalletTransaction::find($transactionId);
            
            if ($existingTransaction) {
                echo "  - Transaction ID {$transactionId} already exists, skipping...\n";
                continue;
            }
            
            echo "  - Creating wallet transaction ID {$transactionId}: {$transactionData['description']}...\n";
            
            $transaction = new WalletTransaction($transactionData);
            $transaction->id = $transactionId;
            $transaction->created_at = $transactionData['created_at'];
            $transaction->updated_at = $transactionData['created_at'];
            $transaction->save();
        }
        
        echo "  ✅ Wallet transactions integration completed\n";
    }

    private function integrateCashInRequests()
    {
        echo "Integrating cash-in requests...\n";
        
        foreach ($this->cashInRequests as $requestId => $requestData) {
            // Check if request already exists
            $existingRequest = CashInRequest::find($requestId);
            
            if ($existingRequest) {
                echo "  - Cash-in request ID {$requestId} already exists, skipping...\n";
                continue;
            }
            
            $memberName = $this->getMemberName($requestData['member_id']);
            echo "  - Creating cash-in request for {$memberName} (Amount: ₱{$requestData['amount']})...\n";
            
            $request = new CashInRequest($requestData);
            $request->id = $requestId;
            $request->updated_at = $requestData['created_at'];
            $request->save();
        }
        
        echo "  ✅ Cash-in requests integration completed\n";
    }

    private function getMemberName($memberId)
    {
        if (isset($this->specificMembers[$memberId])) {
            $member = $this->specificMembers[$memberId];
            return $member['first_name'] . ' ' . $member['last_name'];
        }
        return "Member ID {$memberId}";
    }

    public function verify()
    {
        echo "\n=== VERIFICATION REPORT ===\n";
        
        // Verify members
        echo "\n1. Members:\n";
        foreach ($this->specificMembers as $memberId => $memberData) {
            $member = Member::find($memberId);
            if ($member) {
                echo "  ✅ {$member->full_name} (ID: {$memberId}) - Status: {$member->status}\n";
            } else {
                echo "  ❌ Member ID {$memberId} not found\n";
            }
        }
        
        // Verify users
        echo "\n2. Users:\n";
        foreach ($this->specificUsers as $userId => $userData) {
            $user = User::find($userId);
            if ($user) {
                echo "  ✅ {$user->name} (ID: {$userId}) - Mobile: {$user->mobile_number}\n";
            } else {
                echo "  ❌ User ID {$userId} not found\n";
            }
        }
        
        // Verify wallets
        echo "\n3. Wallets:\n";
        foreach ($this->specificWallets as $walletId => $walletData) {
            $wallet = Wallet::find($walletId);
            if ($wallet) {
                $memberName = $this->getMemberName($wallet->member_id);
                echo "  ✅ {$memberName} - {$wallet->type} wallet (Balance: ₱{$wallet->balance})\n";
            } else {
                echo "  ❌ Wallet ID {$walletId} not found\n";
            }
        }
        
        // Verify transactions
        echo "\n4. Wallet Transactions:\n";
        foreach ($this->walletTransactions as $transactionId => $transactionData) {
            $transaction = WalletTransaction::find($transactionId);
            if ($transaction) {
                echo "  ✅ Transaction ID {$transactionId}: {$transaction->description} (₱{$transaction->amount})\n";
            } else {
                echo "  ❌ Transaction ID {$transactionId} not found\n";
            }
        }
        
        // Verify cash-in requests
        echo "\n5. Cash-in Requests:\n";
        foreach ($this->cashInRequests as $requestId => $requestData) {
            $request = CashInRequest::find($requestId);
            if ($request) {
                $memberName = $this->getMemberName($request->member_id);
                echo "  ✅ {$memberName} - ₱{$request->amount} ({$request->status})\n";
            } else {
                echo "  ❌ Cash-in request ID {$requestId} not found\n";
            }
        }
        
        echo "\n=== END VERIFICATION ===\n";
    }
}

// Run the integration
try {
    $integrator = new SpecificMemberIntegrator();
    $integrator->integrate();
    $integrator->verify();
    
    echo "\n🎉 All specific members and their related data have been successfully integrated!\n";
    
} catch (Exception $e) {
    echo "\n💥 Integration failed with error: " . $e->getMessage() . "\n";
    echo "Stack trace:\n" . $e->getTraceAsString() . "\n";
}