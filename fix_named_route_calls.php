<?php

$directory = __DIR__ . '/resources/views';

$iterator = new RecursiveIteratorIterator(
    new RecursiveDirectoryIterator($directory)
);

foreach ($iterator as $file) {
    if ($file->getExtension() !== 'php') continue;

    $contents = file_get_contents($file);

    // Match and replace route(name: 'something' or route(name = 'something'
    $fixed = preg_replace_callback('/route\(\s*name\s*[:=]\s*[\'"]([^\'"]+)[\'"]\s*(,)?/', function ($matches) {
        $routeName = $matches[1];
        return "route('$routeName'" . ($matches[2] ?? '');
    }, $contents);

    if ($fixed !== $contents) {
        file_put_contents($file, $fixed);
        echo "✅ Fixed: " . $file . PHP_EOL;
    }
}
