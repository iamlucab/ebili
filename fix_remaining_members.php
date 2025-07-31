<?php
require_once 'vendor/autoload.php';

// Database configuration
$host = '127.0.0.1';
$dbname = 'ebili';
$username = 'root';
$password = '';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    echo "=== FIXING REMAINING MISSING MEMBERS ===\n\n";
    
    // First, let's check what went wrong with member 10035
    echo "=== CHECKING MEMBER 10035 ISSUE ===\n";
    $stmt = $pdo->prepare("SELECT * FROM members WHERE id = 10035");
    $stmt->execute();
    $member10035 = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if ($member10035) {
        echo "Current Member 10035: {$member10035['first_name']} {$member10035['last_name']} ({$member10035['mobile_number']})\n";
        echo "Expected: e-bili online (09151836163)\n";
        
        if ($member10035['mobile_number'] != '09151836163') {
            echo "❌ Wrong data in member 10035. Updating...\n";
            $stmt = $pdo->prepare("
                UPDATE members 
                SET first_name = 'e-bili', middle_name = NULL, last_name = 'online', 
                    mobile_number = '09151836163', occupation = 'Merchant admin wallet',
                    status = 'Approved'
                WHERE id = 10035
            ");
            $stmt->execute();
            echo "✅ Updated member 10035\n";
        }
    }
    
    // Now insert the truly missing members
    $missingMembers = [
        [10036, 'Benje.ebili', NULL, 'Online', '2025-07-29', '09151836162', 'Billionaire', 'earth', NULL, 'Member', 10038, NULL, '2025-07-29 23:30:29', '2025-07-31 04:41:17', 1, 'Approved'],
        [10037, 'Marissa', NULL, 'Labrador', '2025-07-29', '09109868673', 'Negosyante', NULL, NULL, 'Member', 10036, NULL, '2025-07-30 00:10:05', '2025-07-30 00:10:05', 0, 'Approved'],
        [10038, 'Macaria', NULL, 'Opeńa', '2025-07-29', '09556778397', 'Negosyante', NULL, NULL, 'Member', 10036, NULL, '2025-07-30 00:12:29', '2025-07-30 00:12:29', 0, 'Approved'],
        [10039, 'Lorina', NULL, 'Phuno', '2025-07-29', '09306730491', 'Billionaire', NULL, NULL, 'Member', 10036, NULL, '2025-07-30 00:14:51', '2025-07-30 00:14:51', 0, 'Approved'],
        [10040, 'Perla', NULL, 'Andio', '2025-07-29', '09701678140', 'Negosyante', NULL, NULL, 'Member', 10036, NULL, '2025-07-30 00:23:46', '2025-07-30 00:23:46', 0, 'Approved'],
        [10042, 'Ruben', NULL, 'Ranoco', '2025-07-30', '09151836164', 'Negosyante', NULL, NULL, 'Member', 10038, NULL, '2025-07-30 07:53:11', '2025-07-30 07:53:11', 0, 'Approved'],
        [10044, 'Jericho', NULL, 'Noveno', '2003-03-24', '09273001094', 'Leader', 'Epza', 'photos/IG0X3r5WDssmsrQgQb6QufdtDKoYKj35Xv64bvEo.jpg', 'Member', 10036, NULL, '2025-07-31 00:58:34', '2025-07-31 01:10:13', 0, 'Approved']
    ];
    
    $missingUsers = [
        [11055, 'Benje.ebili Online', '09151836162', '09151836162@ebili.online', 'Member', 10036, NULL, '$2y$10$jkaJe3/jH2BXE5RN3Bz6IeK.hiLBRGWJzPcg4GeVTbWZ7ov68pqWC', NULL, '2025-07-29 23:30:29', '2025-07-29 23:32:59', 'Approved'],
        [11056, 'Marissa Labrador', '09109868673', '09109868673@ebili.online', 'Member', 10037, NULL, '$2y$10$Y/04slLDxeqz1CDtSAJ83uUyAkCjJOASX9sHtCzB0UMujl5VgpNH.', NULL, '2025-07-30 00:10:05', '2025-07-30 00:10:05', 'Approved'],
        [11057, 'Macaria Opeńa', '09556778397', '09556778397@ebili.online', 'Member', 10038, NULL, '$2y$10$XDBt8iKrPwJ8j0dtehQo..5QK60qAXxDBP2ID6kb3ayur4GlHgiKi', NULL, '2025-07-30 00:12:29', '2025-07-30 00:12:29', 'Approved'],
        [11058, 'Lorina Phuno', '09306730491', '09306730491@ebili.online', 'Member', 10039, NULL, '$2y$10$O0KNTUiM3TrnBCEiH2c9Z.bHc79N/zXantnCmlPgDi5ujFOGhs7iG', NULL, '2025-07-30 00:14:51', '2025-07-30 00:14:51', 'Approved'],
        [11059, 'Perla Andio', '09701678140', '09701678140@ebili.online', 'Member', 10040, NULL, '$2y$10$u.D74Gv9y4FhPQLEgDjdxuZ/ao5GBqFA5ovivu1paQSFLUwc.MoVq', NULL, '2025-07-30 00:23:46', '2025-07-30 00:23:46', 'Approved'],
        [11061, 'Ruben Ranoco', '09151836164', '09151836164@ebili.online', 'Member', 10042, NULL, '$2y$10$qjlUcDAynB8BNFdaBQqxCOg/6Pn/UKdLb13.buf/s4nELJ79ci6EG', NULL, '2025-07-30 07:53:11', '2025-07-30 07:53:11', 'Approved'],
        [11063, 'Jericho Noveno', '09273001094', '09273001094@ebili.online', 'Member', 10044, NULL, '$2y$10$gJnhiEoiI/XFU0zo6Qdqh.Idhn1IjPUI5LBgWUP.UztJKNb2ugPgq', NULL, '2025-07-31 00:58:34', '2025-07-31 01:10:13', 'Approved']
    ];
    
    // Also need to update user 11054 to link to correct member
    echo "\n=== UPDATING USER 11054 ===\n";
    $stmt = $pdo->prepare("
        UPDATE users 
        SET name = 'e-bili online', email = '09151836163@ebili.online', member_id = 10035, status = 'Approved'
        WHERE id = 11054
    ");
    $stmt->execute();
    echo "✅ Updated user 11054 to link to member 10035\n";
    
    echo "\n=== INSERTING MISSING MEMBERS ===\n";
    $memberInsertStmt = $pdo->prepare("
        INSERT IGNORE INTO members (id, first_name, middle_name, last_name, birthday, mobile_number, occupation, address, photo, role, sponsor_id, voter_id, created_at, updated_at, loan_eligible, status)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    ");
    
    foreach ($missingMembers as $member) {
        try {
            $memberInsertStmt->execute($member);
            echo "✅ Inserted member: {$member[1]} {$member[3]} (ID: {$member[0]})\n";
        } catch (Exception $e) {
            echo "❌ Error inserting member {$member[1]} {$member[3]}: " . $e->getMessage() . "\n";
        }
    }
    
    echo "\n=== INSERTING MISSING USERS ===\n";
    $userInsertStmt = $pdo->prepare("
        INSERT IGNORE INTO users (id, name, mobile_number, email, role, member_id, email_verified_at, password, remember_token, created_at, updated_at, status)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    ");
    
    foreach ($missingUsers as $user) {
        try {
            $userInsertStmt->execute($user);
            echo "✅ Inserted user: {$user[1]} (ID: {$user[0]})\n";
        } catch (Exception $e) {
            echo "❌ Error inserting user {$user[1]}: " . $e->getMessage() . "\n";
        }
    }
    
    echo "\n=== CREATING WALLETS FOR NEW MEMBERS ===\n";
    
    // Create wallets for the newly inserted members
    foreach ($missingMembers as $member) {
        $memberId = $member[0];
        $memberName = $member[1] . ' ' . $member[3];
        
        // Find corresponding user
        $userStmt = $pdo->prepare("SELECT id FROM users WHERE member_id = ?");
        $userStmt->execute([$memberId]);
        $user = $userStmt->fetch(PDO::FETCH_ASSOC);
        $userId = $user ? $user['id'] : null;
        
        // Generate unique wallet IDs
        $mainWalletId = 'WALLET-' . strtoupper(uniqid());
        $cashbackWalletId = 'WALLET-' . strtoupper(uniqid());
        
        try {
            // Create main wallet
            $walletStmt = $pdo->prepare("
                INSERT IGNORE INTO wallets (wallet_id, type, user_id, member_id, balance, created_at, updated_at)
                VALUES (?, 'main', ?, ?, 0.00, NOW(), NOW())
            ");
            $walletStmt->execute([$mainWalletId, $userId, $memberId]);
            
            // Create cashback wallet
            $walletStmt->execute([$cashbackWalletId, $userId, $memberId]);
            
            echo "✅ Created wallets for {$memberName} (Member ID: {$memberId}, User ID: {$userId})\n";
            echo "   - Main: {$mainWalletId}\n";
            echo "   - Cashback: {$cashbackWalletId}\n";
            
        } catch (Exception $e) {
            echo "❌ Error creating wallets for {$memberName}: " . $e->getMessage() . "\n";
        }
    }
    
    echo "\n=== FINAL VERIFICATION ===\n";
    
    // Count totals
    $stmt = $pdo->query("SELECT COUNT(*) as count FROM users");
    $userCount = $stmt->fetch(PDO::FETCH_ASSOC)['count'];
    
    $stmt = $pdo->query("SELECT COUNT(*) as count FROM members");
    $memberCount = $stmt->fetch(PDO::FETCH_ASSOC)['count'];
    
    $stmt = $pdo->query("SELECT COUNT(*) as count FROM wallets");
    $walletCount = $stmt->fetch(PDO::FETCH_ASSOC)['count'];
    
    echo "Final counts:\n";
    echo "- Users: {$userCount}\n";
    echo "- Members: {$memberCount}\n";
    echo "- Wallets: {$walletCount}\n";
    
    echo "\n=== CHECKING ALL EXPECTED MEMBERS ===\n";
    $expectedMembers = [
        [10033, 'Leah', 'Perez', '09198649321'],
        [10034, 'Melanie', 'Guiday', '09165210706'],
        [10035, 'e-bili', 'online', '09151836163'],
        [10036, 'Benje.ebili', 'Online', '09151836162'],
        [10037, 'Marissa', 'Labrador', '09109868673'],
        [10038, 'Macaria', 'Opeńa', '09556778397'],
        [10039, 'Lorina', 'Phuno', '09306730491'],
        [10040, 'Perla', 'Andio', '09701678140'],
        [10041, 'MTC\'s Fruitshakes &', 'Foodhub', '09651233549'],
        [10042, 'Ruben', 'Ranoco', '09151836164'],
        [10043, 'Ben', 'Ma', '09151836165'],
        [10044, 'Jericho', 'Noveno', '09273001094']
    ];
    
    foreach ($expectedMembers as $expected) {
        $stmt = $pdo->prepare("SELECT * FROM members WHERE id = ?");
        $stmt->execute([$expected[0]]);
        $member = $stmt->fetch(PDO::FETCH_ASSOC);
        
        if ($member) {
            echo "✅ Member ID {$expected[0]}: {$member['first_name']} {$member['last_name']} ({$member['mobile_number']})\n";
        } else {
            echo "❌ Missing Member ID {$expected[0]}: {$expected[1]} {$expected[2]} ({$expected[3]})\n";
        }
    }
    
    echo "\n=== FIX COMPLETED SUCCESSFULLY ===\n";
    
} catch (PDOException $e) {
    echo "Database connection failed: " . $e->getMessage() . "\n";
}
?>