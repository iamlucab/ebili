<?php

/**
 * Deployment Preparation Script
 * 
 * This script prepares the database for deployment by:
 * 1. Clearing all tables except: categories, migrations, products, units
 * 2. Creating the system administrator with specified credentials
 * 3. Creating temporary staff and member users
 * 4. Syncing all users to the members table
 */

echo "🚀 E-Bili Deployment Preparation Script\n";
echo "=====================================\n\n";

// Check if we're in the correct directory
if (!file_exists('artisan')) {
    echo "❌ Error: Please run this script from the Laravel project root directory.\n";
    exit(1);
}

echo "⚠️  WARNING: This will clear most database tables and reset with deployment data.\n";
echo "Preserved tables: categories, migrations, products, units\n\n";

// Ask for confirmation
echo "Do you want to continue? (yes/no): ";
$handle = fopen("php://stdin", "r");
$confirmation = trim(fgets($handle));
fclose($handle);

if (strtolower($confirmation) !== 'yes' && strtolower($confirmation) !== 'y') {
    echo "❌ Operation cancelled.\n";
    exit(0);
}

echo "\n🔄 Starting deployment preparation...\n\n";

// Run the deployment preparation command
$command = 'php artisan deploy:prepare --force';
$output = [];
$returnCode = 0;

exec($command, $output, $returnCode);

// Display output
foreach ($output as $line) {
    echo $line . "\n";
}

if ($returnCode === 0) {
    echo "\n✅ Deployment preparation completed successfully!\n\n";
    echo "📋 Login Credentials:\n";
    echo "====================\n";
    echo "Admin User:\n";
    echo "  Username: 09177260180\n";
    echo "  Email: mrcabandez@gmail.com\n";
    echo "  Password: !@#123123\n\n";
    echo "Staff Users:\n";
    echo "  Username: staff001 | Email: staff1@ebili.com | Password: password123\n";
    echo "  Username: staff002 | Email: staff2@ebili.com | Password: password123\n\n";
    echo "Member Users:\n";
    echo "  Username: member001 | Email: member1@ebili.com | Password: password123\n";
    echo "  Username: member002 | Email: member2@ebili.com | Password: password123\n";
    echo "  Username: member003 | Email: member3@ebili.com | Password: password123\n\n";
    echo "🎉 Your E-Bili application is now ready for deployment!\n";
} else {
    echo "\n❌ Deployment preparation failed. Please check the error messages above.\n";
    exit(1);
}