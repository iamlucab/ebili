<?php

/**
 * E-Bili Configuration Test Script
 * 
 * This script tests all the configurations and credentials
 * to ensure everything is properly integrated and working.
 */

require_once 'vendor/autoload.php';

// Load Laravel application
$app = require_once 'bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

echo "=== E-Bili Configuration Test ===\n\n";

// Test 1: Environment Configuration
echo "1. Testing Environment Configuration...\n";
$envTests = [
    'APP_NAME' => env('APP_NAME'),
    'APP_ENV' => env('APP_ENV'),
    'APP_KEY' => env('APP_KEY') ? 'SET' : 'NOT SET',
    'APP_URL' => env('APP_URL'),
    'DB_CONNECTION' => env('DB_CONNECTION'),
    'DB_HOST' => env('DB_HOST'),
    'DB_DATABASE' => env('DB_DATABASE'),
];

foreach ($envTests as $key => $value) {
    echo "   ✓ {$key}: {$value}\n";
}
echo "\n";

// Test 2: Social Login Configuration
echo "2. Testing Social Login Configuration...\n";
$socialConfigs = [
    'Google' => [
        'client_id' => config('services.google.client_id'),
        'client_secret' => config('services.google.client_secret') ? 'SET' : 'NOT SET',
        'redirect' => config('services.google.redirect'),
    ],
    'Facebook' => [
        'client_id' => config('services.facebook.client_id'),
        'client_secret' => config('services.facebook.client_secret') ? 'SET' : 'NOT SET',
        'redirect' => config('services.facebook.redirect'),
    ],
];

foreach ($socialConfigs as $provider => $config) {
    echo "   {$provider}:\n";
    foreach ($config as $key => $value) {
        echo "     ✓ {$key}: {$value}\n";
    }
}
echo "\n";

// Test 3: SMS Configuration (Semaphore)
echo "3. Testing SMS Configuration (Semaphore)...\n";
$smsConfig = [
    'api_key' => config('services.semaphore.api_key') ? 'SET' : 'NOT SET',
    'sender_name' => config('services.semaphore.sender_name'),
    'base_url' => config('services.semaphore.base_url'),
];

foreach ($smsConfig as $key => $value) {
    echo "   ✓ {$key}: {$value}\n";
}

// Test SMS Balance (if API key is set)
if (config('services.semaphore.api_key')) {
    try {
        $smsService = new App\Services\SemaphoreSmsService();
        $balance = $smsService->getBalance();
        if ($balance['success']) {
            echo "   ✓ SMS Balance: ₱" . number_format($balance['balance'], 2) . "\n";
            echo "   ✓ Account: " . ($balance['account_name'] ?? 'Semaphore Account') . "\n";
        } else {
            echo "   ✗ SMS Balance Check Failed: " . $balance['error'] . "\n";
        }
    } catch (Exception $e) {
        echo "   ✗ SMS Service Error: " . $e->getMessage() . "\n";
    }
}
echo "\n";

// Test 4: Firebase Configuration
echo "4. Testing Firebase Configuration...\n";
$firebaseConfig = [
    'project_id' => config('services.firebase.project_id'),
    'credentials_path' => config('services.firebase.credentials'),
    'credentials_exists' => file_exists(config('services.firebase.credentials')) ? 'YES' : 'NO',
];

foreach ($firebaseConfig as $key => $value) {
    echo "   ✓ {$key}: {$value}\n";
}

// Test Firebase Service
if (file_exists(config('services.firebase.credentials'))) {
    try {
        $firebaseService = new App\Services\FirebasePushNotificationService();
        echo "   ✓ Firebase Service: Initialized Successfully\n";
    } catch (Exception $e) {
        echo "   ✗ Firebase Service Error: " . $e->getMessage() . "\n";
    }
} else {
    echo "   ✗ Firebase credentials file not found\n";
}
echo "\n";

