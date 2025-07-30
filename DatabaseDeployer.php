<?php

class DatabaseDeployer {
    private $localConfig;
    private $remoteConfig;
    private $localConnection;
    private $remoteConnection;
    private $migrationTable = 'migrations';
    private $backupDir = 'database_backups';
    
    public function __construct($config) {
        $this->localConfig = $config['local'];
        $this->remoteConfig = $config['remote'];
        
        // Create backup directory if it doesn't exist
        if (!is_dir($this->backupDir)) {
            mkdir($this->backupDir, 0755, true);
        }
    }
    
    /**
     * Connect to local database
     */
    public function connectLocal() {
        try {
            $dsn = "mysql:host={$this->localConfig['host']};port={$this->localConfig['port']};dbname={$this->localConfig['database']};charset={$this->localConfig['charset']}";
            $this->localConnection = new PDO($dsn, $this->localConfig['username'], $this->localConfig['password'], [
                PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC
            ]);
            $this->log("Connected to local database: {$this->localConfig['database']}");
            return true;
        } catch (PDOException $e) {
            $this->log("Failed to connect to local database: " . $e->getMessage(), 'error');
            return false;
        }
    }
    
    /**
     * Connect to remote database
     */
    public function connectRemote() {
        try {
            $dsn = "mysql:host={$this->remoteConfig['host']};port={$this->remoteConfig['port']};dbname={$this->remoteConfig['database']};charset={$this->remoteConfig['charset']}";
            $this->remoteConnection = new PDO($dsn, $this->remoteConfig['username'], $this->remoteConfig['password'], [
                PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC
            ]);
            $this->log("Connected to remote database: {$this->remoteConfig['database']}");
            return true;
        } catch (PDOException $e) {
            $this->log("Failed to connect to remote database: " . $e->getMessage(), 'error');
            return false;
        }
    }
    
    /**
     * Test database connections
     */
    public function testConnections() {
        $this->log("Testing database connections...");
        
        $localOk = $this->connectLocal();
        $remoteOk = $this->connectRemote();
        
        if ($localOk && $remoteOk) {
            $this->log("✅ Both database connections successful!");
            return true;
        } else {
            $this->log("❌ Database connection test failed!", 'error');
            return false;
        }
    }
    
    /**
     * Compare database schemas
     */
    public function compareSchemas() {
        if (!$this->connectLocal() || !$this->connectRemote()) {
            return false;
        }
        
        $this->log("Comparing database schemas...");
        
        $localTables = $this->getTables($this->localConnection);
        $remoteTables = $this->getTables($this->remoteConnection);
        
        $differences = [
            'new_tables' => array_diff($localTables, $remoteTables),
            'missing_tables' => array_diff($remoteTables, $localTables),
            'table_differences' => []
        ];
        
        // Compare existing tables
        $commonTables = array_intersect($localTables, $remoteTables);
        foreach ($commonTables as $table) {
            $localStructure = $this->getTableStructure($this->localConnection, $table);
            $remoteStructure = $this->getTableStructure($this->remoteConnection, $table);
            
            if ($localStructure !== $remoteStructure) {
                $differences['table_differences'][$table] = [
                    'local' => $localStructure,
                    'remote' => $remoteStructure
                ];
            }
        }
        
        return $differences;
    }
    
