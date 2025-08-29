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
    
    echo "=== CHECKING ACTUAL DATABASE STATE ===\n\n";
    
    echo "=== ALL MEMBERS IN DATABASE (ORDERED BY ID) ===\n";
    $stmt = $pdo->query("SELECT id, first_name, middle_name, last_name, mobile_number, status FROM members ORDER BY id");
    $members = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    foreach ($members as $member) {
        echo "ID: {$member['id']}, Name: {$member['first_name']} {$member['middle_name']} {$member['last_name']}, Mobile: {$member['mobile_number']}, Status: {$member['status']}\n";
    }
    
    echo "\nTotal members found: " . count($members) . "\n";
    
    echo "\n=== CHECKING SPECIFIC MISSING MEMBERS ===\n";
    $expectedMembers = [
        [10035, 'e-bili', 'online', '09151836163'],
        [10036, 'Benje.ebili', 'Online', '09151836162'],
        [10037, 'Marissa', 'Labrador', '09109868673'],
        [10038, 'Macaria', 'Opeńa', '09556778397'],
        [10039, 'Lorina', 'Phuno', '09306730491'],
        [10040, 'Perla', 'Andio', '09701678140'],
        [10042, 'Ruben', 'Ranoco', '09151836164'],
        [10044, 'Jericho', 'Noveno', '09273001094']
    ];
    
    foreach ($expectedMembers as $expected) {
        $stmt = $pdo->prepare("SELECT * FROM members WHERE id = ?");
        $stmt->execute([$expected[0]]);
        $member = $stmt->fetch(PDO::FETCH_ASSOC);
        
        if ($member) {
            echo "✅ Found Member ID {$expected[0]}: {$member['first_name']} {$member['last_name']} ({$member['mobile_number']})\n";
        } else {
            echo "❌ Missing Member ID {$expected[0]}: {$expected[1]} {$expected[2]} ({$expected[3]})\n";
        }
    }
    
    echo "\n=== CHECKING USERS ===\n";
    $stmt = $pdo->query("SELECT id, name, mobile_number, member_id, status FROM users WHERE id >= 11054 ORDER BY id");
    $users = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    foreach ($users as $user) {
        echo "User ID: {$user['id']}, Name: {$user['name']}, Mobile: {$user['mobile_number']}, Member ID: {$user['member_id']}, Status: {$user['status']}\n";
    }
    
    echo "\n=== CHECKING FOR CONSTRAINT ISSUES ===\n";
    // Check if there are any foreign key constraint issues
    $stmt = $pdo->query("SHOW CREATE TABLE members");
    $result = $stmt->fetch(PDO::FETCH_ASSOC);
    echo "Members table constraints:\n";
    echo $result['Create Table'] . "\n\n";
    
    echo "=== TRYING DIRECT INSERT TEST ===\n";
    try {
        $stmt = $pdo->prepare("
            INSERT INTO members (id, first_name, middle_name, last_name, birthday, mobile_number, occupation, address, photo, role, sponsor_id, voter_id, created_at, updated_at, loan_eligible, status)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        ");
        
        // Test with member 10036
        $testMember = [10036, 'Benje.ebili', NULL, 'Online', '2025-07-29', '09151836162', 'Billionaire', 'earth', NULL, 'Member', 10038, NULL, '2025-07-29 23:30:29', '2025-07-31 04:41:17', 1, 'Approved'];
        
        $stmt->execute($testMember);
        echo "✅ Successfully inserted test member 10036\n";
        
        // Check if it's there
        $checkStmt = $pdo->prepare("SELECT * FROM members WHERE id = 10036");
        $checkStmt->execute();
        $inserted = $checkStmt->fetch(PDO::FETCH_ASSOC);
        
        if ($inserted) {
            echo "✅ Confirmed: Member 10036 is now in database\n";
        } else {
            echo "❌ Strange: Member 10036 was not found after insert\n";
        }
        
    } catch (Exception $e) {
        echo "❌ Error inserting test member: " . $e->getMessage() . "\n";
    }
    
} catch (PDOException $e) {
    echo "Database connection failed: " . $e->getMessage() . "\n";
}
?>