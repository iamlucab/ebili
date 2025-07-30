<?php

/**
 * Simple test script to verify the integration
 * Run this after running the integration command
 */

require_once 'vendor/autoload.php';

use App\Models\Member;
use App\Models\User;
use App\Models\Wallet;
use App\Models\WalletTransaction;
use App\Models\CashInRequest;

echo "=== TESTING SPECIFIC MEMBERS INTEGRATION ===\n\n";

// Test specific member IDs from amigos-latest.sql
$testMemberIds = [10026, 10027, 10028, 10029, 10030, 10031, 10032, 10033, 10034];
$testUserIds = [11045, 11046, 11047, 11048, 11049, 11050, 11051, 11052, 11053];

echo "1. Testing Members:\n";
foreach ($testMemberIds as $memberId) {
    $member = Member::find($memberId);
    if ($member) {
        echo "  ✅ {$member->full_name} (ID: {$memberId}) - Mobile: {$member->mobile_number}\n";
        
        // Test relationships
        $user = $member->user;
        $mainWallet = $member->wallet;
        $cashbackWallet = $member->cashbackWallet;
        
        echo "    - User: " . ($user ? "✅ {$user->name}" : "❌ Not found") . "\n";
        echo "    - Main Wallet: " . ($mainWallet ? "✅ ₱{$mainWallet->balance}" : "❌ Not found") . "\n";
        echo "    - Cashback Wallet: " . ($cashbackWallet ? "✅ ₱{$cashbackWallet->balance}" : "❌ Not found") . "\n";
        
        // Test sponsor relationship
        if ($member->sponsor) {
            echo "    - Sponsor: ✅ {$member->sponsor->full_name}\n";
        }
        
        echo "\n";
    } else {
        echo "  ❌ Member ID {$memberId} not found\n";
    }
}

echo "\n2. Testing Users:\n";
foreach ($testUserIds as $userId) {
    $user = User::find($userId);
    if ($user) {
        echo "  ✅ {$user->name} (ID: {$userId}) - Mobile: {$user->mobile_number}\n";
        
        // Test member relationship
        $member = $user->member;
        echo "    - Member: " . ($member ? "✅ {$member->full_name}" : "❌ Not found") . "\n";
    } else {
        echo "  ❌ User ID {$userId} not found\n";
    }
}

echo "\n3. Testing Wallet Transactions:\n";
$transactionIds = [19, 25, 44, 37]; // Sample transaction IDs from the integration
foreach ($transactionIds as $transactionId) {
    $transaction = WalletTransaction::find($transactionId);
    if ($transaction) {
        echo "  ✅ Transaction ID {$transactionId}: {$transaction->description} (₱{$transaction->amount})\n";
        
        // Test wallet relationship
        $wallet = $transaction->wallet;
        if ($wallet) {
            $member = $wallet->member;
            echo "    - Wallet Owner: " . ($member ? $member->full_name : "Unknown") . "\n";
        }
    } else {
        echo "  ❌ Transaction ID {$transactionId} not found\n";
    }
}

echo "\n4. Testing Cash-in Requests:\n";
$cashInIds = [2, 3]; // Sample cash-in request IDs
foreach ($cashInIds as $requestId) {
    $request = CashInRequest::find($requestId);
    if ($request) {
        $member = $request->member;
        $memberName = $member ? $member->full_name : "Unknown";
        echo "  ✅ Request ID {$requestId}: {$memberName} - ₱{$request->amount} ({$request->status})\n";
    } else {
        echo "  ❌ Cash-in request ID {$requestId} not found\n";
    }
}

echo "\n5. Testing Referral Relationships:\n";
// Test specific referral chains from the data
$referralTests = [
    ['sponsor' => 16, 'referred' => 10026, 'name' => 'Ruthcil -> Bernie'],
    ['sponsor' => 10026, 'referred' => 10027, 'name' => 'Bernie -> Cindy'],
    ['sponsor' => 16, 'referred' => 10028, 'name' => 'Ruthcil -> Nor'],
    ['sponsor' => 10028, 'referred' => 10029, 'name' => 'Nor -> Ariel'],
    ['sponsor' => 10028, 'referred' => 10034, 'name' => 'Nor -> Melanie'],
    ['sponsor' => 10032, 'referred' => 10033, 'name' => 'Margie -> Leah'],
];

foreach ($referralTests as $test) {
    $sponsor = Member::find($test['sponsor']);
    $referred = Member::find($test['referred']);
    
    if ($sponsor && $referred && $referred->sponsor_id == $sponsor->id) {
        echo "  ✅ {$test['name']}: {$sponsor->full_name} -> {$referred->full_name}\n";
    } else {
        echo "  ❌ {$test['name']}: Relationship not found or incorrect\n";
    }
}

echo "\n6. Summary Statistics:\n";
$totalMembers = Member::whereIn('id', $testMemberIds)->count();
$totalUsers = User::whereIn('id', $testUserIds)->count();
$totalWallets = Wallet::whereIn('member_id', $testMemberIds)->count();
$totalTransactions = WalletTransaction::whereIn('id', [19, 25, 44, 37])->count();
$totalCashInRequests = CashInRequest::whereIn('id', [2, 3])->count();

echo "  - Members integrated: {$totalMembers}/9\n";
echo "  - Users integrated: {$totalUsers}/9\n";
echo "  - Wallets created: {$totalWallets}/18 (2 per member)\n";
echo "  - Transactions created: {$totalTransactions}/4\n";
echo "  - Cash-in requests: {$totalCashInRequests}/2\n";

// Calculate total wallet balances
$totalMainBalance = Wallet::whereIn('member_id', $testMemberIds)
    ->where('type', 'main')
    ->sum('balance');
    
$totalCashbackBalance = Wallet::whereIn('member_id', $testMemberIds)
    ->where('type', 'cashback')
    ->sum('balance');

echo "  - Total main wallet balance: ₱{$totalMainBalance}\n";
echo "  - Total cashback wallet balance: ₱{$totalCashbackBalance}\n";

echo "\n=== INTEGRATION TEST COMPLETED ===\n";

// Check for any issues
$issues = [];

if ($totalMembers < 9) {
    $issues[] = "Missing members";
}

if ($totalUsers < 9) {
    $issues[] = "Missing users";
}

if ($totalWallets < 18) {
    $issues[] = "Missing wallets";
}

if (!empty($issues)) {
    echo "\n⚠️  ISSUES FOUND:\n";
    foreach ($issues as $issue) {
        echo "  - {$issue}\n";
    }
} else {
    echo "\n🎉 ALL TESTS PASSED! Integration appears to be successful.\n";
}