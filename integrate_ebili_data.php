<?php
require_once 'vendor/autoload.php';

// Load Laravel environment
$app = require_once 'bootstrap/app.php';
$app->make(Illuminate\Contracts\Console\Kernel::class)->bootstrap();

use Illuminate\Support\Facades\DB;
use App\Models\Member;
use App\Models\User;
use App\Models\Wallet;
use App\Models\WalletTransaction;
use App\Models\ReferralBonusLog;
use App\Models\Order;
use App\Models\OrderItem;
use App\Models\MembershipCode;
use App\Models\Product;
use App\Models\Category;
use App\Models\Unit;
use App\Models\Setting;

echo "=== EBILI DATA INTEGRATION SCRIPT ===\n\n";

try {
    DB::beginTransaction();

    // 1. Insert new members (avoiding conflicts)
    echo "1. Integrating Members...\n";
    
    $newMembers = [
        [
            'id' => 38,
            'first_name' => 'System',
            'middle_name' => 'A.',
            'last_name' => 'Admin',
            'birthday' => '1990-01-01',
            'mobile_number' => '09170000001',
            'occupation' => 'Administrator',
            'address' => 'HQ City',
            'photo' => 'default-profile.png',
            'role' => 'Admin',
            'sponsor_id' => null,
            'voter_id' => null,
            'created_at' => '2025-07-27 14:10:52',
            'updated_at' => '2025-07-27 14:10:52',
            'loan_eligible' => 1,
            'status' => 'Approved'
        ],
        [
            'id' => 39,
            'first_name' => 'Benje',
            'middle_name' => 'Erwin',
            'last_name' => 'e-bili',
            'birthday' => '2025-07-28',
            'mobile_number' => '09151836162',
            'occupation' => 'FD',
            'address' => null,
            'photo' => '68875c52194f3.png',
            'role' => 'Member',
            'sponsor_id' => 17,
            'voter_id' => null,
            'created_at' => '2025-07-28 15:32:10',
            'updated_at' => '2025-07-29 02:17:38',
            'loan_eligible' => 1,
            'status' => 'Approved'
        ],
        [
            'id' => 40,
            'first_name' => 'Macaria',
            'middle_name' => null,
            'last_name' => 'Opeńa',
            'birthday' => '2025-07-28',
            'mobile_number' => '09556778397',
            'occupation' => 'Negosyante',
            'address' => null,
            'photo' => null,
            'role' => 'Member',
            'sponsor_id' => 39,
            'voter_id' => null,
            'created_at' => '2025-07-28 16:59:23',
            'updated_at' => '2025-07-28 16:59:23',
            'loan_eligible' => 0,
            'status' => 'Approved'
        ],
        [
            'id' => 41,
            'first_name' => 'Lorina',
            'middle_name' => null,
            'last_name' => 'Phuno',
            'birthday' => '2025-07-28',
            'mobile_number' => '09306730491',
            'occupation' => 'Billionaire',
            'address' => null,
            'photo' => 'LPF5szU5544Rlltt8oOOVVkP4ADSnVvfgm3ibAzW.jpg',
            'role' => 'Member',
            'sponsor_id' => 39,
            'voter_id' => null,
            'created_at' => '2025-07-28 17:07:02',
            'updated_at' => '2025-07-28 17:07:02',
            'loan_eligible' => 0,
            'status' => 'Approved'
        ],
        [
            'id' => 42,
            'first_name' => 'Marissa',
            'middle_name' => null,
            'last_name' => 'Labrador',
            'birthday' => '2025-07-28',
            'mobile_number' => '09109868673',
            'occupation' => 'Negosyante',
            'address' => null,
            'photo' => null,
            'role' => 'Member',
            'sponsor_id' => 39,
            'voter_id' => null,
            'created_at' => '2025-07-28 17:20:18',
            'updated_at' => '2025-07-28 17:20:18',
            'loan_eligible' => 0,
            'status' => 'Approved'
        ],
        [
            'id' => 43,
            'first_name' => 'Perla',
            'middle_name' => null,
            'last_name' => 'Andio',
            'birthday' => '2025-07-28',
            'mobile_number' => '09701678140',
            'occupation' => 'Negosyante',
            'address' => null,
            'photo' => null,
            'role' => 'Member',
            'sponsor_id' => 39,
            'voter_id' => null,
            'created_at' => '2025-07-28 18:59:06',
            'updated_at' => '2025-07-28 18:59:06',
            'loan_eligible' => 0,
            'status' => 'Approved'
        ],
        [
            'id' => 44,
            'first_name' => 'Ruben',
            'middle_name' => null,
            'last_name' => 'Ranoco',
            'birthday' => '2025-07-28',
            'mobile_number' => '09151836163',
            'occupation' => 'Negosyante',
            'address' => null,
            'photo' => null,
            'role' => 'Member',
            'sponsor_id' => 39,
            'voter_id' => null,
            'created_at' => '2025-07-28 19:08:17',
            'updated_at' => '2025-07-28 19:08:17',
            'loan_eligible' => 0,
            'status' => 'Approved'
        ]
    ];

    foreach ($newMembers as $memberData) {
        // Check if member already exists
        if (!Member::where('id', $memberData['id'])->exists() && !Member::where('mobile_number', $memberData['mobile_number'])->exists()) {
            Member::create($memberData);
            echo "  - Added member: {$memberData['first_name']} {$memberData['last_name']} (ID: {$memberData['id']})\n";
        } else {
            echo "  - Skipped member: {$memberData['first_name']} {$memberData['last_name']} (already exists)\n";
        }
    }

    // 2. Insert new users
    echo "\n2. Integrating Users...\n";
    
    $newUsers = [
        [
            'id' => 39,
            'name' => 'System Admin',
            'mobile_number' => '09170000001',
            'email' => 'superadmin@ebili.online',
            'role' => 'Admin',
            'member_id' => 38,
            'email_verified_at' => '2025-07-27 14:10:52',
            'password' => '$2y$10$NG2stxmPrWitBHOFAYyELOHYUu/P3ceDsOUeOw8/sS62rz67QACX2',
            'remember_token' => null,
            'created_at' => '2025-07-27 14:10:52',
            'updated_at' => '2025-07-27 14:10:52',
            'status' => 'Approved'
        ],
        [
            'id' => 40,
            'name' => 'Benje e-bili',
            'mobile_number' => '09151836162',
            'email' => '09151836162@ebili.online',
            'role' => 'Member',
            'member_id' => 39,
            'email_verified_at' => null,
            'password' => '$2y$10$vRvWYlS9FLn1htR0cz2XXe/BnkMjXv8fFc3Ihfok6B20W8nPh2GKS',
            'remember_token' => null,
            'created_at' => '2025-07-28 15:32:10',
            'updated_at' => '2025-07-29 02:14:55',
            'status' => 'Approved'
        ],
        [
            'id' => 41,
            'name' => 'Macaria Opeńa',
            'mobile_number' => '09556778397',
            'email' => '09556778397@ebili.online',
            'role' => 'Member',
            'member_id' => 40,
            'email_verified_at' => null,
            'password' => '$2y$10$CSNnHZo5dCPest30ig7ZquMiRyVNAzp3JCSHg5mi5IvxOItZVLk2W',
            'remember_token' => null,
            'created_at' => '2025-07-28 16:59:23',
            'updated_at' => '2025-07-28 16:59:23',
            'status' => 'Approved'
        ],
        [
            'id' => 42,
            'name' => 'Lorina Phuno',
            'mobile_number' => '09306730491',
            'email' => '09306730491@ebili.online',
            'role' => 'Member',
            'member_id' => 41,
            'email_verified_at' => null,
            'password' => '$2y$10$ibOzST7nXHMWp4jtZ0ZiZuBT.agWD71tqmqwqIUL9f3PGOJpW0viC',
            'remember_token' => null,
            'created_at' => '2025-07-28 17:07:02',
            'updated_at' => '2025-07-28 17:07:02',
            'status' => 'Approved'
        ],
        [
            'id' => 43,
            'name' => 'Marissa Labrador',
            'mobile_number' => '09109868673',
            'email' => '09109868673@ebili.online',
            'role' => 'Member',
            'member_id' => 42,
            'email_verified_at' => null,
            'password' => '$2y$10$0gZGv3lc8U0j4gTrfjj63eKMyYuzUDGBlluJRPbnt.ur5S55Bkx0O',
            'remember_token' => null,
            'created_at' => '2025-07-28 17:20:18',
            'updated_at' => '2025-07-28 17:20:18',
            'status' => 'Approved'
        ],
        [
            'id' => 44,
            'name' => 'Perla Andio',
            'mobile_number' => '09701678140',
            'email' => '09701678140@ebili.online',
            'role' => 'Member',
            'member_id' => 43,
            'email_verified_at' => null,
            'password' => '$2y$10$EEylpdcznrmrp/sKajDLDec4bSXL2b5Cmjv8QuM.BX6Vxt/lUtBVi',
            'remember_token' => null,
            'created_at' => '2025-07-28 18:59:06',
            'updated_at' => '2025-07-28 18:59:06',
            'status' => 'Approved'
        ],
        [
            'id' => 45,
            'name' => 'Ruben Ranoco',
            'mobile_number' => '09151836163',
            'email' => '09151836163@ebili.online',
            'role' => 'Member',
            'member_id' => 44,
            'email_verified_at' => null,
            'password' => '$2y$10$EDHAKQ6gHgq9lh0bsVlcVeU5eatt8U8WyRiLZTUGfngwsuvoAmjsu',
            'remember_token' => null,
            'created_at' => '2025-07-28 19:08:17',
            'updated_at' => '2025-07-28 19:08:17',
            'status' => 'Approved'
        ]
    ];

    foreach ($newUsers as $userData) {
        // Check if user already exists
        if (!User::where('id', $userData['id'])->exists() && !User::where('mobile_number', $userData['mobile_number'])->exists()) {
            User::create($userData);
            echo "  - Added user: {$userData['name']} (ID: {$userData['id']})\n";
        } else {
            echo "  - Skipped user: {$userData['name']} (already exists)\n";
        }
    }

    // 3. Insert new wallets
    echo "\n3. Integrating Wallets...\n";
    
    $newWallets = [
        ['id' => 77, 'wallet_id' => 'WALLET-6886336C3EF24', 'type' => 'main', 'user_id' => null, 'member_id' => 38, 'balance' => 0.00, 'created_at' => '2025-07-27 14:10:52', 'updated_at' => '2025-07-27 14:10:52'],
        ['id' => 78, 'wallet_id' => 'WALLET-6886336C3EF2B', 'type' => 'cashback', 'user_id' => null, 'member_id' => 38, 'balance' => 0.00, 'created_at' => '2025-07-27 14:10:52', 'updated_at' => '2025-07-27 14:10:52'],
        ['id' => 79, 'wallet_id' => 'WALLET-6886C50AAD7E4', 'type' => 'main', 'user_id' => null, 'member_id' => 39, 'balance' => 688.00, 'created_at' => '2025-07-28 15:32:10', 'updated_at' => '2025-07-29 00:33:04'],
        ['id' => 80, 'wallet_id' => 'WALLET-6886C50AAD7E7', 'type' => 'cashback', 'user_id' => null, 'member_id' => 39, 'balance' => 115.00, 'created_at' => '2025-07-28 15:32:10', 'updated_at' => '2025-07-29 00:33:37'],
        ['id' => 81, 'wallet_id' => 'WALLET-6886D97B044FE', 'type' => 'main', 'user_id' => null, 'member_id' => 40, 'balance' => 0.00, 'created_at' => '2025-07-28 16:59:23', 'updated_at' => '2025-07-28 16:59:23'],
        ['id' => 82, 'wallet_id' => 'WALLET-6886D97B04501', 'type' => 'cashback', 'user_id' => null, 'member_id' => 40, 'balance' => 0.00, 'created_at' => '2025-07-28 16:59:23', 'updated_at' => '2025-07-28 16:59:23'],
        ['id' => 83, 'wallet_id' => 'WALLET-6886DB465BA19', 'type' => 'main', 'user_id' => null, 'member_id' => 41, 'balance' => 0.00, 'created_at' => '2025-07-28 17:07:02', 'updated_at' => '2025-07-28 17:07:02'],
        ['id' => 84, 'wallet_id' => 'WALLET-6886DB465BA1E', 'type' => 'cashback', 'user_id' => null, 'member_id' => 41, 'balance' => 0.00, 'created_at' => '2025-07-28 17:07:02', 'updated_at' => '2025-07-28 17:07:02'],
        ['id' => 85, 'wallet_id' => 'WALLET-6886DE62AF65F', 'type' => 'main', 'user_id' => null, 'member_id' => 42, 'balance' => 0.00, 'created_at' => '2025-07-28 17:20:18', 'updated_at' => '2025-07-28 17:20:18'],
        ['id' => 86, 'wallet_id' => 'WALLET-6886DE62AF668', 'type' => 'cashback', 'user_id' => null, 'member_id' => 42, 'balance' => 0.00, 'created_at' => '2025-07-28 17:20:18', 'updated_at' => '2025-07-28 17:20:18'],
        ['id' => 87, 'wallet_id' => 'WALLET-6886F58A6584F', 'type' => 'main', 'user_id' => null, 'member_id' => 43, 'balance' => 0.00, 'created_at' => '2025-07-28 18:59:06', 'updated_at' => '2025-07-28 18:59:06'],
        ['id' => 88, 'wallet_id' => 'WALLET-6886F58A65852', 'type' => 'cashback', 'user_id' => null, 'member_id' => 43, 'balance' => 0.00, 'created_at' => '2025-07-28 18:59:06', 'updated_at' => '2025-07-28 18:59:06'],
        ['id' => 89, 'wallet_id' => 'WALLET-6886F7B1D6D96', 'type' => 'main', 'user_id' => null, 'member_id' => 44, 'balance' => 0.00, 'created_at' => '2025-07-28 19:08:17', 'updated_at' => '2025-07-28 19:08:17'],
        ['id' => 90, 'wallet_id' => 'WALLET-6886F7B1D6D9B', 'type' => 'cashback', 'user_id' => null, 'member_id' => 44, 'balance' => 0.00, 'created_at' => '2025-07-28 19:08:17', 'updated_at' => '2025-07-28 19:08:17']
    ];

    foreach ($newWallets as $walletData) {
        if (!Wallet::where('id', $walletData['id'])->exists() && !Wallet::where('wallet_id', $walletData['wallet_id'])->exists()) {
            Wallet::create($walletData);
            echo "  - Added wallet: {$walletData['wallet_id']} for member {$walletData['member_id']} ({$walletData['type']})\n";
        } else {
            echo "  - Skipped wallet: {$walletData['wallet_id']} (already exists)\n";
        }
    }

    // 4. Insert new membership codes
    echo "\n4. Integrating Membership Codes...\n";
    
    $newMembershipCodes = [
        ['id' => 1, 'code' => '5LNDNNRW', 'used' => 1, 'used_by' => 40, 'used_at' => '2025-07-28 15:41:10', 'created_at' => '2025-07-28 05:45:53', 'updated_at' => '2025-07-28 15:41:10'],
        ['id' => 2, 'code' => 'DG7GZRDV', 'used' => 1, 'used_by' => 41, 'used_at' => '2025-07-28 16:59:23', 'created_at' => '2025-07-28 05:45:53', 'updated_at' => '2025-07-28 16:59:23'],
        ['id' => 3, 'code' => '7H2CDDKE', 'used' => 1, 'used_by' => 42, 'used_at' => '2025-07-28 17:07:02', 'created_at' => '2025-07-28 05:45:53', 'updated_at' => '2025-07-28 17:07:02'],
        ['id' => 4, 'code' => 'ZCNPFPVP', 'used' => 1, 'used_by' => 43, 'used_at' => '2025-07-28 17:20:18', 'created_at' => '2025-07-28 05:45:53', 'updated_at' => '2025-07-28 17:20:18'],
        ['id' => 5, 'code' => '45I1F1WH', 'used' => 1, 'used_by' => 44, 'used_at' => '2025-07-28 18:59:06', 'created_at' => '2025-07-28 05:45:53', 'updated_at' => '2025-07-28 18:59:06'],
        ['id' => 6, 'code' => '2ZEHHMQZ', 'used' => 0, 'used_by' => null, 'used_at' => null, 'created_at' => '2025-07-28 19:02:20', 'updated_at' => '2025-07-28 19:02:20'],
        ['id' => 7, 'code' => 'ZQZ7LMBY', 'used' => 0, 'used_by' => null, 'used_at' => null, 'created_at' => '2025-07-28 19:02:20', 'updated_at' => '2025-07-28 19:02:20'],
        ['id' => 8, 'code' => 'XLIBYZVJ', 'used' => 0, 'used_by' => null, 'used_at' => null, 'created_at' => '2025-07-28 19:02:20', 'updated_at' => '2025-07-28 19:02:20'],
        ['id' => 9, 'code' => 'LTKENGEW', 'used' => 0, 'used_by' => null, 'used_at' => null, 'created_at' => '2025-07-28 19:02:20', 'updated_at' => '2025-07-28 19:02:20'],
        ['id' => 10, 'code' => '7YAYO0VR', 'used' => 0, 'used_by' => null, 'used_at' => null, 'created_at' => '2025-07-28 19:02:20', 'updated_at' => '2025-07-28 19:02:20'],
        ['id' => 11, 'code' => 'UBLYCZGP', 'used' => 0, 'used_by' => null, 'used_at' => null, 'created_at' => '2025-07-28 19:02:20', 'updated_at' => '2025-07-28 19:02:20'],
        ['id' => 12, 'code' => '67BACXJK', 'used' => 0, 'used_by' => null, 'used_at' => null, 'created_at' => '2025-07-28 19:02:20', 'updated_at' => '2025-07-28 19:02:20'],
        ['id' => 13, 'code' => 'R9RDMAVA', 'used' => 0, 'used_by' => null, 'used_at' => null, 'created_at' => '2025-07-28 19:02:20', 'updated_at' => '2025-07-28 19:02:20'],
        ['id' => 14, 'code' => 'VYA9WUOI', 'used' => 0, 'used_by' => null, 'used_at' => null, 'created_at' => '2025-07-28 19:02:20', 'updated_at' => '2025-07-28 19:02:20'],
        ['id' => 15, 'code' => 'PAFKMVQG', 'used' => 1, 'used_by' => 45, 'used_at' => '2025-07-28 19:08:17', 'created_at' => '2025-07-28 19:02:20', 'updated_at' => '2025-07-28 19:08:17']
    ];

    foreach ($newMembershipCodes as $codeData) {
        if (!MembershipCode::where('id', $codeData['id'])->exists() && !MembershipCode::where('code', $codeData['code'])->exists()) {
            MembershipCode::create($codeData);
            echo "  - Added membership code: {$codeData['code']} (ID: {$codeData['id']})\n";
        } else {
            echo "  - Skipped membership code: {$codeData['code']} (already exists)\n";
        }
    }

    echo "\n=== INTEGRATION COMPLETED SUCCESSFULLY ===\n";
    
    DB::commit();
    
} catch (Exception $e) {
    DB::rollback();
    echo "ERROR: " . $e->getMessage() . "\n";
    echo "Integration rolled back.\n";
}