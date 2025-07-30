<?php
require_once 'vendor/autoload.php';

// Load Laravel environment
$app = require_once 'bootstrap/app.php';
$app->make(Illuminate\Contracts\Console\Kernel::class)->bootstrap();

use Illuminate\Support\Facades\DB;
use App\Models\Order;
use App\Models\OrderItem;
use App\Models\Product;
use App\Models\Category;
use App\Models\Unit;
use App\Models\Setting;

echo "=== ORDERS & PRODUCTS INTEGRATION ===\n\n";

try {
    DB::beginTransaction();

    // 1. Insert new categories (if not exists)
    echo "1. Integrating Categories...\n";
    
    $newCategories = [
        ['id' => 1, 'name' => 'Food', 'image' => 'categories/rWZrwUJzdLTA5WtJXpQAW18Mgr6Cnk61lAi6zI97.png', 'created_at' => null, 'updated_at' => '2025-07-27 09:07:26'],
        ['id' => 2, 'name' => 'Drinks', 'image' => 'categories/QozCmGzNmJxrP7Pdif0kVJSibVLeCWoQrm9Dek46.png', 'created_at' => null, 'updated_at' => '2025-07-27 09:07:37'],
        ['id' => 3, 'name' => 'Household', 'image' => 'categories/vLdecr5DzUlVg2s94EwdMLE4UnZlSsnA79ytMc8S.png', 'created_at' => null, 'updated_at' => '2025-07-27 09:07:49'],
        ['id' => 4, 'name' => 'Apparels', 'image' => 'categories/D6rSkTiAZ72G0QEqDb0wY91wZ3UL1yotRJJi9uvX.png', 'created_at' => null, 'updated_at' => '2025-07-27 09:08:02'],
        ['id' => 5, 'name' => 'Health & Beauty', 'image' => 'categories/YCEC4arKIzYkREbP1gVLjkzJGhyMJfn3YGezYSh3.png', 'created_at' => null, 'updated_at' => '2025-07-27 09:08:11'],
        ['id' => 6, 'name' => 'Electronics', 'image' => 'categories/xHfHEM9pvhCVMTGmIGyiB2wNDOqCQrD97aipQ2QV.png', 'created_at' => null, 'updated_at' => '2025-07-27 09:08:21'],
        ['id' => 7, 'name' => 'Sports & Outdoors', 'image' => 'categories/EsuiDByKuMUtyAPMTlDBWUtxeFXV2oYxjvbLKs5c.png', 'created_at' => null, 'updated_at' => '2025-07-27 09:08:30'],
        ['id' => 8, 'name' => 'Toys & Games', 'image' => 'categories/znPxQ9sIm0uVdyBDlQUY3Xnp7gItpAW6Awo3mNI1.png', 'created_at' => null, 'updated_at' => '2025-07-27 09:08:37'],
        ['id' => 9, 'name' => 'Books & Stationery', 'image' => 'categories/2XM5PUVGBuJmdoOM8iNnk2IgNBiaaQ1ty1geVNOt.png', 'created_at' => null, 'updated_at' => '2025-07-27 09:08:45'],
        ['id' => 10, 'name' => 'Automotive', 'image' => 'categories/eQ8DUo7Dd6ojyrwmP1I3I7fB6iE9pr9Cmji9AepK.png', 'created_at' => null, 'updated_at' => '2025-07-27 09:09:00'],
        ['id' => 11, 'name' => 'Pets', 'image' => 'categories/nsxnZ7xEJLMK7lyeh7TZ2QN9kZQ6N41pJzOjC3sk.png', 'created_at' => null, 'updated_at' => '2025-07-27 09:09:13'],
        ['id' => 12, 'name' => 'Gardening', 'image' => 'categories/0DapSHhf7KEz7u7iRgRYWz79YIh6IOOBz5YOxym2.png', 'created_at' => null, 'updated_at' => '2025-07-27 09:09:23'],
        ['id' => 13, 'name' => 'Office Supplies', 'image' => 'categories/YW5pOw8woCkfpg3MS5yP3n0T6tPQfyrPbZ1S92D3.png', 'created_at' => null, 'updated_at' => '2025-07-27 09:09:31'],
        ['id' => 14, 'name' => 'Jewelry & Accessories', 'image' => 'categories/rOlXUczIDXI8rVztSmpoxLS3SnVuRuIfBH4YWpaJ.png', 'created_at' => null, 'updated_at' => '2025-07-27 09:09:40'],
        ['id' => 15, 'name' => 'Music & Movies', 'image' => 'categories/pMyHm22nOotLPO9f2nGDQ0b1T7Pufliy09GeXxf6.png', 'created_at' => null, 'updated_at' => '2025-07-27 09:09:49']
    ];

    foreach ($newCategories as $categoryData) {
        if (!Category::where('id', $categoryData['id'])->exists() && !Category::where('name', $categoryData['name'])->exists()) {
            Category::create($categoryData);
            echo "  - Added category: {$categoryData['name']} (ID: {$categoryData['id']})\n";
        } else {
            echo "  - Skipped category: {$categoryData['name']} (already exists)\n";
        }
    }

    // 2. Insert new units (if not exists)
    echo "\n2. Integrating Units...\n";
    
    $newUnits = [
        ['id' => 1, 'name' => 'Piece', 'created_at' => null, 'updated_at' => null],
        ['id' => 2, 'name' => 'Kilogram', 'created_at' => null, 'updated_at' => null],
        ['id' => 3, 'name' => 'Liter', 'created_at' => null, 'updated_at' => null],
        ['id' => 4, 'name' => 'Box', 'created_at' => null, 'updated_at' => null],
        ['id' => 5, 'name' => 'Pack', 'created_at' => null, 'updated_at' => null],
        ['id' => 6, 'name' => 'Dozen', 'created_at' => null, 'updated_at' => null],
        ['id' => 7, 'name' => 'Set', 'created_at' => null, 'updated_at' => null],
        ['id' => 8, 'name' => 'Meter', 'created_at' => null, 'updated_at' => null],
        ['id' => 9, 'name' => 'Gram', 'created_at' => null, 'updated_at' => null],
        ['id' => 10, 'name' => 'Milliliter', 'created_at' => null, 'updated_at' => null],
        ['id' => 11, 'name' => 'Yard', 'created_at' => null, 'updated_at' => null],
        ['id' => 12, 'name' => 'Foot', 'created_at' => null, 'updated_at' => null],
        ['id' => 13, 'name' => 'Inch', 'created_at' => null, 'updated_at' => null],
        ['id' => 14, 'name' => 'Pound', 'created_at' => null, 'updated_at' => null],
        ['id' => 15, 'name' => 'Ounce', 'created_at' => null, 'updated_at' => null]
    ];

    foreach ($newUnits as $unitData) {
        if (!Unit::where('id', $unitData['id'])->exists() && !Unit::where('name', $unitData['name'])->exists()) {
            Unit::create($unitData);
            echo "  - Added unit: {$unitData['name']} (ID: {$unitData['id']})\n";
        } else {
            echo "  - Skipped unit: {$unitData['name']} (already exists)\n";
        }
    }

    // 3. Insert new products
    echo "\n3. Integrating Products...\n";
    
    $newProducts = [
        [
            'id' => 5,
            'name' => 'BENCH Mens Tshirt Branded Overrun',
            'description' => 'Mens Tshirt Branded Overrun',
            'price' => 120.00,
            'cashback_amount' => 20.00,
            'cashback_max_level' => 3,
            'cashback_level_bonuses' => '[]',
            'discount_value' => 10.00,
            'discount_type' => 'flat',
            'promo_code' => 'PROMO10',
            'stock_quantity' => 10,
            'image' => null,
            'active' => 1,
            'created_at' => '2025-07-28 06:48:03',
            'updated_at' => '2025-07-28 06:48:03',
            'thumbnail' => 'products/thumbnails/fXnXET8bZim7cVekUVG6yAwHpJupOpMuJGHu1zgz.jpg',
            'gallery' => '"[\"products\\/gallery\\/ZTSLNjvtG1lh44jkBVxVdzPbR7hwskTzgj8SNcHU.jpg\",\"products\\/gallery\\/GOWe6Pn8RRjxtGh42VB3uByTHr1IM2bYvRoCjcuI.jpg\",\"products\\/gallery\\/RiMQHZnP6MaXHQXMG4lbdKlYyq1jhrGOAnW91rLC.jpg\"]"',
            'category_id' => 4,
            'unit_id' => 1,
            'attributes' => null
        ],
        [
            'id' => 6,
            'name' => 'AiHOME Tumbler Hot and Cold Stainless Steel Thermos Flask 304 Double Wall Vacuum Flask',
            'description' => 'AiHOME Tumbler Hot and Cold Stainless Steel Thermos Flask 304 Double Wall Vacuum Flask',
            'price' => 150.00,
            'cashback_amount' => 20.00,
            'cashback_max_level' => 3,
            'cashback_level_bonuses' => '{"1":10}',
            'discount_value' => 10.00,
            'discount_type' => 'flat',
            'promo_code' => 'PROMO10',
            'stock_quantity' => 10,
            'image' => null,
            'active' => 1,
            'created_at' => '2025-07-28 06:51:37',
            'updated_at' => '2025-07-29 00:28:17',
            'thumbnail' => 'products/thumbnails/jiwcrmh28r08v3JwNy6qBH8BOBCZ1QaSq8Z0hlhl.jpg',
            'gallery' => '"[\"products\\/gallery\\/R6RYaHNvOuVFXJ4BUEz0cxD75ENYBisQOBAhbMyu.jpg\",\"products\\/gallery\\/iNGR7bngNicGsSOaY4Y8ybK3r2c6MacAomfyC34G.jpg\",\"products\\/gallery\\/QqtvljvRQXifZt9hcXDAchL2gdM4wXEe3waYpB3Q.jpg\",\"products\\/gallery\\/RVkkrrGkO4LsoZm10Wm4PxkUJldhbp1lR8p9mH2F.jpg\"]"',
            'category_id' => 3,
            'unit_id' => 1,
            'attributes' => null
        ],
        [
            'id' => 10,
            'name' => 'Shinra Bangles',
            'description' => "Screwtype bangle\r\n18K pawnable gold\r\nReal gold",
            'price' => 3000.00,
            'cashback_amount' => 50.00,
            'cashback_max_level' => 3,
            'cashback_level_bonuses' => '[]',
            'discount_value' => 200.00,
            'discount_type' => 'flat',
            'promo_code' => 'NEW25',
            'stock_quantity' => -1,
            'image' => null,
            'active' => 1,
            'created_at' => '2025-07-29 01:01:04',
            'updated_at' => '2025-07-29 01:14:31',
            'thumbnail' => null,
            'gallery' => null,
            'category_id' => 4,
            'unit_id' => 1,
            'attributes' => null
        ]
    ];

    foreach ($newProducts as $productData) {
        if (!Product::where('id', $productData['id'])->exists()) {
            Product::create($productData);
            echo "  - Added product: {$productData['name']} (ID: {$productData['id']})\n";
        } else {
            echo "  - Skipped product: {$productData['name']} (already exists)\n";
        }
    }

    // 4. Insert new orders
    echo "\n4. Integrating Orders...\n";
    
    $newOrders = [
        [
            'id' => 5,
            'member_id' => 39,
            'total_amount' => 0.00,
            'total_cashback' => 0.00,
            'status' => 'Delivered',
            'cashback_given' => 0,
            'promo_code' => null,
            'promo_discount' => 0.00,
            'created_at' => '2025-07-29 01:14:31',
            'updated_at' => '2025-07-29 01:15:20',
            'payment_method' => 'GCash',
            'delivery_type' => 'pickup',
            'delivery_address' => null,
            'contact_number' => '09151836162',
            'reference_image' => null,
            'gcash_note' => null,
            'bank_note' => null,
            'amount_sent' => null
        ]
    ];

    foreach ($newOrders as $orderData) {
        if (!Order::where('id', $orderData['id'])->exists()) {
            Order::create($orderData);
            echo "  - Added order: ID {$orderData['id']} for member {$orderData['member_id']}\n";
        } else {
            echo "  - Skipped order: ID {$orderData['id']} (already exists)\n";
        }
    }

    // 5. Insert new order items
    echo "\n5. Integrating Order Items...\n";
    
    $newOrderItems = [
        [
            'id' => 2,
            'order_id' => 5,
            'product_id' => 10,
            'quantity' => 2,
            'price' => 2980.00,
            'status' => 'Cancelled',
            'cashback_amount' => 0.00,
            'cashback' => 50.00,
            'created_at' => '2025-07-29 01:14:31',
            'updated_at' => '2025-07-29 01:15:20'
        ]
    ];

    foreach ($newOrderItems as $orderItemData) {
        if (!OrderItem::where('id', $orderItemData['id'])->exists()) {
            OrderItem::create($orderItemData);
            echo "  - Added order item: ID {$orderItemData['id']} for order {$orderItemData['order_id']}\n";
        } else {
            echo "  - Skipped order item: ID {$orderItemData['id']} (already exists)\n";
        }
    }

    // 6. Insert new settings
    echo "\n6. Integrating Settings...\n";
    
    $newSettings = [
        ['id' => 1, 'key' => 'discount_values', 'value' => '["10","20","50"]', 'created_at' => '2025-07-25 04:57:39', 'updated_at' => '2025-07-25 04:57:39'],
        ['id' => 2, 'key' => 'promo_codes', 'value' => '["PROMO10","NEW25"]', 'created_at' => '2025-07-25 04:57:39', 'updated_at' => '2025-07-25 04:57:39'],
        ['id' => 3, 'key' => 'available_sizes', 'value' => '["S","M","L","XL"]', 'created_at' => '2025-07-25 04:57:39', 'updated_at' => '2025-07-25 04:57:39'],
        ['id' => 4, 'key' => 'available_colors', 'value' => '["Red","Blue","Green"]', 'created_at' => '2025-07-25 04:57:39', 'updated_at' => '2025-07-25 04:57:39'],
        ['id' => 5, 'key' => 'shipping_fee', 'value' => '0', 'created_at' => '2025-07-26 01:41:28', 'updated_at' => '2025-07-28 21:04:05'],
        ['id' => 6, 'key' => 'promo_note', 'value' => '10% OFF for July', 'created_at' => '2025-07-26 01:41:28', 'updated_at' => '2025-07-27 01:04:27'],
        ['id' => 7, 'key' => 'discount_rate', 'value' => '10', 'created_at' => '2025-07-26 01:41:28', 'updated_at' => '2025-07-28 21:04:05'],
        ['id' => 8, 'key' => 'wallet_transfer_fee', 'value' => '0', 'created_at' => '2025-07-27 01:36:36', 'updated_at' => '2025-07-28 21:04:05']
    ];

    foreach ($newSettings as $settingData) {
        if (!Setting::where('key', $settingData['key'])->exists()) {
            Setting::create($settingData);
            echo "  - Added setting: {$settingData['key']}\n";
        } else {
            echo "  - Skipped setting: {$settingData['key']} (already exists)\n";
        }
    }

    echo "\n=== ORDERS & PRODUCTS INTEGRATION COMPLETED ===\n";
    
    DB::commit();
    
} catch (Exception $e) {
    DB::rollback();
    echo "ERROR: " . $e->getMessage() . "\n";
    echo "Integration rolled back.\n";
}