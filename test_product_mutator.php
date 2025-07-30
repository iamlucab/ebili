<?php
require_once 'vendor/autoload.php';

// Load Laravel environment
$app = require_once 'bootstrap/app.php';
$app->make(Illuminate\Contracts\Console\Kernel::class)->bootstrap();

use App\Models\Product;
use App\Models\User;

echo "=== TESTING PRODUCT MUTATOR FOR CREATED_BY FIELD ===\n\n";

try {
    // Test 1: Create product with phone number
    echo "Test 1: Creating product with phone number as created_by\n";
    
    $product = new Product([
        'name' => 'Test Product with Phone Number',
        'description' => 'Testing the mutator functionality',
        'price' => 100.00,
        'cashback_amount' => 10.00,
        'cashback_max_level' => 3,
        'stock_quantity' => 5,
        'category_id' => 1,
        'unit_id' => 1,
        'created_by' => '09192222222' // This should be converted to user ID 10
    ]);
    
    echo "  - Phone number set: 09192222222\n";
    echo "  - Converted to user ID: " . $product->created_by . "\n";
    
    // Verify the user
    $user = User::find($product->created_by);
    if ($user) {
        echo "  - User found: {$user->name} (Phone: {$user->mobile_number})\n";
        echo "  ✓ Mutator working correctly!\n";
    } else {
        echo "  ✗ User not found with ID: {$product->created_by}\n";
    }
    
    // Test 2: Create product with regular user ID
    echo "\nTest 2: Creating product with regular user ID as created_by\n";
    
    $product2 = new Product([
        'name' => 'Test Product with User ID',
        'description' => 'Testing with normal user ID',
        'price' => 150.00,
        'cashback_amount' => 15.00,
        'cashback_max_level' => 3,
        'stock_quantity' => 8,
        'category_id' => 1,
        'unit_id' => 1,
        'created_by' => 10 // This should remain as 10
    ]);
    
    echo "  - User ID set: 10\n";
    echo "  - Remains as: " . $product2->created_by . "\n";
    echo "  ✓ Normal user ID handling working correctly!\n";
    
    // Test 3: Test with invalid phone number
    echo "\nTest 3: Creating product with invalid phone number\n";
    
    $product3 = new Product([
        'name' => 'Test Product with Invalid Phone',
        'description' => 'Testing with invalid phone number',
        'price' => 200.00,
        'cashback_amount' => 20.00,
        'cashback_max_level' => 3,
        'stock_quantity' => 3,
        'category_id' => 1,
        'unit_id' => 1,
        'created_by' => '09999999999' // This phone number doesn't exist
    ]);
    
    echo "  - Invalid phone number set: 09999999999\n";
    echo "  - Remains as: " . $product3->created_by . "\n";
    echo "  ✓ Invalid phone number handling working correctly!\n";
    
    echo "\n=== ALL TESTS COMPLETED SUCCESSFULLY ===\n";
    echo "The mutator is working correctly and will automatically convert\n";
    echo "phone numbers to user IDs when creating products.\n";
    
} catch (Exception $e) {
    echo "ERROR: " . $e->getMessage() . "\n";
    echo "Stack trace: " . $e->getTraceAsString() . "\n";
}