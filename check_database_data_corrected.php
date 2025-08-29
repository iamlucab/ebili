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
    
    echo "=== DATABASE CONNECTION SUCCESSFUL ===\n\n";
    
    echo "=== DATA COUNTS ===\n";
    $tables = ['users', 'members', 'wallets', 'wallet_transactions'];
    foreach ($tables as $table) {
        try {
            $stmt = $pdo->query("SELECT COUNT(*) as count FROM $table");
            $result = $stmt->fetch(PDO::FETCH_ASSOC);
            echo "Table '$table': " . $result['count'] . " records\n";
        } catch (Exception $e) {
            echo "Error counting records in '$table': " . $e->getMessage() . "\n";
        }
    }
    
    echo "\n=== SAMPLE DATA FROM USERS TABLE ===\n";
    try {
        $stmt = $pdo->query("SELECT id, name, email, mobile_number, role, status, created_at FROM users LIMIT 10");
        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
            echo "ID: {$row['id']}, Name: {$row['name']}, Email: {$row['email']}, Mobile: {$row['mobile_number']}, Role: {$row['role']}, Status: {$row['status']}, Created: {$row['created_at']}\n";
        }
    } catch (Exception $e) {
        echo "Error fetching users: " . $e->getMessage() . "\n";
    }
    
    echo "\n=== SAMPLE DATA FROM MEMBERS TABLE ===\n";
    try {
        $stmt = $pdo->query("SELECT id, first_name, last_name, mobile_number, role, sponsor_id, status, created_at FROM members LIMIT 10");
        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
            echo "ID: {$row['id']}, Name: {$row['first_name']} {$row['last_name']}, Mobile: {$row['mobile_number']}, Role: {$row['role']}, Sponsor ID: {$row['sponsor_id']}, Status: {$row['status']}, Created: {$row['created_at']}\n";
        }
    } catch (Exception $e) {
        echo "Error fetching members: " . $e->getMessage() . "\n";
    }
    
    echo "\n=== SAMPLE DATA FROM WALLETS TABLE ===\n";
    try {
        $stmt = $pdo->query("SELECT id, wallet_id, type, user_id, member_id, balance, created_at FROM wallets LIMIT 10");
        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
            echo "ID: {$row['id']}, Wallet ID: {$row['wallet_id']}, Type: {$row['type']}, User ID: {$row['user_id']}, Member ID: {$row['member_id']}, Balance: {$row['balance']}, Created: {$row['created_at']}\n";
        }
    } catch (Exception $e) {
        echo "Error fetching wallets: " . $e->getMessage() . "\n";
    }
    
    echo "\n=== CHECKING USER-WALLET RELATIONSHIPS ===\n";
    try {
        $stmt = $pdo->query("
            SELECT 
                u.id as user_id, 
                u.name, 
                u.mobile_number,
                u.role as user_role,
                u.status as user_status,
                w.id as wallet_id,
                w.wallet_id as wallet_code,
                w.balance,
                w.type as wallet_type
            FROM users u
            LEFT JOIN wallets w ON u.id = w.user_id
            ORDER BY u.id
            LIMIT 15
        ");
        
        echo "User-Wallet Relationships:\n";
        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
            echo sprintf("User: %s (ID: %s, Mobile: %s, Role: %s, Status: %s) | Wallet: %s (Balance: %s, Type: %s)\n",
                $row['name'],
                $row['user_id'],
                $row['mobile_number'],
                $row['user_role'],
                $row['user_status'],
                $row['wallet_code'] ?? 'No Wallet',
                $row['balance'] ?? 'N/A',
                $row['wallet_type'] ?? 'N/A'
            );
        }
    } catch (Exception $e) {
        echo "Error checking user-wallet relationships: " . $e->getMessage() . "\n";
    }
    
    echo "\n=== CHECKING MEMBER-WALLET RELATIONSHIPS ===\n";
    try {
        $stmt = $pdo->query("
            SELECT 
                m.id as member_id, 
                m.first_name,
                m.last_name,
                m.mobile_number,
                m.role as member_role,
                m.status as member_status,
                w.id as wallet_id,
                w.wallet_id as wallet_code,
                w.balance,
                w.type as wallet_type
            FROM members m
            LEFT JOIN wallets w ON m.id = w.member_id
            ORDER BY m.id
            LIMIT 15
        ");
        
        echo "Member-Wallet Relationships:\n";
        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
            echo sprintf("Member: %s %s (ID: %s, Mobile: %s, Role: %s, Status: %s) | Wallet: %s (Balance: %s, Type: %s)\n",
                $row['first_name'],
                $row['last_name'],
                $row['member_id'],
                $row['mobile_number'],
                $row['member_role'],
                $row['member_status'],
                $row['wallet_code'] ?? 'No Wallet',
                $row['balance'] ?? 'N/A',
                $row['wallet_type'] ?? 'N/A'
            );
        }
    } catch (Exception $e) {
        echo "Error checking member-wallet relationships: " . $e->getMessage() . "\n";
    }
    
    echo "\n=== CHECKING WALLET TRANSACTIONS ===\n";
    try {
        $stmt = $pdo->query("SELECT id, wallet_id, member_id, type, amount, source, description, created_at FROM wallet_transactions LIMIT 10");
        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
            echo "ID: {$row['id']}, Wallet ID: {$row['wallet_id']}, Member ID: {$row['member_id']}, Type: {$row['type']}, Amount: {$row['amount']}, Source: {$row['source']}, Description: {$row['description']}, Created: {$row['created_at']}\n";
        }
    } catch (Exception $e) {
        echo "Error fetching wallet transactions: " . $e->getMessage() . "\n";
    }
    
    echo "\n=== CHECKING FOR ORPHANED RECORDS ===\n";
    
    // Check for wallets without users or members
    try {
        $stmt = $pdo->query("SELECT COUNT(*) as count FROM wallets WHERE user_id IS NULL AND member_id IS NULL");
        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        echo "Wallets without user_id or member_id: " . $result['count'] . "\n";
        
        if ($result['count'] > 0) {
            $stmt = $pdo->query("SELECT id, wallet_id, balance FROM wallets WHERE user_id IS NULL AND member_id IS NULL LIMIT 5");
            echo "Sample orphaned wallets:\n";
            while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                echo "  Wallet ID: {$row['id']}, Code: {$row['wallet_id']}, Balance: {$row['balance']}\n";
            }
        }
    } catch (Exception $e) {
        echo "Error checking orphaned wallets: " . $e->getMessage() . "\n";
    }
    
} catch (PDOException $e) {
    echo "Database connection failed: " . $e->getMessage() . "\n";
}
?>