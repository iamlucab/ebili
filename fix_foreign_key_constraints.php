<?php

/**
 * Script to fix foreign key constraint issues when importing SQL files
 * This script handles the products.created_by foreign key constraint error
 */

require_once 'vendor/autoload.php';

// Database configuration - update these values according to your setup
$host = 'localhost';
$dbname = 'ebili';
$username = 'root';
$password = '';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8mb4", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    echo "Connected to database successfully.\n\n";
    
    // Step 1: Check for products with invalid created_by values
    echo "Step 1: Checking for products with invalid created_by values...\n";
    
    $stmt = $pdo->query("
        SELECT p.id, p.name, p.created_by 
        FROM products p 
        LEFT JOIN users u ON p.created_by = u.id 
        WHERE p.created_by IS NOT NULL AND u.id IS NULL
    ");
    
    $invalidProducts = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    if (empty($invalidProducts)) {
        echo "No products with invalid created_by values found.\n";
    } else {
        echo "Found " . count($invalidProducts) . " products with invalid created_by values:\n";
        foreach ($invalidProducts as $product) {
            echo "- Product ID: {$product['id']}, Name: {$product['name']}, Invalid created_by: {$product['created_by']}\n";
        }
    }
    
    // Step 2: Check if there are any users in the database
    echo "\nStep 2: Checking available users...\n";
    
    $stmt = $pdo->query("SELECT id, name, role FROM users ORDER BY id LIMIT 10");
    $users = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    if (empty($users)) {
        echo "No users found in the database.\n";
        echo "Creating a default admin user...\n";
        
        // Create a default admin user
        $stmt = $pdo->prepare("
            INSERT INTO users (name, mobile_number, email, role, password, created_at, updated_at) 
            VALUES (?, ?, ?, ?, ?, NOW(), NOW())
        ");
        
        $defaultPassword = password_hash('admin123', PASSWORD_DEFAULT);
        $stmt->execute([
            'System Admin',
            '1234567890',
            'admin@ebili.com',
            'Admin',
            $defaultPassword
        ]);
        
        $defaultUserId = $pdo->lastInsertId();
        echo "Created default admin user with ID: $defaultUserId\n";
        
    } else {
        echo "Found " . count($users) . " users in the database:\n";
        foreach ($users as $user) {
            echo "- User ID: {$user['id']}, Name: {$user['name']}, Role: {$user['role']}\n";
        }
        $defaultUserId = $users[0]['id']; // Use the first user as default
    }
    
    // Step 3: Fix invalid created_by values
    if (!empty($invalidProducts)) {
        echo "\nStep 3: Fixing invalid created_by values...\n";
        
        $stmt = $pdo->prepare("UPDATE products SET created_by = ? WHERE created_by IS NOT NULL AND created_by NOT IN (SELECT id FROM users)");
        $stmt->execute([$defaultUserId]);
        
        $affectedRows = $stmt->rowCount();
        echo "Updated $affectedRows products to use user ID: $defaultUserId\n";
    }
    
    // Step 4: Set NULL for any remaining invalid references
    echo "\nStep 4: Setting NULL for any remaining invalid references...\n";
    
    $stmt = $pdo->prepare("
        UPDATE products 
        SET created_by = NULL 
        WHERE created_by IS NOT NULL 
        AND created_by NOT IN (SELECT id FROM users)
    ");
    $stmt->execute();
    
    $nullifiedRows = $stmt->rowCount();
    if ($nullifiedRows > 0) {
        echo "Set created_by to NULL for $nullifiedRows products.\n";
    } else {
        echo "No additional products needed to be nullified.\n";
    }
    
    // Step 5: Verify the fix
    echo "\nStep 5: Verifying the fix...\n";
    
    $stmt = $pdo->query("
        SELECT COUNT(*) as count 
        FROM products p 
        LEFT JOIN users u ON p.created_by = u.id 
        WHERE p.created_by IS NOT NULL AND u.id IS NULL
    ");
    
    $remainingIssues = $stmt->fetch(PDO::FETCH_ASSOC)['count'];
    
    if ($remainingIssues == 0) {
        echo "✅ All foreign key constraint issues have been resolved!\n";
        echo "You can now safely apply the foreign key constraints.\n\n";
        
        // Step 6: Try to add the foreign key constraint
        echo "Step 6: Attempting to add the foreign key constraint...\n";
        
        try {
            // First, check if the constraint already exists
            $stmt = $pdo->query("
                SELECT CONSTRAINT_NAME 
                FROM information_schema.KEY_COLUMN_USAGE 
                WHERE TABLE_SCHEMA = '$dbname' 
                AND TABLE_NAME = 'products' 
                AND COLUMN_NAME = 'created_by' 
                AND REFERENCED_TABLE_NAME = 'users'
            ");
            
            $existingConstraint = $stmt->fetch();
            
            if ($existingConstraint) {
                echo "Foreign key constraint already exists: {$existingConstraint['CONSTRAINT_NAME']}\n";
            } else {
                $pdo->exec("
                    ALTER TABLE products 
                    ADD CONSTRAINT products_created_by_foreign 
                    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL
                ");
                echo "✅ Foreign key constraint added successfully!\n";
            }
            
        } catch (PDOException $e) {
            echo "❌ Error adding foreign key constraint: " . $e->getMessage() . "\n";
            echo "You may need to run this constraint manually after ensuring all data is clean.\n";
        }
        
    } else {
        echo "❌ Still found $remainingIssues products with invalid created_by values.\n";
        echo "Please review the data manually.\n";
    }
    
    echo "\n=== Summary ===\n";
    echo "The script has completed. If successful, you should now be able to import your SQL file without foreign key constraint errors.\n";
    
} catch (PDOException $e) {
    echo "Database connection failed: " . $e->getMessage() . "\n";
    echo "\nPlease check your database configuration in this script:\n";
    echo "- Host: $host\n";
    echo "- Database: $dbname\n";
    echo "- Username: $username\n";
    echo "- Password: " . (empty($password) ? '(empty)' : '(set)') . "\n";
}