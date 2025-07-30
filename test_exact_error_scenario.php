<?php
require_once 'vendor/autoload.php';

// Load Laravel environment
$app = require_once 'bootstrap/app.php';
$app->make(Illuminate\Contracts\Console\Kernel::class)->bootstrap();

use App\Models\Product;
use Illuminate\Support\Facades\DB;

echo "=== TESTING EXACT ERROR SCENARIO ===\n\n";

try {
    DB::beginTransaction();
    
    echo "Attempting to create the exact product from the error message...\n";
    
    // This is the exact data from the SQL error, but using our new mutator
    $product = Product::create([
        'name' => 'This is for Staff Product',
        'description' => 'This is the description of the product that is uploaded by the staff.',
        'price' => 120,
        'cashback_amount' => 10,
        'cashback_max_level' => 3,
        'cashback_level_bonuses' => [],
        'stock_quantity' => 10,
        'category_id' => 1,
        'unit_id' => 1,
        'thumbnail' => 'products/thumbnails/nsKi55metjBE75Fl3oHSaGckUyoc0haXKuumlYoy.webp',
        'discount_value' => 10,
        'discount_type' => 'flat',
        'promo_code' => 'PROMO10',
        'gallery' => ["products/gallery/6BjfTtydYvTtTJmAJhKoyouDC61AGH40PYVeWCEA.png","products/gallery/SdTXQEc20qoQNJ1aesYLKeQ4ZDUbzf6yC0spIBrO.png","products/gallery/qFT0JcROmWMJisqAPp73jpoilhQRG8L1PwzcExd3.png","products/gallery/r0aPf7xjIofzPbAfOx81aMcLMLoczQgF617gDJ3Y.png","products/gallery/oOIt5RNVRWqjqe7b04AeBOaeOSOBLM64t5X2h3x2.png"],
        'created_by' => '09192222222', // This was the problematic value - now it should work!
    ]);
    
    echo "✓ SUCCESS! Product created with ID: {$product->id}\n";
    echo "  - Name: {$product->name}\n";
    echo "  - Original created_by value: 09192222222 (phone number)\n";
    echo "  - Converted created_by value: {$product->created_by} (user ID)\n";
    
    // Verify the foreign key relationship works
    $creator = $product->creator;
    if ($creator) {
        echo "  - Creator: {$creator->name} (Phone: {$creator->mobile_number})\n";
        echo "  ✓ Foreign key relationship working correctly!\n";
    } else {
        echo "  ✗ Foreign key relationship failed!\n";
    }
    
    // Verify the product was actually saved to database
    $savedProduct = Product::find($product->id);
    if ($savedProduct) {
        echo "  ✓ Product successfully saved to database!\n";
        echo "  - Database created_by value: {$savedProduct->created_by}\n";
    } else {
        echo "  ✗ Product not found in database!\n";
    }
    
    echo "\n=== ORIGINAL ERROR SCENARIO NOW WORKS! ===\n";
    echo "The foreign key constraint violation has been resolved.\n";
    echo "Phone numbers in created_by field are automatically converted to user IDs.\n";
    
    DB::commit();
    
} catch (Exception $e) {
    DB::rollback();
    echo "ERROR: " . $e->getMessage() . "\n";
    echo "Stack trace: " . $e->getTraceAsString() . "\n";
}