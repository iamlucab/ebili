<?php

/**
 * Script to verify that all foreign key constraints are working properly
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
    
    echo "=== Foreign Key Constraint Verification ===\n\n";
    
    // Check all foreign key constraints in the products table
    echo "1. Checking products table foreign key constraints...\n";
    
    $stmt = $pdo->query("
        SELECT 
            CONSTRAINT_NAME,
            COLUMN_NAME,
            REFERENCED_TABLE_NAME,
            REFERENCED_COLUMN_NAME
        FROM information_schema.KEY_COLUMN_USAGE 
        WHERE TABLE_SCHEMA = '$dbname' 
        AND TABLE_NAME = 'products' 
        AND REFERENCED_TABLE_NAME IS NOT NULL
    ");
    
    $constraints = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    if (empty($constraints)) {
        echo "❌ No foreign key constraints found on products table!\n";
    } else {
        echo "✅ Found " . count($constraints) . " foreign key constraints:\n";
        foreach ($constraints as $constraint) {
            echo "   - {$constraint['CONSTRAINT_NAME']}: {$constraint['COLUMN_NAME']} → {$constraint['REFERENCED_TABLE_NAME']}.{$constraint['REFERENCED_COLUMN_NAME']}\n";
        }
    }
    
    // Verify data integrity for each constraint
    echo "\n2. Verifying data integrity...\n";
    
    // Check products.created_by → users.id
    echo "\n   Checking products.created_by → users.id:\n";
    $stmt = $pdo->query("
        SELECT COUNT(*) as count 
        FROM products p 
        LEFT JOIN users u ON p.created_by = u.id 
        WHERE p.created_by IS NOT NULL AND u.id IS NULL
    ");
    $invalidCreatedBy = $stmt->fetch(PDO::FETCH_ASSOC)['count'];
    
    if ($invalidCreatedBy == 0) {
        echo "   ✅ All products.created_by references are valid\n";
    } else {
        echo "   ❌ Found $invalidCreatedBy invalid products.created_by references\n";
    }
    
    // Check products.category_id → categories.id
    echo "\n   Checking products.category_id → categories.id:\n";
    $stmt = $pdo->query("
        SELECT COUNT(*) as count 
        FROM products p 
        LEFT JOIN categories c ON p.category_id = c.id 
        WHERE p.category_id IS NOT NULL AND c.id IS NULL
    ");
    $invalidCategoryId = $stmt->fetch(PDO::FETCH_ASSOC)['count'];
    
    if ($invalidCategoryId == 0) {
        echo "   ✅ All products.category_id references are valid\n";
    } else {
        echo "   ❌ Found $invalidCategoryId invalid products.category_id references\n";
    }
    
    // Check products.unit_id → units.id
    echo "\n   Checking products.unit_id → units.id:\n";
    $stmt = $pdo->query("
        SELECT COUNT(*) as count 
        FROM products p 
        LEFT JOIN units u ON p.unit_id = u.id 
        WHERE p.unit_id IS NOT NULL AND u.id IS NULL
    ");
    $invalidUnitId = $stmt->fetch(PDO::FETCH_ASSOC)['count'];
    
    if ($invalidUnitId == 0) {
        echo "   ✅ All products.unit_id references are valid\n";
    } else {
        echo "   ❌ Found $invalidUnitId invalid products.unit_id references\n";
    }
    
    // Test constraint enforcement by trying to insert invalid data
    echo "\n3. Testing constraint enforcement...\n";
    
    try {
        // Try to insert a product with invalid created_by
        $pdo->beginTransaction();
        
        $stmt = $pdo->prepare("
            INSERT INTO products (name, description, price, created_by, created_at, updated_at) 
            VALUES (?, ?, ?, ?, NOW(), NOW())
        ");
        
        $stmt->execute([
            'Test Product',
            'Test Description',
            99.99,
            99999 // Invalid user ID
        ]);
        
        $pdo->rollback();
        echo "   ❌ Constraint enforcement failed - invalid data was accepted\n";
        
    } catch (PDOException $e) {
        $pdo->rollback();
        if (strpos($e->getMessage(), 'foreign key constraint fails') !== false) {
            echo "   ✅ Foreign key constraint is properly enforced\n";
        } else {
            echo "   ⚠️  Unexpected error: " . $e->getMessage() . "\n";
        }
    }
    
    // Summary
    echo "\n=== Summary ===\n";
    $totalIssues = $invalidCreatedBy + $invalidCategoryId + $invalidUnitId;
    
    if ($totalIssues == 0) {
        echo "✅ All foreign key constraints are working properly!\n";
        echo "✅ Your SQL import should now work without errors.\n";
    } else {
        echo "❌ Found $totalIssues data integrity issues that need to be resolved.\n";
        echo "❌ You may still encounter foreign key constraint errors during import.\n";
    }
    
    // Show current products count
    $stmt = $pdo->query("SELECT COUNT(*) as count FROM products");
    $productCount = $stmt->fetch(PDO::FETCH_ASSOC)['count'];
    echo "\nCurrent products in database: $productCount\n";
    
} catch (PDOException $e) {
    echo "Database connection failed: " . $e->getMessage() . "\n";
}