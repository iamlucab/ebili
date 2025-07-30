#!/usr/bin/env php
<?php
/**
 * GoDaddy Deployment Script for Ebili Laravel Application
 * 
 * Usage:
 *   php deploy.php [options]
 * 
 * Options:
 *   --dry-run    Show what would be deployed without actually uploading
 *   --test       Test FTP connection only
 *   --status     Show deployment status
 *   --help       Show this help message
 */

// Include the deployer class
require_once __DIR__ . '/GoDaddyDeployer.php';

// Load configuration
if (!file_exists(__DIR__ . '/deploy-config.php')) {
    echo "Error: deploy-config.php not found. Please copy deploy-config.example.php to deploy-config.php and configure it.\n";
    exit(1);
}

$config = require __DIR__ . '/deploy-config.php';

// Parse command line arguments
$options = getopt('', ['dry-run', 'test', 'status', 'help']);

// Show help
if (isset($options['help'])) {
    showHelp();
    exit(0);
}

// Initialize deployer
$deployer = new GoDaddyDeployer($config);

try {
    // Test connection
    if (isset($options['test'])) {
        echo "Testing FTP connection...\n";
        echo str_repeat('=', 50) . "\n";
        
        if ($deployer->testConnection()) {
            echo "\n✅ Connection test successful!\n";
            echo "You can now deploy your application.\n";
        } else {
            echo "\n❌ Connection test failed!\n";
            echo "Please check your FTP credentials in deploy-config.php\n";
            exit(1);
        }
        exit(0);
    }
    
    // Show status
    if (isset($options['status'])) {
        echo "Deployment Status\n";
        echo str_repeat('=', 50) . "\n";
        
        $status = $deployer->getStatus();
        
        if ($status['last_deploy']) {
            echo "Last deployment: " . $status['last_deploy']['date'] . "\n";
            echo "Files uploaded: " . $status['last_deploy']['files_uploaded'] . "\n";
        } else {
            echo "No previous deployments found.\n";
        }
        
        echo "Files pending upload: " . $status['files_to_upload'] . "\n";
        
        if (!empty($status['files_pending'])) {
            echo "\nNext files to upload:\n";
            foreach ($status['files_pending'] as $file) {
                echo "  - {$file}\n";
            }
            if ($status['files_to_upload'] > count($status['files_pending'])) {
                echo "  ... and " . ($status['files_to_upload'] - count($status['files_pending'])) . " more files\n";
            }
        }
        
        exit(0);
    }
    
    // Perform deployment
    $dryRun = isset($options['dry-run']);
    
    echo "Ebili Laravel Application Deployment\n";
    echo str_repeat('=', 50) . "\n";
    echo "Target: https://www.ebili.online\n";
    echo "Remote path: {$config['remote_path']}\n";
    
    if ($dryRun) {
        echo "Mode: DRY RUN (no files will be uploaded)\n";
    } else {
        echo "Mode: LIVE DEPLOYMENT\n";
        
        // Confirmation for live deployment
        echo "\n⚠️  This will upload files to your live server.\n";
        echo "Are you sure you want to continue? (y/N): ";
        $handle = fopen("php://stdin", "r");
        $line = fgets($handle);
        fclose($handle);
        
        if (trim(strtolower($line)) !== 'y') {
            echo "Deployment cancelled.\n";
            exit(0);
        }
    }
    
    echo "\n" . str_repeat('-', 50) . "\n";
    
    // Start deployment
    $success = $deployer->deploy($dryRun);
    
    echo "\n" . str_repeat('-', 50) . "\n";
    
    if ($success) {
        if ($dryRun) {
            echo "✅ Dry run completed successfully!\n";
            echo "Run without --dry-run to perform actual deployment.\n";
        } else {
            echo "✅ Deployment completed successfully!\n";
            echo "Your application is now live at: https://www.ebili.online\n";
            
            // Show post-deployment notes
            showPostDeploymentNotes();
        }
    } else {
        echo "❌ Deployment completed with errors!\n";
        echo "Please check the logs above and fix any issues.\n";
        exit(1);
    }
    
} catch (Exception $e) {
    echo "\n❌ Deployment failed: " . $e->getMessage() . "\n";
    exit(1);
}

/**
 * Show help message
 */
function showHelp() {
    echo "Ebili Laravel Application Deployment Script\n";
    echo str_repeat('=', 50) . "\n";
    echo "Usage: php deploy.php [options]\n\n";
    echo "Options:\n";
    echo "  --dry-run    Show what would be deployed without actually uploading\n";
    echo "  --test       Test FTP connection only\n";
    echo "  --status     Show deployment status\n";
    echo "  --help       Show this help message\n\n";
    echo "Examples:\n";
    echo "  php deploy.php --test           # Test connection\n";
    echo "  php deploy.php --status         # Show status\n";
    echo "  php deploy.php --dry-run        # Preview deployment\n";
    echo "  php deploy.php                  # Deploy to live server\n\n";
    echo "Configuration:\n";
    echo "  Edit deploy-config.php to configure FTP settings and exclusions.\n";
}

/**
 * Show post-deployment notes
 */
function showPostDeploymentNotes() {
    echo "\n📋 Post-Deployment Notes:\n";
    echo str_repeat('-', 30) . "\n";
    echo "1. Verify your .env file is properly configured on the server\n";
    echo "2. Ensure database credentials are correct\n";
    echo "3. Check file permissions (755 for directories, 644 for files)\n";
    echo "4. Verify storage/ and bootstrap/cache/ are writable\n";
    echo "5. Test key application features\n";
    echo "\n💡 If you have SSH access, you may want to run:\n";
    echo "   - php artisan config:cache\n";
    echo "   - php artisan route:cache\n";
    echo "   - php artisan view:cache\n";
    echo "   - php artisan storage:link\n";
}