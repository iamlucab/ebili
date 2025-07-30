<?php

/**
 * Final verification script to ensure all foreign key constraints are working properly
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
    
    echo "=== Final Foreign Key Constraint Verification ===\n\n";
    
    // Get all foreign key constraints in the database
    echo "1. LISTING ALL FOREIGN KEY CONSTRAINTS\n";
    echo "======================================\n\n";
    
    $stmt = $pdo->query("
        SELECT 
            TABLE_NAME,
            COLUMN_NAME,
            CONSTRAINT_NAME,
            REFERENCED_TABLE_NAME,
            REFERENCED_COLUMN_NAME
        FROM information_schema.KEY_COLUMN_USAGE 
        WHERE TABLE_SCHEMA = '$dbname' 
        AND REFERENCED_TABLE_NAME IS NOT NULL
        ORDER BY TABLE_NAME, COLUMN_NAME
    ");
    
    $constraints = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    if (empty($constraints)) {
        echo "❌ No foreign key constraints found in the database!\n";
    } else {
        echo "✅ Found " . count($constraints) . " foreign key constraints:\n\n";
        
        $currentTable = '';
        foreach ($constraints as $constraint) {
            if ($currentTable !== $constraint['TABLE_NAME']) {
                $currentTable = $constraint['TABLE_NAME'];
                echo "Table: {$currentTable}\n";
            }
            echo "   - {$constraint['CONSTRAINT_NAME']}: {$constraint['COLUMN_NAME']} → {$constraint['REFERENCED_TABLE_NAME']}.{$constraint['REFERENCED_COLUMN_NAME']}\n";
        }
    }
    
    // Verify data integrity for each constraint
    echo "\n2. VERIFYING DATA INTEGRITY\n";
    echo "===========================\n\n";
    
    $totalIssues = 0;
    
    foreach ($constraints as $constraint) {
        $table = $constraint['TABLE_NAME'];
        $column = $constraint['COLUMN_NAME'];
        $refTable = $constraint['REFERENCED_TABLE_NAME'];
        $refColumn = $constraint['REFERENCED_COLUMN_NAME'];
        
        echo "Checking {$table}.{$column} → {$refTable}.{$refColumn}:\n";
        
        $stmt = $pdo->query("
            SELECT COUNT(*) as count 
            FROM {$table} t
            LEFT JOIN {$refTable} r ON t.{$column} = r.{$refColumn}
            WHERE t.{$column} IS NOT NULL AND r.{$refColumn} IS NULL
        ");
        
        $invalidCount = $stmt->fetch(PDO::FETCH_ASSOC)['count'];
        
        if ($invalidCount == 0) {
            echo "   ✅ All references are valid\n";
        } else {
            echo "   ❌ Found $invalidCount invalid references\n";
            $totalIssues += $invalidCount;
        }
    }
    
    // Test constraint enforcement
    echo "\n3. TESTING CONSTRAINT ENFORCEMENT\n";
    echo "=================================\n\n";
    
    $constraintTests = [
        [
            'table' => 'products',
            'data' => [
                'name' => 'Test Product',
                'description' => 'Test Description',
                'price' => 99.99,
                'created_by' => 99999 // Invalid user ID
            ],
            'expected_constraint' => 'products_created_by_foreign'
        ],
        [
            'table' => 'wallets',
            'data' => [
                'member_id' => 99999, // Invalid member ID
                'balance' => 0.00
            ],
            'expected_constraint' => 'wallets_member_id_foreign'
        ]
    ];
    
    $constraintsWorking = 0;
    
    foreach ($constraintTests as $test) {
        echo "Testing {$test['table']} constraint enforcement:\n";
        
        try {
            $pdo->beginTransaction();
            
            $columns = implode(', ', array_keys($test['data']));
            $placeholders = ':' . implode(', :', array_keys($test['data']));
            
            $stmt = $pdo->prepare("
                INSERT INTO {$test['table']} ($columns, created_at, updated_at) 
                VALUES ($placeholders, NOW(), NOW())
            ");
            
            $stmt->execute($test['data']);
            
            $pdo->rollback();
            echo "   ❌ Constraint enforcement failed - invalid data was accepted\n";
            
        } catch (PDOException $e) {
            $pdo->rollback();
            if (strpos($e->getMessage(), 'foreign key constraint fails') !== false) {
                echo "   ✅ Foreign key constraint is properly enforced\n";
                $constraintsWorking++;
            } else {
                echo "   ⚠️  Unexpected error: " . $e->getMessage() . "\n";
            }
        }
    }
    
    // Database statistics
    echo "\n4. DATABASE STATISTICS\n";
    echo "======================\n\n";
    
    $tables = ['products', 'wallets', 'members', 'users', 'orders', 'categories', 'units'];
    
    foreach ($tables as $table) {
        try {
            $stmt = $pdo->query("SELECT COUNT(*) as count FROM $table");
            $count = $stmt->fetch(PDO::FETCH_ASSOC)['count'];
            echo "- $table: $count records\n";
        } catch (PDOException $e) {
            echo "- $table: Table not found or error\n";
        }
    }
    
    // Final summary
    echo "\n=== FINAL SUMMARY ===\n";
    
    if ($totalIssues == 0) {
        echo "✅ ALL DATA INTEGRITY CHECKS PASSED!\n";
    } else {
        echo "❌ Found $totalIssues data integrity issues.\n";
    }
    
    if ($constraintsWorking == count($constraintTests)) {
        echo "✅ ALL FOREIGN KEY CONSTRAINTS ARE PROPERLY ENFORCED!\n";
    } else {
        echo "❌ Some foreign key constraints are not working properly.\n";
    }
    
    if ($totalIssues == 0 && $constraintsWorking == count($constraintTests)) {
        echo "\n🎉 SUCCESS! Your database is ready for SQL imports!\n";
        echo "🎉 All foreign key constraint errors should be resolved!\n";
    } else {
        echo "\n⚠️  There may still be issues that need to be addressed.\n";
    }
    
    echo "\nTotal foreign key constraints: " . count($constraints) . "\n";
    echo "Constraints tested: " . count($constraintTests) . "\n";
    echo "Constraints working: $constraintsWorking\n";
    
} catch (PDOException $e) {
    echo "Database connection failed: " . $e->getMessage() . "\n";
}