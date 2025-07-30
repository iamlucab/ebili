<?php
require_once 'vendor/autoload.php';

// Load Laravel environment
$app = require_once 'bootstrap/app.php';
$app->make(Illuminate\Contracts\Console\Kernel::class)->bootstrap();

use Illuminate\Support\Facades\DB;
use App\Models\WalletTransaction;
use App\Models\ReferralBonusLog;

echo "=== WALLET TRANSACTIONS & REFERRAL BONUSES INTEGRATION ===\n\n";

try {
    DB::beginTransaction();

    // 1. Insert new wallet transactions
    echo "1. Integrating Wallet Transactions...\n";
    
    $newWalletTransactions = [
        ['id' => 55, 'wallet_id' => 35, 'member_id' => 17, 'type' => 'credit', 'amount' => 25.00, 'source' => null, 'description' => 'Direct referral bonus from Benje Remonde', 'related_member_id' => null, 'created_at' => '2025-07-28 15:41:10', 'updated_at' => '2025-07-28 15:41:10'],
        ['id' => 56, 'wallet_id' => 80, 'member_id' => 39, 'type' => 'credit', 'amount' => 25.00, 'source' => null, 'description' => 'Direct referral bonus from Macaria Opeńa', 'related_member_id' => null, 'created_at' => '2025-07-28 16:59:23', 'updated_at' => '2025-07-28 16:59:23'],
        ['id' => 57, 'wallet_id' => 36, 'member_id' => 17, 'type' => 'credit', 'amount' => 15.00, 'source' => null, 'description' => '2nd level referral bonus from Macaria Opeńa', 'related_member_id' => null, 'created_at' => '2025-07-28 16:59:23', 'updated_at' => '2025-07-28 16:59:23'],
        ['id' => 58, 'wallet_id' => 80, 'member_id' => 39, 'type' => 'credit', 'amount' => 25.00, 'source' => null, 'description' => 'Direct referral bonus from Lorina Phuno', 'related_member_id' => null, 'created_at' => '2025-07-28 17:07:02', 'updated_at' => '2025-07-28 17:07:02'],
        ['id' => 59, 'wallet_id' => 36, 'member_id' => 17, 'type' => 'credit', 'amount' => 15.00, 'source' => null, 'description' => '2nd level referral bonus from Lorina Phuno', 'related_member_id' => null, 'created_at' => '2025-07-28 17:07:02', 'updated_at' => '2025-07-28 17:07:02'],
        ['id' => 60, 'wallet_id' => 80, 'member_id' => 39, 'type' => 'credit', 'amount' => 25.00, 'source' => null, 'description' => 'Direct referral bonus from Marissa Labrador', 'related_member_id' => null, 'created_at' => '2025-07-28 17:20:18', 'updated_at' => '2025-07-28 17:20:18'],
        ['id' => 61, 'wallet_id' => 36, 'member_id' => 17, 'type' => 'credit', 'amount' => 15.00, 'source' => null, 'description' => '2nd level referral bonus from Marissa Labrador', 'related_member_id' => null, 'created_at' => '2025-07-28 17:20:18', 'updated_at' => '2025-07-28 17:20:18'],
        ['id' => 62, 'wallet_id' => 80, 'member_id' => 39, 'type' => 'credit', 'amount' => 25.00, 'source' => null, 'description' => 'Direct referral bonus from Perla Andio', 'related_member_id' => null, 'created_at' => '2025-07-28 18:59:06', 'updated_at' => '2025-07-28 18:59:06'],
        ['id' => 63, 'wallet_id' => 36, 'member_id' => 17, 'type' => 'credit', 'amount' => 15.00, 'source' => null, 'description' => '2nd level referral bonus from Perla Andio', 'related_member_id' => null, 'created_at' => '2025-07-28 18:59:06', 'updated_at' => '2025-07-28 18:59:06'],
        ['id' => 64, 'wallet_id' => 80, 'member_id' => 39, 'type' => 'credit', 'amount' => 25.00, 'source' => null, 'description' => 'Direct referral bonus from Ruben Ranoco', 'related_member_id' => null, 'created_at' => '2025-07-28 19:08:17', 'updated_at' => '2025-07-28 19:08:17'],
        ['id' => 65, 'wallet_id' => 36, 'member_id' => 17, 'type' => 'credit', 'amount' => 15.00, 'source' => null, 'description' => '2nd level referral bonus from Ruben Ranoco', 'related_member_id' => null, 'created_at' => '2025-07-28 19:08:17', 'updated_at' => '2025-07-28 19:08:17'],
        ['id' => 66, 'wallet_id' => 80, 'member_id' => 39, 'type' => null, 'amount' => -100.00, 'source' => null, 'description' => 'Transfer to main wallet (-₱2.00 fee)', 'related_member_id' => null, 'created_at' => '2025-07-28 20:32:14', 'updated_at' => '2025-07-28 20:32:14'],
        ['id' => 67, 'wallet_id' => 79, 'member_id' => 39, 'type' => null, 'amount' => 98.00, 'source' => null, 'description' => 'Received from cashback wallet (₱100.00 - ₱2.00 fee)', 'related_member_id' => null, 'created_at' => '2025-07-28 20:32:14', 'updated_at' => '2025-07-28 20:32:14'],
        ['id' => 68, 'wallet_id' => 79, 'member_id' => 39, 'type' => 'credit', 'amount' => 100.00, 'source' => null, 'description' => 'Topup by Admin - test', 'related_member_id' => null, 'created_at' => '2025-07-28 20:58:36', 'updated_at' => '2025-07-28 20:58:36'],
        ['id' => 69, 'wallet_id' => 80, 'member_id' => 39, 'type' => 'credit', 'amount' => 100.00, 'source' => null, 'description' => 'Topup by Admin - test', 'related_member_id' => null, 'created_at' => '2025-07-28 20:59:25', 'updated_at' => '2025-07-28 20:59:25'],
        ['id' => 70, 'wallet_id' => 79, 'member_id' => 39, 'type' => 'debit', 'amount' => 100.00, 'source' => null, 'description' => 'Refund by Admin - test', 'related_member_id' => null, 'created_at' => '2025-07-28 21:00:05', 'updated_at' => '2025-07-28 21:00:05'],
        ['id' => 71, 'wallet_id' => 80, 'member_id' => 39, 'type' => 'debit', 'amount' => 100.00, 'source' => null, 'description' => 'Refund by Admin - test', 'related_member_id' => null, 'created_at' => '2025-07-28 21:00:36', 'updated_at' => '2025-07-28 21:00:36'],
        ['id' => 72, 'wallet_id' => 79, 'member_id' => 39, 'type' => 'credit', 'amount' => 1000.00, 'source' => null, 'description' => 'Topup by Admin - for test', 'related_member_id' => null, 'created_at' => '2025-07-28 21:01:30', 'updated_at' => '2025-07-28 21:01:30'],
        ['id' => 73, 'wallet_id' => 80, 'member_id' => 39, 'type' => null, 'amount' => -10.00, 'source' => null, 'description' => 'Transfer to main wallet (-₱0.00 fee)', 'related_member_id' => null, 'created_at' => '2025-07-28 21:05:40', 'updated_at' => '2025-07-28 21:05:40'],
        ['id' => 74, 'wallet_id' => 79, 'member_id' => 39, 'type' => null, 'amount' => 10.00, 'source' => null, 'description' => 'Received from cashback wallet (₱10.00 - ₱0.00 fee)', 'related_member_id' => null, 'created_at' => '2025-07-28 21:05:40', 'updated_at' => '2025-07-28 21:05:40'],
        ['id' => 75, 'wallet_id' => 79, 'member_id' => 39, 'type' => 'credit', 'amount' => 1000.00, 'source' => null, 'description' => 'Topup by Admin - test', 'related_member_id' => null, 'created_at' => '2025-07-29 00:32:16', 'updated_at' => '2025-07-29 00:32:16'],
        ['id' => 76, 'wallet_id' => 79, 'member_id' => 39, 'type' => 'debit', 'amount' => 1000.00, 'source' => null, 'description' => 'Refund by Admin - test', 'related_member_id' => null, 'created_at' => '2025-07-29 00:33:04', 'updated_at' => '2025-07-29 00:33:04'],
        ['id' => 77, 'wallet_id' => 80, 'member_id' => 39, 'type' => 'credit', 'amount' => 100.00, 'source' => null, 'description' => 'Topup by Admin - test', 'related_member_id' => null, 'created_at' => '2025-07-29 00:33:37', 'updated_at' => '2025-07-29 00:33:37']
    ];

    foreach ($newWalletTransactions as $transactionData) {
        if (!WalletTransaction::where('id', $transactionData['id'])->exists()) {
            WalletTransaction::create($transactionData);
            echo "  - Added wallet transaction: ID {$transactionData['id']} - {$transactionData['description']}\n";
        } else {
            echo "  - Skipped wallet transaction: ID {$transactionData['id']} (already exists)\n";
        }
    }

    // 2. Insert new referral bonus logs
    echo "\n2. Integrating Referral Bonus Logs...\n";
    
    $newReferralBonusLogs = [
        ['id' => 52, 'member_id' => 17, 'referred_member_id' => 39, 'level' => 1, 'amount' => 25.00, 'description' => 'Direct referral bonus from Benje Remonde', 'created_at' => '2025-07-28 15:41:10', 'updated_at' => '2025-07-28 15:41:10'],
        ['id' => 53, 'member_id' => 39, 'referred_member_id' => 40, 'level' => 1, 'amount' => 25.00, 'description' => 'Direct referral bonus from Macaria Opeńa', 'created_at' => '2025-07-28 16:59:23', 'updated_at' => '2025-07-28 16:59:23'],
        ['id' => 54, 'member_id' => 17, 'referred_member_id' => 40, 'level' => 2, 'amount' => 15.00, 'description' => '2nd level referral bonus from Macaria Opeńa', 'created_at' => '2025-07-28 16:59:23', 'updated_at' => '2025-07-28 16:59:23'],
        ['id' => 55, 'member_id' => 39, 'referred_member_id' => 41, 'level' => 1, 'amount' => 25.00, 'description' => 'Direct referral bonus from Lorina Phuno', 'created_at' => '2025-07-28 17:07:02', 'updated_at' => '2025-07-28 17:07:02'],
        ['id' => 56, 'member_id' => 17, 'referred_member_id' => 41, 'level' => 2, 'amount' => 15.00, 'description' => '2nd level referral bonus from Lorina Phuno', 'created_at' => '2025-07-28 17:07:02', 'updated_at' => '2025-07-28 17:07:02'],
        ['id' => 57, 'member_id' => 39, 'referred_member_id' => 42, 'level' => 1, 'amount' => 25.00, 'description' => 'Direct referral bonus from Marissa Labrador', 'created_at' => '2025-07-28 17:20:18', 'updated_at' => '2025-07-28 17:20:18'],
        ['id' => 58, 'member_id' => 17, 'referred_member_id' => 42, 'level' => 2, 'amount' => 15.00, 'description' => '2nd level referral bonus from Marissa Labrador', 'created_at' => '2025-07-28 17:20:18', 'updated_at' => '2025-07-28 17:20:18'],
        ['id' => 59, 'member_id' => 39, 'referred_member_id' => 43, 'level' => 1, 'amount' => 25.00, 'description' => 'Direct referral bonus from Perla Andio', 'created_at' => '2025-07-28 18:59:06', 'updated_at' => '2025-07-28 18:59:06'],
        ['id' => 60, 'member_id' => 17, 'referred_member_id' => 43, 'level' => 2, 'amount' => 15.00, 'description' => '2nd level referral bonus from Perla Andio', 'created_at' => '2025-07-28 18:59:06', 'updated_at' => '2025-07-28 18:59:06'],
        ['id' => 61, 'member_id' => 39, 'referred_member_id' => 44, 'level' => 1, 'amount' => 25.00, 'description' => 'Direct referral bonus from Ruben Ranoco', 'created_at' => '2025-07-28 19:08:17', 'updated_at' => '2025-07-28 19:08:17'],
        ['id' => 62, 'member_id' => 17, 'referred_member_id' => 44, 'level' => 2, 'amount' => 15.00, 'description' => '2nd level referral bonus from Ruben Ranoco', 'created_at' => '2025-07-28 19:08:17', 'updated_at' => '2025-07-28 19:08:17']
    ];

    foreach ($newReferralBonusLogs as $bonusData) {
        if (!ReferralBonusLog::where('id', $bonusData['id'])->exists()) {
            ReferralBonusLog::create($bonusData);
            echo "  - Added referral bonus: ID {$bonusData['id']} - {$bonusData['description']}\n";
        } else {
            echo "  - Skipped referral bonus: ID {$bonusData['id']} (already exists)\n";
        }
    }

    echo "\n=== TRANSACTIONS & BONUSES INTEGRATION COMPLETED ===\n";
    
    DB::commit();
    
} catch (Exception $e) {
    DB::rollback();
    echo "ERROR: " . $e->getMessage() . "\n";
    echo "Integration rolled back.\n";
}