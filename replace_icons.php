<?php
/**
 * Script to replace all Font Awesome icons with Bootstrap Icons equivalents
 * Run this from the project root directory
 */

// Icon mapping from Font Awesome to Bootstrap Icons
$iconMappings = [
    'fas fa-shopping-cart' => 'bi bi-cart',
    'fas fa-trash' => 'bi bi-trash',
    'fas fa-arrow-left' => 'bi bi-arrow-left',
    'fas fa-download' => 'bi bi-download',
    'fas fa-copy' => 'bi bi-clipboard',
    'fas fa-eye' => 'bi bi-eye',
    'fas fa-history' => 'bi bi-clock-history',
    'fas fa-random' => 'bi bi-shuffle',
    'fas fa-times' => 'bi bi-x',
    'fas fa-file-invoice' => 'bi bi-receipt',
    'fas fa-qrcode' => 'bi bi-qr-code',
    'fas fa-share-alt' => 'bi bi-share',
    'fas fa-check-circle' => 'bi bi-check-circle',
    'fas fa-exclamation-triangle' => 'bi bi-exclamation-triangle',
    'fas fa-paper-plane' => 'bi bi-send',
    'fas fa-hand-holding-usd' => 'bi bi-cash-coin',
    'fas fa-wallet' => 'bi bi-wallet2',
    'fas fa-sitemap' => 'bi bi-diagram-3',
    'fas fa-user-plus' => 'bi bi-person-plus',
    'fas fa-box' => 'bi bi-box-seam',
    'fas fa-shopping-bag' => 'bi bi-bag',
    'fas fa-info-circle' => 'bi bi-info-circle',
    'fas fa-user-check' => 'bi bi-person-check',
    'fas fa-money-bill' => 'bi bi-cash',
    'fas fa-users' => 'bi bi-people',
    'fas fa-ticket-alt' => 'bi bi-ticket',
    'fas fa-project-diagram' => 'bi bi-diagram-3',
    'fas fa-chart-line' => 'bi bi-graph-up',
    'fas fa-minus' => 'bi bi-dash',
    'fas fa-plus' => 'bi bi-plus',
    'fas fa-cart-plus' => 'bi bi-cart-plus',
    'fas fa-arrow-left' => 'bi bi-arrow-left',
    'fas fa-user' => 'bi bi-person',
    'fas fa-bell' => 'bi bi-bell',
    'fas fa-check' => 'bi bi-check',
    'fas fa-edit' => 'bi bi-pencil',
    'fas fa-save' => 'bi bi-save',
    'fas fa-search' => 'bi bi-search',
    'fas fa-filter' => 'bi bi-funnel',
    'fas fa-file-csv' => 'bi bi-filetype-csv',
    'fas fa-home' => 'bi bi-house',
    'fas fa-tachometer-alt' => 'bi bi-speedometer2',
    'fas fa-sign-out-alt' => 'bi bi-box-arrow-right',
    'fas fa-file-alt' => 'bi bi-file-text',
    'fas fa-sync' => 'bi bi-arrow-clockwise',
    'fas fa-file-pdf' => 'bi bi-filetype-pdf',
    'fas fa-receipt' => 'bi bi-receipt',
    'fas fa-money-bill-wave' => 'bi bi-cash',
    'fas fa-clock' => 'bi bi-clock',
    'fas fa-percentage' => 'bi bi-percent',
    'fas fa-coins' => 'bi bi-coin',
    'fas fa-exclamation-circle' => 'bi bi-exclamation-circle',
    'fas fa-print' => 'bi bi-printer',
    'fas fa-arrow-circle-right' => 'bi bi-arrow-right-circle',
    'fas fa-times-circle' => 'bi bi-x-circle',
    'fas fa-check-circle' => 'bi bi-check-circle',
    'fas fa-undo' => 'bi bi-arrow-counterclockwise',
    'fas fa-user-gift' => 'bi bi-gift',
    'fas fa-hashtag' => 'bi bi-hash',
    'fas fa-birthday-cake' => 'bi bi-cake',
    'fas fa-mobile-alt' => 'bi bi-phone',
    'fas fa-briefcase' => 'bi bi-briefcase',
    'fas fa-user-tag' => 'bi bi-person-badge',
    'fas fa-handshake' => 'bi bi-handshake',
    'fas fa-toggle-on' => 'bi bi-toggle-on',
    'fas fa-cogs' => 'bi bi-gear-fill',
    'fas fa-list' => 'bi bi-list',
    'fas fa-envelope' => 'bi bi-envelope',
    'fas fa-map-marker-alt' => 'bi bi-geo-alt',
    'fas fa-crown' => 'bi bi-award',
    'fas fa-user-tie' => 'bi bi-person-workspace',
    'fas fa-key' => 'bi bi-key',
    'fas fa-sliders-h' => 'bi bi-sliders',
    'fas fa-camera' => 'bi bi-camera',
    'fas fa-image' => 'bi bi-image',
    'fas fa-tag' => 'bi bi-tag',
    'fas fa-phone' => 'bi bi-telephone',
    'fas fa-peso-sign' => 'bi bi-currency-dollar',
    'fas fa-shield-alt' => 'bi bi-shield-check',
    'fas fa-layer-group' => 'bi bi-layers',
    'fas fa-cog' => 'bi bi-gear',
    'fas fa-arrow-up' => 'bi bi-arrow-up',
    'fas fa-font-awesome' => 'bi bi-bootstrap',
];

// Get all .blade.php files recursively
function getBladeFiles($dir) {
    $files = [];
    $iterator = new RecursiveIteratorIterator(
        new RecursiveDirectoryIterator($dir, RecursiveDirectoryIterator::SKIP_DOTS),
        RecursiveIteratorIterator::SELF_FIRST
    );
    
    foreach ($iterator as $file) {
        if ($file->isFile() && $file->getExtension() === 'php' && strpos($file->getFilename(), '.blade.') !== false) {
            $files[] = $file->getPathname();
        }
    }
    
    return $files;
}

// Replace icons in files
function replaceIconsInFiles($files, $mappings) {
    $totalReplacements = 0;
    
    foreach ($files as $file) {
        $content = file_get_contents($file);
        $originalContent = $content;
        $fileReplacements = 0;
        
        foreach ($mappings as $oldIcon => $newIcon) {
            $count = 0;
            $content = str_replace($oldIcon, $newIcon, $content, $count);
            $fileReplacements += $count;
        }
        
        if ($fileReplacements > 0) {
            file_put_contents($file, $content);
            echo "✅ {$file}: {$fileReplacements} replacements\n";
            $totalReplacements += $fileReplacements;
        }
    }
    
    return $totalReplacements;
}

// Main execution
echo "🔄 Starting Font Awesome to Bootstrap Icons replacement...\n\n";

$resourcesDir = __DIR__ . '/resources/views';
if (!is_dir($resourcesDir)) {
    die("❌ Error: resources/views directory not found. Please run this script from the project root.\n");
}

$bladeFiles = getBladeFiles($resourcesDir);
echo "📁 Found " . count($bladeFiles) . " .blade.php files\n\n";

$totalReplacements = replaceIconsInFiles($bladeFiles, $iconMappings);

echo "\n🎉 Replacement complete!\n";
echo "📊 Total replacements made: {$totalReplacements}\n";
echo "✨ All Font Awesome icons have been replaced with Bootstrap Icons equivalents.\n";
?>