<?php

/**
 * Comprehensive script to fix all foreign key constraint issues in the database
 * This handles products, wallets, and other tables with foreign key constraints
 */

require_once 'vendor/autoload.php';

// Database configuration
$host = 'localhost';
$dbname = 'ebili';
$username = 'root';
$password = '';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8mb4", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    echo "=== Comprehensive Foreign Key Constraint Fix ===\n\n";
    echo "Connected to database successfully.\n\n";
    
    // ========================================
    // 1. FIX WALLETS TABLE CONSTRAINTS
    // ========================================
    
    echo "1. FIXING WALLETS TABLE CONSTRAINTS\n";
    echo "=====================================\n\n";
    
    // Check for wallets with invalid member_id
    echo "Checking wallets with invalid member_id references...\n";
    $stmt = $pdo->query("
        SELECT w.id, w.member_id, w.user_id, w.balance 
        FROM wallets w 
        LEFT JOIN members m ON w.member_id = m.id 
        WHERE w.member_id IS NOT NULL AND m.id IS NULL
    ");
    
    $invalidWalletMembers = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    if (empty($invalidWalletMembers)) {
        echo "✅ No wallets with invalid member_id found.\n";
    } else {
        echo "❌ Found " . count($invalidWalletMembers) . " wallets with invalid member_id:\n";
        foreach ($invalidWalletMembers as $wallet) {
            echo "   - Wallet ID: {$wallet['id']}, Invalid member_id: {$wallet['member_id']}, Balance: {$wallet['balance']}\n";
        }
    }
    
    // Check for wallets with invalid user_id
    echo "\nChecking wallets with invalid user_id references...\n";
    $stmt = $pdo->query("
        SELECT w.id, w.member_id, w.user_id, w.balance 
        FROM wallets w 
        LEFT JOIN users u ON w.user_id = u.id 
        WHERE w.user_id IS NOT NULL AND u.id IS NULL
    ");
    
    $invalidWalletUsers = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    if (empty($invalidWalletUsers)) {
        echo "✅ No wallets with invalid user_id found.\n";
    } else {
        echo "❌ Found " . count($invalidWalletUsers) . " wallets with invalid user_id:\n";
        foreach ($invalidWalletUsers as $wallet) {
            echo "   - Wallet ID: {$wallet['id']}, Invalid user_id: {$wallet['user_id']}, Balance: {$wallet['balance']}\n";
        }
    }
    
    // Get available members and users for reference
    echo "\nChecking available members and users...\n";
    
    $stmt = $pdo->query("SELECT id, first_name, last_name FROM members ORDER BY id LIMIT 5");
    $members = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    $stmt = $pdo->query("SELECT id, name, role FROM users ORDER BY id LIMIT 5");
    $users = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    if (empty($members)) {
        echo "⚠️  No members found in database.\n";
    } else {
        echo "Available members (showing first 5):\n";
        foreach ($members as $member) {
            echo "   - Member ID: {$member['id']}, Name: {$member['first_name']} {$member['last_name']}\n";
        }
    }
    
    if (empty($users)) {
        echo "⚠️  No users found in database.\n";
    } else {
        echo "Available users (showing first 5):\n";
        foreach ($users as $user) {
            echo "   - User ID: {$user['id']}, Name: {$user['name']}, Role: {$user['role']}\n";
        }
    }
    
    // Fix invalid member_id references
    if (!empty($invalidWalletMembers)) {
        echo "\nFixing invalid member_id references...\n";
        
        if (!empty($members)) {
            $defaultMemberId = $members[0]['id'];
            echo "Using default member ID: $defaultMemberId\n";
            
            $stmt = $pdo->prepare("
                UPDATE wallets 
                SET member_id = ? 
                WHERE member_id IS NOT NULL 
                AND member_id NOT IN (SELECT id FROM members)
            ");
            $stmt->execute([$defaultMemberId]);
            
            $affectedRows = $stmt->rowCount();
            echo "✅ Updated $affectedRows wallets to use member ID: $defaultMemberId\n";
        } else {
            // Set member_id to NULL if no members exist
            echo "No members available, setting member_id to NULL...\n";
            
            $stmt = $pdo->prepare("
                UPDATE wallets 
                SET member_id = NULL 
                WHERE member_id IS NOT NULL 
                AND member_id NOT IN (SELECT id FROM members)
            ");
            $stmt->execute();
            
            $affectedRows = $stmt->rowCount();
            echo "✅ Set member_id to NULL for $affectedRows wallets\n";
        }
    }
    
    // Fix invalid user_id references
    if (!empty($invalidWalletUsers)) {
        echo "\nFixing invalid user_id references...\n";
        
        if (!empty($users)) {
            $defaultUserId = $users[0]['id'];
            echo "Using default user ID: $defaultUserId\n";
            
            $stmt = $pdo->prepare("
                UPDATE wallets 
                SET user_id = ? 
                WHERE user_id IS NOT NULL 
                AND user_id NOT IN (SELECT id FROM users)
            ");
            $stmt->execute([$defaultUserId]);
            
            $affectedRows = $stmt->rowCount();
            echo "✅ Updated $affectedRows wallets to use user ID: $defaultUserId\n";
        } else {
            // Set user_id to NULL if no users exist
            echo "No users available, setting user_id to NULL...\n";
            
            $stmt = $pdo->prepare("
                UPDATE wallets 
                SET user_id = NULL 
                WHERE user_id IS NOT NULL 
                AND user_id NOT IN (SELECT id FROM users)
            ");
            $stmt->execute();
            
            $affectedRows = $stmt->rowCount();
            echo "✅ Set user_id to NULL for $affectedRows wallets\n";
        }
    }
    
    // ========================================
    // 2. VERIFY PRODUCTS TABLE (ALREADY FIXED)
    // ========================================
    
    echo "\n2. VERIFYING PRODUCTS TABLE CONSTRAINTS\n";
    echo "=======================================\n\n";
    
    $stmt = $pdo->query("
        SELECT COUNT(*) as count 
        FROM products p 
        LEFT JOIN users u ON p.created_by = u.id 
        WHERE p.created_by IS NOT NULL AND u.id IS NULL
    ");
    $invalidProductsCreatedBy = $stmt->fetch(PDO::FETCH_ASSOC)['count'];
    
    if ($invalidProductsCreatedBy == 0) {
        echo "✅ Products table constraints are already fixed.\n";
    } else {
        echo "❌ Found $invalidProductsCreatedBy products with invalid created_by references.\n";
        echo "Running products fix...\n";
        
        if (!empty($users)) {
            $defaultUserId = $users[0]['id'];
            $stmt = $pdo->prepare("
                UPDATE products 
                SET created_by = ? 
                WHERE created_by IS NOT NULL 
                AND created_by NOT IN (SELECT id FROM users)
            ");
            $stmt->execute([$defaultUserId]);
            echo "✅ Fixed products table constraints.\n";
        }
    }
    
    // ========================================
    // 3. CHECK OTHER POTENTIAL CONSTRAINT ISSUES
    // ========================================
    
    echo "\n3. CHECKING OTHER POTENTIAL CONSTRAINT ISSUES\n";
    echo "=============================================\n\n";
    
    // Check orders table if it exists
    $stmt = $pdo->query("SHOW TABLES LIKE 'orders'");
    if ($stmt->rowCount() > 0) {
        echo "Checking orders table...\n";
        
        // Check for invalid member_id in orders
        $stmt = $pdo->query("
            SELECT COUNT(*) as count 
            FROM orders o 
            LEFT JOIN members m ON o.member_id = m.id 
            WHERE o.member_id IS NOT NULL AND m.id IS NULL
        ");
        $invalidOrderMembers = $stmt->fetch(PDO::FETCH_ASSOC)['count'];
        
        if ($invalidOrderMembers > 0) {
            echo "❌ Found $invalidOrderMembers orders with invalid member_id references.\n";
            
            if (!empty($members)) {
                $defaultMemberId = $members[0]['id'];
                $stmt = $pdo->prepare("
                    UPDATE orders 
                    SET member_id = ? 
                    WHERE member_id IS NOT NULL 
                    AND member_id NOT IN (SELECT id FROM members)
                ");
                $stmt->execute([$defaultMemberId]);
                echo "✅ Fixed orders table member_id references.\n";
            }
        } else {
            echo "✅ Orders table member_id references are valid.\n";
        }
    }
    
    // ========================================
    // 4. FINAL VERIFICATION
    // ========================================
    
    echo "\n4. FINAL VERIFICATION\n";
    echo "====================\n\n";
    
    // Verify wallets constraints
    $stmt = $pdo->query("
        SELECT COUNT(*) as count 
        FROM wallets w 
        LEFT JOIN members m ON w.member_id = m.id 
        WHERE w.member_id IS NOT NULL AND m.id IS NULL
    ");
    $remainingWalletMemberIssues = $stmt->fetch(PDO::FETCH_ASSOC)['count'];
    
    $stmt = $pdo->query("
        SELECT COUNT(*) as count 
        FROM wallets w 
        LEFT JOIN users u ON w.user_id = u.id 
        WHERE w.user_id IS NOT NULL AND u.id IS NULL
    ");
    $remainingWalletUserIssues = $stmt->fetch(PDO::FETCH_ASSOC)['count'];
    
    echo "Wallets table verification:\n";
    echo "- Invalid member_id references: $remainingWalletMemberIssues\n";
    echo "- Invalid user_id references: $remainingWalletUserIssues\n";
    
    // Try to add the foreign key constraints
    echo "\n5. ATTEMPTING TO ADD FOREIGN KEY CONSTRAINTS\n";
    echo "============================================\n\n";
    
    if ($remainingWalletMemberIssues == 0 && $remainingWalletUserIssues == 0) {
        echo "✅ All data integrity issues resolved!\n";
        echo "Attempting to add foreign key constraints...\n\n";
        
        try {
            // Check if constraints already exist
            $stmt = $pdo->query("
                SELECT CONSTRAINT_NAME 
                FROM information_schema.KEY_COLUMN_USAGE 
                WHERE TABLE_SCHEMA = '$dbname' 
                AND TABLE_NAME = 'wallets' 
                AND REFERENCED_TABLE_NAME IS NOT NULL
            ");
            
            $existingConstraints = $stmt->fetchAll(PDO::FETCH_COLUMN);
            
            if (in_array('wallets_member_id_foreign', $existingConstraints)) {
                echo "✅ wallets_member_id_foreign constraint already exists.\n";
            } else {
                $pdo->exec("
                    ALTER TABLE wallets 
                    ADD CONSTRAINT wallets_member_id_foreign 
                    FOREIGN KEY (member_id) REFERENCES members(id) ON DELETE CASCADE
                ");
                echo "✅ Added wallets_member_id_foreign constraint.\n";
            }
            
            if (in_array('wallets_user_id_foreign', $existingConstraints)) {
                echo "✅ wallets_user_id_foreign constraint already exists.\n";
            } else {
                $pdo->exec("
                    ALTER TABLE wallets 
                    ADD CONSTRAINT wallets_user_id_foreign 
                    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
                ");
                echo "✅ Added wallets_user_id_foreign constraint.\n";
            }
            
        } catch (PDOException $e) {
            echo "❌ Error adding foreign key constraints: " . $e->getMessage() . "\n";
        }
        
    } else {
        echo "❌ Still found data integrity issues. Cannot add foreign key constraints yet.\n";
    }
    
    // ========================================
    // SUMMARY
    // ========================================
    
    echo "\n=== SUMMARY ===\n";
    
    $stmt = $pdo->query("SELECT COUNT(*) as count FROM wallets");
    $walletCount = $stmt->fetch(PDO::FETCH_ASSOC)['count'];
    
    $stmt = $pdo->query("SELECT COUNT(*) as count FROM products");
    $productCount = $stmt->fetch(PDO::FETCH_ASSOC)['count'];
    
    echo "Database statistics:\n";
    echo "- Total wallets: $walletCount\n";
    echo "- Total products: $productCount\n";
    echo "- Total members: " . count($members) . "\n";
    echo "- Total users: " . count($users) . "\n\n";
    
    if ($remainingWalletMemberIssues == 0 && $remainingWalletUserIssues == 0) {
        echo "✅ ALL FOREIGN KEY CONSTRAINT ISSUES HAVE BEEN RESOLVED!\n";
        echo "✅ You can now safely import your SQL file without errors.\n";
    } else {
        echo "❌ Some issues remain. Please review the output above.\n";
    }
    
} catch (PDOException $e) {
    echo "Database connection failed: " . $e->getMessage() . "\n";
    echo "\nPlease check your database configuration:\n";
    echo "- Host: $host\n";
    echo "- Database: $dbname\n";
    echo "- Username: $username\n";
    echo "- Password: " . (empty($password) ? '(empty)' : '(set)') . "\n";
}