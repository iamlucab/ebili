<?php

function deleteGitFolders($dir) {
    $gitDir = $dir . '/.git';

    if (is_dir($gitDir)) {
        echo "Deleting: $gitDir<br>";
        deleteDirectory($gitDir);
    }

    // Scan subdirectories
    $items = scandir($dir);
    foreach ($items as $item) {
        if ($item === '.' || $item === '..') continue;
        $path = $dir . '/' . $item;
        if (is_dir($path)) {
            deleteGitFolders($path);
        }
    }
}

function deleteDirectory($dir) {
    $files = array_diff(scandir($dir), array('.', '..'));
    foreach ($files as $file) {
        $filePath = "$dir/$file";
        if (is_dir($filePath)) {
            deleteDirectory($filePath);
        } else {
            unlink($filePath);
        }
    }
    return rmdir($dir);
}

// Start from current directory
$baseDir = __DIR__;
deleteGitFolders($baseDir);

echo "<br>✅ All .git folders have been deleted.";
