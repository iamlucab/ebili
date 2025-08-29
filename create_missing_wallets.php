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
    
    echo "=== CREATING MISSING WALLETS ===\n\n";
    
    // Find users without wallets
    $stmt = $pdo->query("
        SELECT u.id as user_id, u.name, u.mobile_number, m.id as member_id
        FROM users u
        LEFT JOIN members m ON u.mobile_number = m.mobile_number
        LEFT JOIN wallets w ON u.id = w.user_id
        WHERE w.id IS NULL AND u.role = 'Member'
        ORDER BY u.id
    ");
    
    $usersWithoutWallets = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    echo "Found " . count($usersWithoutWallets) . " users without wallets:\n";
    
    foreach ($usersWithoutWallets as $user) {
        echo "- {$user['name']} (User ID: {$user['user_id']}, Member ID: {$user['member_id']})\n";
    }
    
    if (count($usersWithoutWallets) > 0) {
        echo "\nCreating wallets...\n\n";
        
        foreach ($usersWithoutWallets as $user) {
            // Generate unique wallet IDs
            $mainWalletId = 'WALLET-' . strtoupper(uniqid());
            $cashbackWalletId = 'WALLET-' . strtoupper(uniqid());
            
            try {
                // Create main wallet
                $stmt = $pdo->prepare("
                    INSERT INTO wallets (wallet_id, type, user_id, member_id, balance, created_at, updated_at)
                    VALUES (?, 'main', ?, ?, 0.00, NOW(), NOW())
                ");
                $stmt->execute([$mainWalletId, $user['user_id'], $user['member_id']]);
                
                // Create cashback wallet
                $stmt = $pdo->prepare("
                    INSERT INTO wallets (wallet_id, type, user_id, member_id, balance, created_at, updated_at)
                    VALUES (?, 'cashback', ?, ?, 0.00, NOW(), NOW())
                ");
                $stmt->execute([$cashbackWalletId, $user['user_id'], $user['member_id']]);
                
                echo "✅ Created wallets for {$user['name']}:\n";
                echo "   - Main: {$mainWalletId}\n";
                echo "   - Cashback: {$cashbackWalletId}\n\n";
                
            } catch (Exception $e) {
                echo "❌ Error creating wallets for {$user['name']}: " . $e->getMessage() . "\n\n";
            }
        }
        
        echo "=== WALLET CREATION COMPLETED ===\n\n";
        
        // Verify the results
        echo "=== VERIFICATION ===\n";
        $stmt = $pdo->query("
            SELECT 
                u.id as user_id, 
                u.name, 
                COUNT(w.id) as wallet_count,
                GROUP_CONCAT(w.type) as wallet_types
            FROM users u
            LEFT JOIN wallets w ON u.id = w.user_id
            WHERE u.role = 'Member'
            GROUP BY u.id, u.name
            ORDER BY u.id
        ");
        
        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
            echo "User: {$row['name']} (ID: {$row['user_id']}) - Wallets: {$row['wallet_count']} ({$row['wallet_types']})\n";
        }
        
    } else {
        echo "\nAll users already have wallets!\n";
    }
    
} catch (PDOException $e) {
    echo "Database connection failed: " . $e->getMessage() . "\n";
}
?>