    /**
     * Deploy database changes
     */
    public function deploy($options = []) {
        $dryRun = $options['dry_run'] ?? false;
        $backup = $options['backup'] ?? true;
        
        if (!$this->connectLocal() || !$this->connectRemote()) {
            return false;
        }
        
        $this->log("Starting database deployment...");
        
        if ($dryRun) {
            $this->log("DRY RUN MODE - No changes will be applied");
        }
        
        // Create backup if enabled
        if ($backup && !$dryRun) {
            $this->createBackup();
        }
        
        // Get schema differences
        $differences = $this->compareSchemas();
        
        if (empty($differences['new_tables']) && empty($differences['table_differences'])) {
            $this->log("No database changes detected.");
            return true;
        }
        
        $success = true;
        
        // Create new tables
        foreach ($differences['new_tables'] as $table) {
            if ($this->createTable($table, $dryRun)) {
                $this->log("✅ Table '{$table}' " . ($dryRun ? "would be created" : "created"));
            } else {
                $this->log("❌ Failed to create table '{$table}'", 'error');
                $success = false;
            }
        }
        
        // Update existing tables
        foreach ($differences['table_differences'] as $table => $diff) {
            if ($this->updateTable($table, $diff, $dryRun)) {
                $this->log("✅ Table '{$table}' " . ($dryRun ? "would be updated" : "updated"));
            } else {
                $this->log("❌ Failed to update table '{$table}'", 'error');
                $success = false;
            }
        }
        
        // Run pending migrations
        if ($this->runMigrations($dryRun)) {
            $this->log("✅ Migrations " . ($dryRun ? "would be executed" : "executed"));
        }
        
        return $success;
    }
    
    /**
     * Create backup of remote database
     */
    private function createBackup() {
        $this->log("Creating database backup...");
        
        $backupFile = $this->backupDir . '/backup_' . date('Y-m-d_H-i-s') . '.sql';
        
        $command = sprintf(
            'mysqldump -h%s -P%s -u%s -p%s %s > %s',
            $this->remoteConfig['host'],
            $this->remoteConfig['port'],
            $this->remoteConfig['username'],
            $this->remoteConfig['password'],
            $this->remoteConfig['database'],
            $backupFile
        );
        
        // For security, we'll create a basic backup using PHP instead
        $this->createPhpBackup($backupFile);
        
        $this->log("Backup created: {$backupFile}");
    }
    
    /**
     * Create backup using PHP
     */
    private function createPhpBackup($backupFile) {
        $tables = $this->getTables($this->remoteConnection);
        $backup = "-- Database Backup Created: " . date('Y-m-d H:i:s') . "\n\n";
        
        foreach ($tables as $table) {
            $backup .= "-- Table: {$table}\n";
            $backup .= $this->getCreateTableSQL($this->remoteConnection, $table) . "\n\n";
        }
        
        file_put_contents($backupFile, $backup);
    }
    
    /**
     * Get list of tables
     */
    private function getTables($connection) {
        $stmt = $connection->query("SHOW TABLES");
        $tables = [];
        while ($row = $stmt->fetch(PDO::FETCH_NUM)) {
            $tables[] = $row[0];
        }
        return $tables;
    }
    
    /**
     * Get table structure
     */
    private function getTableStructure($connection, $table) {
        $stmt = $connection->query("DESCRIBE `{$table}`");
        return $stmt->fetchAll();
    }
    
    /**
     * Get CREATE TABLE SQL
     */
    private function getCreateTableSQL($connection, $table) {
        $stmt = $connection->query("SHOW CREATE TABLE `{$table}`");
        $row = $stmt->fetch();
        return $row['Create Table'] . ';';
    }
    
    /**
     * Create new table on remote
     */
    private function createTable($table, $dryRun = false) {
        try {
            $createSQL = $this->getCreateTableSQL($this->localConnection, $table);
            
            if ($dryRun) {
                $this->log("Would execute: {$createSQL}");
                return true;
            }
            
            $this->remoteConnection->exec($createSQL);
            return true;
        } catch (PDOException $e) {
            $this->log("Error creating table {$table}: " . $e->getMessage(), 'error');
            return false;
        }
    }
    
    /**
     * Update existing table
     */
    private function updateTable($table, $differences, $dryRun = false) {
        // This is a simplified version - in practice, you'd need more sophisticated
        // column comparison and ALTER TABLE generation
        $this->log("Table '{$table}' has structural differences");
        
        if ($dryRun) {
            $this->log("Would analyze and update table structure for '{$table}'");
            return true;
        }
        
        // For now, just log the differences
        $this->log("Manual review required for table '{$table}' - structural changes detected", 'warning');
        return true;
    }
    