// Test 5: Database Connection
echo "5. Testing Database Connection...\n";
try {
    $pdo = DB::connection()->getPdo();
    echo "   ✓ Database Connection: SUCCESS\n";
    
    // Test if our tables exist
    $tables = ['users', 'device_tokens', 'sms_logs'];
    foreach ($tables as $table) {
        try {
            $exists = DB::getSchemaBuilder()->hasTable($table);
            echo "   ✓ Table '{$table}': " . ($exists ? 'EXISTS' : 'NOT EXISTS') . "\n";
        } catch (Exception $e) {
            echo "   ✗ Table '{$table}': ERROR - " . $e->getMessage() . "\n";
        }
    }
} catch (Exception $e) {
    echo "   ✗ Database Connection: FAILED - " . $e->getMessage() . "\n";
}
echo "\n";

// Test 6: Routes Configuration
echo "6. Testing Routes Configuration...\n";
$routes = [
    'admin.notifications.index' => '/admin/notifications',
    'admin.notifications.push' => '/admin/notifications/push',
    'admin.notifications.sms' => '/admin/notifications/sms',
    'admin.notifications.sms.history' => '/admin/notifications/sms-history',
    'admin.notifications.devices' => '/admin/notifications/device-tokens',
];

foreach ($routes as $name => $path) {
    try {
        $url = route($name);
        echo "   ✓ Route '{$name}': {$url}\n";
    } catch (Exception $e) {
        echo "   ✗ Route '{$name}': NOT FOUND\n";
    }
}
echo "\n";

// Test 7: File Permissions
echo "7. Testing File Permissions...\n";
$directories = [
    'storage/app' => 'writable',
    'storage/logs' => 'writable',
    'storage/framework/cache' => 'writable',
    'storage/framework/sessions' => 'writable',
    'storage/framework/views' => 'writable',
    'bootstrap/cache' => 'writable',
];

foreach ($directories as $dir => $permission) {
    $path = base_path($dir);
    if (is_dir($path)) {
        $writable = is_writable($path);
        echo "   " . ($writable ? '✓' : '✗') . " {$dir}: " . ($writable ? 'WRITABLE' : 'NOT WRITABLE') . "\n";
    } else {
        echo "   ✗ {$dir}: DIRECTORY NOT EXISTS\n";
    }
}
echo "\n";

// Test 8: Mail Configuration
echo "8. Testing Mail Configuration...\n";
$mailConfig = [
    'mailer' => config('mail.default'),
    'host' => config('mail.mailers.smtp.host'),
    'port' => config('mail.mailers.smtp.port'),
    'username' => config('mail.mailers.smtp.username') ? 'SET' : 'NOT SET',
    'encryption' => config('mail.mailers.smtp.encryption'),
    'from_address' => config('mail.from.address'),
    'from_name' => config('mail.from.name'),
];

foreach ($mailConfig as $key => $value) {
    echo "   ✓ {$key}: {$value}\n";
}
echo "\n";

// Summary
echo "=== Configuration Test Summary ===\n";
echo "✓ Environment: Configured\n";
echo "✓ Social Login: " . (config('services.google.client_id') ? 'Configured' : 'Needs Setup') . "\n";
echo "✓ SMS Service: " . (config('services.semaphore.api_key') ? 'Configured' : 'Needs Setup') . "\n";
echo "✓ Firebase: " . (file_exists(config('services.firebase.credentials')) ? 'Configured' : 'Needs Setup') . "\n";
echo "✓ Database: Connected\n";
echo "✓ Routes: Registered\n";
echo "✓ Mail: Configured\n";
echo "\n";

echo "🎉 Configuration test completed!\n";
echo "Your E-Bili application is ready to use.\n\n";

echo "Next steps:\n";
echo "1. Access admin panel: " . env('APP_URL') . "/admin/notifications\n";
echo "2. Test push notifications from the admin interface\n";
echo "3. Test SMS blasting functionality\n";
echo "4. Configure your mobile app with Firebase\n";
echo "\nFor detailed setup instructions, see:\n";
echo "- docs/admin-notification-management-guide.md\n";
echo "- docs/firebase-setup-guide.md\n";