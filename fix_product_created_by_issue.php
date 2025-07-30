<?php
require_once 'vendor/autoload.php';

// Load Laravel environment
$app = require_once 'bootstrap/app.php';
$app->make(Illuminate\Contracts\Console\Kernel::class)->bootstrap();

use Illuminate\Support\Facades\DB;
use App\Models\User;
use App\Models\Product;

echo "=== FIXING PRODUCT CREATED_BY ISSUE ===\n\n";

try {
    DB::beginTransaction();

    // 1. Check if there are any products with phone numbers in created_by field
    echo "1. Checking for products with phone numbers in created_by field...\n";
    
    $problematicProducts = DB::table('products')
        ->whereRaw('created_by REGEXP "^[0-9]{11}$"')
        ->get();
    
    if ($problematicProducts->count() > 0) {
        echo "Found {$problematicProducts->count()} products with phone numbers in created_by field:\n";
        
        foreach ($problematicProducts as $product) {
            echo "  - Product ID: {$product->id}, Name: {$product->name}, created_by: {$product->created_by}\n";
            
            // Find the user with this phone number
            $user = User::where('mobile_number', $product->created_by)->first();
            
            if ($user) {
                // Update the product with the correct user ID
                DB::table('products')
                    ->where('id', $product->id)
                    ->update(['created_by' => $user->id]);
                
                echo "    ✓ Fixed: Updated created_by from {$product->created_by} to {$user->id} (User: {$user->name})\n";
            } else {
                echo "    ✗ Error: No user found with phone number {$product->created_by}\n";
            }
        }
    } else {
        echo "No products found with phone numbers in created_by field.\n";
    }

    // 2. Check for any products with NULL created_by
    echo "\n2. Checking for products with NULL created_by field...\n";
    
    $nullCreatedByProducts = DB::table('products')
        ->whereNull('created_by')
        ->get();
    
    if ($nullCreatedByProducts->count() > 0) {
        echo "Found {$nullCreatedByProducts->count()} products with NULL created_by field:\n";
        
        // Get the first admin user as default
        $adminUser = User::where('role', 'Admin')->first();
        
        if ($adminUser) {
            foreach ($nullCreatedByProducts as $product) {
                DB::table('products')
                    ->where('id', $product->id)
                    ->update(['created_by' => $adminUser->id]);
                
                echo "  - Product ID: {$product->id}, Name: {$product->name} - Set created_by to {$adminUser->id} (Admin: {$adminUser->name})\n";
            }
        } else {
            echo "No admin user found to set as default created_by.\n";
        }
    } else {
        echo "No products found with NULL created_by field.\n";
    }

    // 3. Verify all products now have valid created_by values
    echo "\n3. Verifying all products have valid created_by values...\n";
    
    $invalidProducts = DB::table('products as p')
        ->leftJoin('users as u', 'p.created_by', '=', 'u.id')
        ->whereNull('u.id')
        ->select('p.id', 'p.name', 'p.created_by')
        ->get();
    
    if ($invalidProducts->count() > 0) {
        echo "WARNING: Found {$invalidProducts->count()} products with invalid created_by values:\n";
        foreach ($invalidProducts as $product) {
            echo "  - Product ID: {$product->id}, Name: {$product->name}, created_by: {$product->created_by}\n";
        }
    } else {
        echo "✓ All products now have valid created_by values.\n";
    }

    echo "\n=== FIX COMPLETED SUCCESSFULLY ===\n";
    
    DB::commit();
    
} catch (Exception $e) {
    DB::rollback();
    echo "ERROR: " . $e->getMessage() . "\n";
    echo "Fix rolled back.\n";
}