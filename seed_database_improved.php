<?php

require_once 'vendor/autoload.php';

use Illuminate\Database\Capsule\Manager as Capsule;

// Initialize database connection
$capsule = new Capsule;
$capsule->addConnection([
    'driver' => 'mysql',
    'host' => '127.0.0.1',
    'database' => 'ebili',
    'username' => 'root',
    'password' => '',
    'charset' => 'utf8mb4',
    'collation' => 'utf8mb4_unicode_ci',
    'prefix' => '',
]);

$capsule->setAsGlobal();
$capsule->bootEloquent();

try {
    $pdo = $capsule->getConnection()->getPdo();
    
    // Read the SQL file
    $sql = file_get_contents('amigos-latest.sql');
    
    echo "Starting database seeding...\n";
    
    // Disable foreign key checks
    $pdo->exec('SET FOREIGN_KEY_CHECKS = 0');
    
    // Tables to clear and reseed
    $tablesToClear = [
        'cashback_logs',
        'cash_in_requests', 
        'categories',
        'membership_codes',
        'orders',
        'order_items',
        'products',
        'referral_bonus_logs',
        'settings',
        'units',
        'wallets',
        'wallet_transactions',
        'members',
        'users',
        'migrations'
    ];
    
    // Clear existing data from tables that will be reseeded
    foreach ($tablesToClear as $table) {
        try {
            $pdo->exec("DELETE FROM `$table`");
            echo "Cleared existing data from table '$table'\n";
        } catch (PDOException $e) {
            echo "Could not clear table '$table': " . $e->getMessage() . "\n";
        }
    }
    
    // Extract and execute INSERT statements
    preg_match_all('/INSERT INTO[^;]+;/is', $sql, $matches);
    $insertStatements = $matches[0];
    
    echo "Found " . count($insertStatements) . " INSERT statements\n";
    
    $successCount = 0;
    $errorCount = 0;
    
    foreach ($insertStatements as $statement) {
        try {
            // Reset AUTO_INCREMENT for tables if needed
            if (stripos($statement, 'INSERT INTO `members`') === 0) {
                $pdo->exec("ALTER TABLE `members` AUTO_INCREMENT = 1");
            }
            if (stripos($statement, 'INSERT INTO `users`') === 0) {
                $pdo->exec("ALTER TABLE `users` AUTO_INCREMENT = 1");
            }
            
            $pdo->exec($statement);
            $successCount++;
            
            // Extract table name for progress
            preg_match('/INSERT INTO `?(\w+)`?/i', $statement, $tableMatches);
            if (isset($tableMatches[1])) {
                echo "Inserted data into table: " . $tableMatches[1] . "\n";
            }
            
        } catch (PDOException $e) {
            echo "Error executing INSERT statement: " . $e->getMessage() . "\n";
            echo "Statement: " . substr($statement, 0, 200) . "...\n\n";
            $errorCount++;
        }
    }
    
    // Re-enable foreign key checks
    $pdo->exec('SET FOREIGN_KEY_CHECKS = 1');
    
    echo "\nDatabase seeding completed!\n";
    echo "Successful INSERT statements: $successCount\n";
    echo "Failed INSERT statements: $errorCount\n";
    
    // Verify data was inserted
    echo "\nVerifying data insertion:\n";
    $verifyTables = ['members', 'users', 'products', 'categories', 'orders'];
    foreach ($verifyTables as $table) {
        try {
            $result = $pdo->query("SELECT COUNT(*) as count FROM `$table`");
            $count = $result->fetch(PDO::FETCH_ASSOC)['count'];
            echo "Table '$table': $count records\n";
        } catch (PDOException $e) {
            echo "Could not verify table '$table': " . $e->getMessage() . "\n";
        }
    }
    
} catch (Exception $e) {
    echo "Database connection error: " . $e->getMessage() . "\n";
}