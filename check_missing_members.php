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
    
    echo "=== CHECKING FOR MISSING MEMBERS ===\n\n";
    
    // Expected member IDs from the SQL file
    $expectedMemberIds = [10033, 10034, 10035, 10036, 10037, 10038, 10039, 10040, 10041, 10042, 10043, 10044];
    
    echo "Checking for members with IDs: " . implode(', ', $expectedMemberIds) . "\n\n";
    
    foreach ($expectedMemberIds as $memberId) {
        $stmt = $pdo->prepare("SELECT * FROM members WHERE id = ?");
        $stmt->execute([$memberId]);
        $member = $stmt->fetch(PDO::FETCH_ASSOC);
        
        if ($member) {
            echo "✅ Found Member ID {$memberId}: {$member['first_name']} {$member['last_name']} ({$member['mobile_number']})\n";
        } else {
            echo "❌ Missing Member ID {$memberId}\n";
        }
    }
    
    echo "\n=== CHECKING CURRENT MEMBER COUNT AND RANGE ===\n";
    $stmt = $pdo->query("SELECT COUNT(*) as count, MIN(id) as min_id, MAX(id) as max_id FROM members");
    $result = $stmt->fetch(PDO::FETCH_ASSOC);
    echo "Total members: {$result['count']}, ID range: {$result['min_id']} - {$result['max_id']}\n\n";
    
    echo "=== ALL CURRENT MEMBERS ===\n";
    $stmt = $pdo->query("SELECT id, first_name, last_name, mobile_number, status FROM members ORDER BY id");
    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
        echo "ID: {$row['id']}, Name: {$row['first_name']} {$row['last_name']}, Mobile: {$row['mobile_number']}, Status: {$row['status']}\n";
    }
    
    echo "\n=== CHECKING CORRESPONDING USERS ===\n";
    $expectedPhones = ['09198649321', '09165210706', '09151836163', '09151836162', '09109868673', '09556778397', '09306730491', '09701678140', '09651233549', '09151836164', '09151836165', '09273001094'];
    
    foreach ($expectedPhones as $phone) {
        $stmt = $pdo->prepare("SELECT id, name, mobile_number, status FROM users WHERE mobile_number = ?");
        $stmt->execute([$phone]);
        $user = $stmt->fetch(PDO::FETCH_ASSOC);
        
        if ($user) {
            echo "✅ Found User with phone {$phone}: {$user['name']} (ID: {$user['id']}, Status: {$user['status']})\n";
        } else {
            echo "❌ Missing User with phone {$phone}\n";
        }
    }
    
} catch (PDOException $e) {
    echo "Database connection failed: " . $e->getMessage() . "\n";
}
?>