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
    
    echo "=== FINAL VERIFICATION AND FIX ===\n\n";
    
    echo "=== CHECKING ALL MEMBERS ===\n";
    $stmt = $pdo->query("SELECT id, first_name, last_name, mobile_number, status FROM members ORDER BY id");
    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
        echo "Member ID: {$row['id']}, Name: {$row['first_name']} {$row['last_name']}, Mobile: {$row['mobile_number']}, Status: {$row['status']}\n";
    }
    
    echo "\n=== CHECKING ALL USERS ===\n";
    $stmt = $pdo->query("SELECT id, name, mobile_number, member_id, status FROM users ORDER BY id");
    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
        echo "User ID: {$row['id']}, Name: {$row['name']}, Mobile: {$row['mobile_number']}, Member ID: {$row['member_id']}, Status: {$row['status']}\n";
    }
    
    echo "\n=== CHECKING USER-MEMBER RELATIONSHIPS ===\n";
    $stmt = $pdo->query("
        SELECT 
            u.id as user_id, 
            u.name as user_name, 
            u.mobile_number as user_mobile,
            u.member_id as linked_member_id,
            m.id as actual_member_id,
            m.first_name,
            m.last_name,
            m.mobile_number as member_mobile
        FROM users u
        LEFT JOIN members m ON u.member_id = m.id
        WHERE u.role = 'Member'
        ORDER BY u.id
    ");
    
    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
        $status = ($row['user_mobile'] == $row['member_mobile']) ? '✅' : '❌';
        echo "{$status} User: {$row['user_name']} (ID: {$row['user_id']}) -> Member: {$row['first_name']} {$row['last_name']} (ID: {$row['actual_member_id']})\n";
        if ($row['user_mobile'] != $row['member_mobile']) {
            echo "   Mobile mismatch: User({$row['user_mobile']}) vs Member({$row['member_mobile']})\n";
        }
    }
    
    echo "\n=== CHECKING WALLETS ===\n";
    $stmt = $pdo->query("
        SELECT 
            w.id, 
            w.wallet_id, 
            w.type, 
            w.user_id, 
            w.member_id, 
            w.balance,
            u.name as user_name,
            m.first_name,
            m.last_name
        FROM wallets w
        LEFT JOIN users u ON w.user_id = u.id
        LEFT JOIN members m ON w.member_id = m.id
        WHERE w.member_id >= 10035
        ORDER BY w.member_id, w.type
    ");
    
    echo "Recent wallets (member_id >= 10035):\n";
    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
        echo "Wallet: {$row['wallet_id']} ({$row['type']}) - User: {$row['user_name']} (ID: {$row['user_id']}) - Member: {$row['first_name']} {$row['last_name']} (ID: {$row['member_id']}) - Balance: {$row['balance']}\n";
    }
    
    echo "\n=== SUMMARY ===\n";
    $stmt = $pdo->query("SELECT COUNT(*) as count FROM users");
    $userCount = $stmt->fetch(PDO::FETCH_ASSOC)['count'];
    
    $stmt = $pdo->query("SELECT COUNT(*) as count FROM members");
    $memberCount = $stmt->fetch(PDO::FETCH_ASSOC)['count'];
    
    $stmt = $pdo->query("SELECT COUNT(*) as count FROM wallets");
    $walletCount = $stmt->fetch(PDO::FETCH_ASSOC)['count'];
    
    echo "Total counts:\n";
    echo "- Users: {$userCount}\n";
    echo "- Members: {$memberCount}\n";
    echo "- Wallets: {$walletCount}\n";
    
    // Check for specific missing members from your feedback
    echo "\n=== CHECKING SPECIFIC MEMBERS FROM YOUR FEEDBACK ===\n";
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
    
} catch (PDOException $e) {
    echo "Database connection failed: " . $e->getMessage() . "\n";
}
?>