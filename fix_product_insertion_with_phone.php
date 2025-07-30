<?php
require_once 'vendor/autoload.php';

// Load Laravel environment
$app = require_once 'bootstrap/app.php';
$app->make(Illuminate\Contracts\Console\Kernel::class)->bootstrap();

use Illuminate\Support\Facades\DB;
use App\Models\User;
use App\Models\Product;

echo "=== FIXING PRODUCT INSERTION WITH PHONE NUMBER ===\n\n";

try {
    // The specific case from the error message
    $phoneNumber = '09192222222';
    
    echo "1. Looking up user with phone number: {$phoneNumber}\n";
    
    $user = User::where('mobile_number', $phoneNumber)->first();
    
    if ($user) {
        echo "✓ User found: ID {$user->id}, Name: {$user->name}\n";
        
        // Now let's try to create the product with the correct user ID
        echo "\n2. Creating the product that failed with correct user ID...\n";
        
        $productData = [
            'name' => 'This is for Staff Product',
            'description' => 'This is the description of the product that is uploaded by the staff.',
            'price' => 120.00,
            'cashback_amount' => 10.00,
            'cashback_max_level' => 3,
            'cashback_level_bonuses' => [],
            'stock_quantity' => 10,
            'category_id' => 1,
            'unit_id' => 1,
            'thumbnail' => 'products/thumbnails/nsKi55metjBE75Fl3oHSaGckUyoc0haXKuumlYoy.webp',
            'discount_value' => 10.00,
            'discount_type' => 'flat',
            'promo_code' => 'PROMO10',
            'gallery' => ["products/gallery/6BjfTtydYvTtTJmAJhKoyouDC61AGH40PYVeWCEA.png","products/gallery/SdTXQEc20qoQNJ1aesYLKeQ4ZDUbzf6yC0spIBrO.png","products/gallery/qFT0JcROmWMJisqAPp73jpoilhQRG8L1PwzcExd3.png","products/gallery/r0aPf7xjIofzPbAfOx81aMcLMLoczQgF617gDJ3Y.png","products/gallery/oOIt5RNVRWqjqe7b04AeBOaeOSOBLM64t5X2h3x2.png"],
            'created_by' => $user->id, // Use the correct user ID instead of phone number
        ];
        
        // Check if this product already exists
        $existingProduct = Product::where('name', $productData['name'])
            ->where('created_by', $user->id)
            ->first();
        
        if ($existingProduct) {
            echo "Product already exists with ID: {$existingProduct->id}\n";
        } else {
            $product = Product::create($productData);
            echo "✓ Product created successfully with ID: {$product->id}\n";
            echo "  - Name: {$product->name}\n";
            echo "  - Created by: User ID {$product->created_by} ({$user->name})\n";
        }
        
    } else {
        echo "✗ No user found with phone number: {$phoneNumber}\n";
        echo "Please ensure the user exists before creating products.\n";
    }
    
    echo "\n=== PRODUCT INSERTION FIX COMPLETED ===\n";
    
} catch (Exception $e) {
    echo "ERROR: " . $e->getMessage() . "\n";
    echo "Stack trace: " . $e->getTraceAsString() . "\n";
}