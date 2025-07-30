<?php
/**
 * Production Database Reset Script
 * 
 * This script resets the database for production deployment while preserving:
 * - categories
 * - migrations
 * - products
 * - settings
 * - units
 * 
 * And creates:
 * - Admin user: 09177260180 / !@#123123
 * - Member user: 09191111111 / !@#123123
 */

require_once __DIR__ . '/vendor/autoload.php';

use Illuminate\Database\Capsule\Manager as Capsule;
use Illuminate\Support\Facades\Hash;

// Load environment variables
$dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
$dotenv->load();

// Setup database connection
$capsule = new Capsule;
$capsule->addConnection([
    'driver' => 'mysql',
    'host' => $_ENV['DB_HOST'],
    'database' => $_ENV['DB_DATABASE'],
    'username' => $_ENV['DB_USERNAME'],
    'password' => $_ENV['DB_PASSWORD'],
    'charset' => 'utf8mb4',
    'collation' => 'utf8mb4_unicode_ci',
    'prefix' => '',
]);

$capsule->setAsGlobal();
$capsule->bootEloquent();

echo "🔄 Starting Production Database Reset...\n";
echo str_repeat('=', 50) . "\n";

try {
    // Tables to preserve (don't delete data)
    $preserveTables = [
        'categories',
        'migrations', 
        'products',
        'settings',
        'units'
    ];
    
    // Tables to reset (delete all data)
    $resetTables = [
        'users',
        'members',
        'orders',
        'order_items',
        'wallet_transactions',
        'cash_in_requests',
        'loans',
        'loan_payments',
        'referral_bonus_logs',
        'cashback_logs',
        'tickets',
        'ticket_replies',
        'reward_programs',
        'reward_winners',
        'membership_codes'
    ];
    
    echo "📋 Preserving data in tables: " . implode(', ', $preserveTables) . "\n";
    echo "🗑️  Resetting data in tables: " . implode(', ', $resetTables) . "\n\n";
    
    // Disable foreign key checks
    Capsule::statement('SET FOREIGN_KEY_CHECKS=0');
    
    // Reset specified tables
    foreach ($resetTables as $table) {
        if (Capsule::schema()->hasTable($table)) {
            Capsule::table($table)->truncate();
            echo "✅ Reset table: {$table}\n";
        } else {
            echo "⚠️  Table not found: {$table}\n";
        }
    }
    
    // Re-enable foreign key checks
    Capsule::statement('SET FOREIGN_KEY_CHECKS=1');
    
    echo "\n" . str_repeat('-', 30) . "\n";
    echo "👤 Creating Admin and Member accounts...\n\n";
    
    // Create Admin User
    $adminId = Capsule::table('users')->insertGetId([
        'name' => 'System Administrator',
        'email' => 'admin@ebili.online',
        'mobile_number' => '09177260180',
        'password' => password_hash('!@#123123', PASSWORD_DEFAULT),
        'role' => 'Admin',
        'status' => 'active',
        'email_verified_at' => now(),
        'created_at' => now(),
        'updated_at' => now()
    ]);
    
    echo "✅ Created Admin User:\n";
    echo "   📱 Mobile: 09177260180\n";
    echo "   🔑 Password: !@#123123\n";
    echo "   👑 Role: Admin\n\n";
    
    // Create Member User
    $memberId = Capsule::table('users')->insertGetId([
        'name' => 'Test Member',
        'email' => 'member@ebili.online',
        'mobile_number' => '09191111111',
        'password' => password_hash('!@#123123', PASSWORD_DEFAULT),
        'role' => 'Member',
        'status' => 'active',
        'email_verified_at' => now(),
        'created_at' => now(),
        'updated_at' => now()
    ]);
    
    echo "✅ Created Member User:\n";
    echo "   📱 Mobile: 09191111111\n";
    echo "   🔑 Password: !@#123123\n";
    echo "   👤 Role: Member\n\n";
    
    // Create Member Profile
    $memberProfileId = Capsule::table('members')->insertGetId([
        'first_name' => 'Test',
        'last_name' => 'Member',
        'middle_name' => '',
        'mobile_number' => '09191111111',
        'birthday' => '1990-01-01',
        'address' => 'Test Address',
        'occupation' => 'Test Occupation',
        'status' => 'approved',
        'role' => 'member',
        'sponsor_id' => null,
        'loan_eligible' => true,
        'created_at' => now(),
        'updated_at' => now()
    ]);
    
    // Update the user to link to the member
    Capsule::table('users')->where('id', $memberId)->update([
        'member_id' => $memberProfileId,
        'updated_at' => now()
    ]);
    
    echo "✅ Created Member Profile:\n";
    echo "   🆔 Member ID: {$memberProfileId}\n";
    echo "   ✅ Status: approved\n";
    echo "   🔗 Linked to User ID: {$memberId}\n\n";
    
    echo "✅ Member wallets will be created automatically via model events\n\n";
    
    // Update settings for production
    $productionSettings = [
        'app_name' => 'Ebili',
        'app_description' => 'Multi-Level Marketing Platform',
        'contact_email' => 'support@ebili.online',
        'contact_phone' => '09177260180',
        'company_address' => 'Philippines',
        'maintenance_mode' => '0',
        'registration_enabled' => '1',
        'referral_bonus_enabled' => '1',
        'cashback_enabled' => '1'
    ];
    
    foreach ($productionSettings as $key => $value) {
        Capsule::table('settings')->updateOrInsert(
            ['key' => $key],
            ['value' => $value, 'updated_at' => now()]
        );
    }
    
    echo "✅ Updated production settings\n\n";
    
    echo str_repeat('=', 50) . "\n";
    echo "🎉 Production Database Reset Complete!\n\n";
    
    echo "📊 Summary:\n";
    echo "   ✅ Preserved: categories, migrations, products, settings, units\n";
    echo "   🗑️  Reset: user data, orders, transactions, logs\n";
    echo "   👤 Created: Admin and Member accounts\n";
    echo "   ⚙️  Updated: Production settings\n\n";
    
    echo "🔐 Login Credentials:\n";
    echo "   Admin: 09177260180 / !@#123123\n";
    echo "   Member: 09191111111 / !@#123123\n\n";
    
    echo "🚀 Ready for production deployment!\n";
    
} catch (Exception $e) {
    echo "❌ Error: " . $e->getMessage() . "\n";
    echo "📍 File: " . $e->getFile() . ":" . $e->getLine() . "\n";
    exit(1);
}

function now() {
    return date('Y-m-d H:i:s');
}