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
    
    // Check if tables exist
    $tables = ['users', 'members', 'wallets', 'wallet_transactions'];
    
    echo "=== CHECKING TABLE EXISTENCE ===\n";
    foreach ($tables as $table) {
        $stmt = $pdo->query("SHOW TABLES LIKE '$table'");
        if ($stmt->rowCount() > 0) {
            echo "✓ Table '$table' exists\n";
        } else {
            echo "✗ Table '$table' does NOT exist\n";
        }
    }
    
    echo "\n=== CHECKING TABLE STRUCTURES ===\n";
    foreach ($tables as $table) {
        try {
            $stmt = $pdo->query("DESCRIBE $table");
            echo "\n--- Structure of '$table' table ---\n";
            while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                echo sprintf("%-20s %-15s %-10s %-10s %-15s %s\n", 
                    $row['Field'], 
                    $row['Type'], 
                    $row['Null'], 
                    $row['Key'], 
                    $row['Default'], 
                    $row['Extra']
                );
            }
        } catch (Exception $e) {
            echo "Error describing table '$table': " . $e->getMessage() . "\n";
        }
    }
    
    echo "\n=== CHECKING DATA COUNTS ===\n";
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
        $stmt = $pdo->query("SELECT id, name, email, phone, created_at FROM users LIMIT 5");
        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
            echo "ID: {$row['id']}, Name: {$row['name']}, Email: {$row['email']}, Phone: {$row['phone']}, Created: {$row['created_at']}\n";
        }
    } catch (Exception $e) {
        echo "Error fetching users: " . $e->getMessage() . "\n";
    }
    
    echo "\n=== SAMPLE DATA FROM MEMBERS TABLE ===\n";
    try {
        $stmt = $pdo->query("SELECT id, user_id, member_id, sponsor_id, status, created_at FROM members LIMIT 5");
        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
            echo "ID: {$row['id']}, User ID: {$row['user_id']}, Member ID: {$row['member_id']}, Sponsor ID: {$row['sponsor_id']}, Status: {$row['status']}, Created: {$row['created_at']}\n";
        }
    } catch (Exception $e) {
        echo "Error fetching members: " . $e->getMessage() . "\n";
    }
    
    echo "\n=== SAMPLE DATA FROM WALLETS TABLE ===\n";
    try {
        $stmt = $pdo->query("SELECT id, user_id, balance, created_at FROM wallets LIMIT 5");
        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
            echo "ID: {$row['id']}, User ID: {$row['user_id']}, Balance: {$row['balance']}, Created: {$row['created_at']}\n";
        }
    } catch (Exception $e) {
        echo "Error fetching wallets: " . $e->getMessage() . "\n";
    }
    
    echo "\n=== CHECKING FOR FOREIGN KEY RELATIONSHIPS ===\n";
    try {
        $stmt = $pdo->query("
            SELECT 
                u.id as user_id, 
                u.name, 
                u.email,
                m.id as member_id,
                m.member_id as member_code,
                m.status as member_status,
                w.id as wallet_id,
                w.balance
            FROM users u
            LEFT JOIN members m ON u.id = m.user_id
            LEFT JOIN wallets w ON u.id = w.user_id
            LIMIT 10
        ");
        
        echo "User-Member-Wallet Relationships:\n";
        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
            echo sprintf("User: %s (%s) | Member: %s (%s) | Wallet: %s (Balance: %s)\n",
                $row['name'],
                $row['user_id'],
                $row['member_code'] ?? 'No Member',
                $row['member_status'] ?? 'N/A',
                $row['wallet_id'] ?? 'No Wallet',
                $row['balance'] ?? 'N/A'
            );
        }
    } catch (Exception $e) {
        echo "Error checking relationships: " . $e->getMessage() . "\n";
    }
    
} catch (PDOException $e) {
    echo "Database connection failed: " . $e->getMessage() . "\n";
}
?>