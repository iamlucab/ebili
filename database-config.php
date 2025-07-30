<?php
/**
 * Database Deployment Configuration
 * Configure your local and remote database connections
 */

return [
    // Local database (your development environment)
    'local' => [
        'host' => '127.0.0.1',
        'port' => 3306,
        'database' => 'ebili',
        'username' => 'root',
        'password' => '',
        'charset' => 'utf8mb4'
    ],
    
    // Remote database (GoDaddy production)
    'remote' => [
        'host' => 'p3plzcpnl484003.prod.phx3.secureserver.net', // GoDaddy database host
        'port' => 3306,
        'database' => 'ebili', // Production database name
        'username' => 'milesventures', // Database username
        'password' => 'Coders123', // Database password
        'charset' => 'utf8mb4'
    ],
    
    // Backup settings
    'backup' => [
        'enabled' => true,
        'keep_backups' => 5, // Number of backups to keep
        'directory' => 'database_backups'
    ],
    
    // Tables to exclude from deployment (if any)
    'exclude_tables' => [
        // 'cache',
        // 'sessions',
        // 'failed_jobs'
    ],
    
    // Migration settings
    'migrations' => [
        'table' => 'migrations',
        'directory' => 'database/migrations'
    ]
];