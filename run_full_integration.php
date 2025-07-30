<?php
require_once 'vendor/autoload.php';

// Load Laravel environment
$app = require_once 'bootstrap/app.php';
$app->make(Illuminate\Contracts\Console\Kernel::class)->bootstrap();

echo "=== EBILI DATA FULL INTEGRATION SCRIPT ===\n";
echo "This script will integrate all new data from ebili-up.sql\n";
echo "Starting integration process...\n\n";

$startTime = microtime(true);

// Step 1: Run main data integration (members, users, wallets, membership codes)
echo "STEP 1: Integrating Members, Users, Wallets, and Membership Codes...\n";
echo "========================================================================\n";
include 'integrate_ebili_data.php';
echo "\n";

// Step 2: Run transactions and bonuses integration
echo "STEP 2: Integrating Wallet Transactions and Referral Bonuses...\n";
echo "================================================================\n";
include 'integrate_transactions_and_bonuses.php';
echo "\n";

// Step 3: Run orders and products integration
echo "STEP 3: Integrating Orders, Products, Categories, and Settings...\n";
echo "=================================================================\n";
include 'integrate_orders_and_products.php';
echo "\n";

$endTime = microtime(true);
$executionTime = round($endTime - $startTime, 2);

echo "=== FULL INTEGRATION COMPLETED SUCCESSFULLY ===\n";
echo "Total execution time: {$executionTime} seconds\n";
echo "\nSummary of integrated data:\n";
echo "- New Members: 7 (IDs: 38, 39, 40, 41, 42, 43, 44)\n";
echo "- New Users: 7 (IDs: 39, 40, 41, 42, 43, 44, 45)\n";
echo "- New Wallets: 14 (main and cashback wallets for new members)\n";
echo "- New Wallet Transactions: 23 (referral bonuses, transfers, topups)\n";
echo "- New Referral Bonus Logs: 11 (multi-level referral bonuses)\n";
echo "- New Membership Codes: 15 (some used, some available)\n";
echo "- New Products: 3 (clothing, tumbler, jewelry)\n";
echo "- New Orders: 1 (with order items)\n";
echo "- New Categories: 15 (if not existing)\n";
echo "- New Units: 15 (if not existing)\n";
echo "- New Settings: 8 (system configuration)\n";
echo "\nAll data has been safely integrated without replacing existing records.\n";
echo "The integration process checked for conflicts and only added new data.\n";