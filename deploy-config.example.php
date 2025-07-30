<?php
/**
 * Deployment Configuration Example
 * Copy this file to deploy-config.php and update with your GoDaddy credentials
 */

return [
    // GoDaddy FTP/SFTP Configuration
    'ftp' => [
        'host' => 'ftp.your-domain.com', // Your GoDaddy FTP host
        'username' => 'your-ftp-username',
        'password' => 'your-ftp-password',
        'port' => 21, // Use 22 for SFTP if available
        'ssl' => false, // Set to true for FTPS
        'passive' => true
    ],
    
    // Paths
    'local_path' => __DIR__,
    'remote_path' => '/public_html', // or /public_html/your-domain.com
    
    // Files/directories to exclude from deployment
    'exclude' => [
        '.git/',
        'node_modules/',
        'vendor/',
        'storage/logs/',
        'storage/framework/cache/',
        'storage/framework/sessions/',
        'storage/framework/views/',
        '.env',
        '.env.example',
        'deploy.php',
        'deploy-config.php',
        'deploy-config.example.php',
        'last_deploy.json',
        'README.md',
        'composer.lock',
        'package-lock.json',
        'phpunit.xml',
        'tests/',
        'docs/',
        '.gitignore',
        '.gitattributes'
    ],
    
    // File extensions to include (empty array means all files)
    'include_extensions' => [
        'php', 'js', 'css', 'html', 'blade.php', 'json', 'xml',
        'jpg', 'jpeg', 'png', 'gif', 'svg', 'ico', 'webp',
        'ttf', 'woff', 'woff2', 'eot',
        'txt', 'md'
    ],
    
    // Backup settings
    'backup' => [
        'enabled' => true,
        'keep_backups' => 5 // Number of backups to keep
    ]
];