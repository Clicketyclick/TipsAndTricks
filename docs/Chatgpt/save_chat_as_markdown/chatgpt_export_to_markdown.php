<?php

$input = $argv[1] ?? 'conversations.json';
$outDir = $argv[2] ?? 'markdown_chats';

if (!is_file($input)) {
    fwrite(STDERR, "File not found: {$input}\n");
    exit(1);
}

if (!is_dir($outDir)) {
    mkdir($outDir, 0777, true);
}

$json = file_get_contents($input);
$data = json_decode($json, true);

if (!is_array($data)) {
    fwrite(STDERR, "Invalid JSON\n");
    exit(1);
}

foreach ($data as $chat) {
    $title = $chat['title'] ?? 'untitled-chat';
    $safeTitle = preg_replace('/[^a-zA-Z0-9._-]+/', '_', $title);
    $safeTitle = trim($safeTitle, '_') ?: 'untitled-chat';

    $created = $chat['create_time'] ?? null;
    $datePrefix = $created ? date('Y-m-d_His', (int) $created) : date('Y-m-d_His');

    $file = "{$outDir}/{$datePrefix}_{$safeTitle}.md";

    $markdown = "# {$title}\n\n";

    //*
    //* ChatGPT exports usually store messages in a mapping structure.
    //*
    $messages = [];

    if (isset($chat['mapping']) && is_array($chat['mapping'])) {
        foreach ($chat['mapping'] as $node) {
            $message = $node['message'] ?? null;

            if (!$message) {
                continue;
            }

            $role = $message['author']['role'] ?? 'unknown';
            $parts = $message['content']['parts'] ?? [];

            foreach ($parts as $part) {
                if (is_string($part) && trim($part) !== '') {
                    $messages[] = [
                        'role' => $role,
                        'text' => $part,
                    ];
                }
            }
        }
    }

    foreach ($messages as $message) {
        $role = match ($message['role']) {
            'user' => 'User',
            'assistant' => 'Assistant',
            'system' => 'System',
            'tool' => 'Tool',
            default => ucfirst($message['role']),
        };

        $markdown .= "## {$role}\n\n";
        $markdown .= trim($message['text']) . "\n\n";
    }

    file_put_contents($file, $markdown);
    echo "Written: {$file}\n";
}