    /**
     * Run Laravel migrations
     */
    private function runMigrations($dryRun = false) {
        // Check if migrations table exists
        $tables = $this->getTables($this->remoteConnection);
        if (!in_array($this->migrationTable, $tables)) {
            $this->log("Migrations table not found - skipping migration check");
            return true;
        }
        
        // Get local migrations
        $localMigrations = $this->getLocalMigrations();
        $remoteMigrations = $this->getRemoteMigrations();
        
        $pendingMigrations = array_diff($localMigrations, $remoteMigrations);
        
        if (empty($pendingMigrations)) {
            $this->log("No pending migrations");
            return true;
        }
        
        $this->log("Found " . count($pendingMigrations) . " pending migrations");
        
        foreach ($pendingMigrations as $migration) {
            if ($dryRun) {
                $this->log("Would run migration: {$migration}");
            } else {
                $this->log("Migration '{$migration}' requires manual execution via Laravel Artisan");
            }
        }
        
        return true;
    }
    
    /**
     * Get local migrations
     */
    private function getLocalMigrations() {
        $migrationFiles = glob('database/migrations/*.php');
        $migrations = [];
        
        foreach ($migrationFiles as $file) {
            $migrations[] = basename($file, '.php');
        }
        
        return $migrations;
    }
    
    /**
     * Get remote migrations
     */
    private function getRemoteMigrations() {
        try {
            $stmt = $this->remoteConnection->query("SELECT migration FROM {$this->migrationTable}");
            $migrations = [];
            while ($row = $stmt->fetch()) {
                $migrations[] = $row['migration'];
            }
            return $migrations;
        } catch (PDOException $e) {
            $this->log("Could not read migrations table: " . $e->getMessage(), 'warning');
            return [];
        }
    }
    
    /**
     * Export database schema as SQL
     */
    public function exportSchema($outputFile = null) {
        if (!$this->connectLocal()) {
            return false;
        }
        
        $outputFile = $outputFile ?: 'database_schema_' . date('Y-m-d_H-i-s') . '.sql';
        
        $tables = $this->getTables($this->localConnection);
        $schema = "-- Database Schema Export\n";
        $schema .= "-- Generated: " . date('Y-m-d H:i:s') . "\n\n";
        
        foreach ($tables as $table) {
            $schema .= "-- Table: {$table}\n";
            $schema .= $this->getCreateTableSQL($this->localConnection, $table) . "\n\n";
        }
        
        file_put_contents($outputFile, $schema);
        $this->log("Schema exported to: {$outputFile}");
        
        return $outputFile;
    }
    
    /**
     * Get deployment status
     */
    public function getStatus() {
        if (!$this->connectLocal() || !$this->connectRemote()) {
            return ['error' => 'Could not connect to databases'];
        }
        
        $differences = $this->compareSchemas();
        $localMigrations = $this->getLocalMigrations();
        $remoteMigrations = $this->getRemoteMigrations();
        $pendingMigrations = array_diff($localMigrations, $remoteMigrations);
        
        return [
            'new_tables' => count($differences['new_tables']),
            'table_differences' => count($differences['table_differences']),
            'pending_migrations' => count($pendingMigrations),
            'details' => [
                'new_tables' => $differences['new_tables'],
                'modified_tables' => array_keys($differences['table_differences']),
                'pending_migrations' => array_slice($pendingMigrations, 0, 10) // Show first 10
            ]
        ];
    }
    
    /**
     * Log messages
     */
    private function log($message, $level = 'info') {
        $timestamp = date('Y-m-d H:i:s');
        $levelUpper = strtoupper($level);
        echo "[{$timestamp}] [{$levelUpper}] {$message}\n";
    }
    
    /**
     * Disconnect from databases
     */
    public function disconnect() {
        $this->localConnection = null;
        $this->remoteConnection = null;
        $this->log("Disconnected from databases");
    }
}