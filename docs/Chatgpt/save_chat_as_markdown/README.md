
## How can I save and download an entire chat as markdown?

The reliable way is:

1. **Export your ChatGPT data**

   * Open ChatGPT.
   * Go to **Settings → Data Controls → Export**.
   * Confirm the export.
   * OpenAI sends you a download link for a ZIP file; the link expires after 24 hours. The export includes your chat history. ([OpenAI Help Center][1])

2. **Unzip the export**

   * Look for a file such as `conversations.json`.
   * OpenAI’s own migration guidance refers to the export as containing a JSON file with your chats. ([OpenAI Help Center][2])

3. **Convert the JSON chat to Markdown**

Here is a simple PHP converter that creates one `.md` file per conversation:

```php
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
```

Run it like this:

```bash
php chatgpt_export_to_markdown.php conversations.json markdown_chats
```

This gives you a folder named `markdown_chats` containing Markdown files.

For **one specific chat**, export all data first, then find the generated `.md` file by title/date. ChatGPT’s built-in export is account-level, not a dedicated “download this chat as Markdown” button in the documented export flow. Shared links are included in exports, but shared links themselves are view-only and not Markdown downloads. ([OpenAI Help Center][3])

[1]: https://help.openai.com/en/articles/7260999-how-do-i-export-my-chatgpt-history-and-data?utm_source=chatgpt.com "How do I export my ChatGPT history and data?"
[2]: https://help.openai.com/en/articles/9106926-transferring-conversations-from-1-chatgpt-account-to-another-chatgpt-account?utm_source=chatgpt.com "Transferring Conversations from 1 ChatGPT account to ..."
[3]: https://help.openai.com/en/articles/7925741-chatgpt-shared-links-faq?utm_source=chatgpt.com "ChatGPT Shared Links FAQ"
****
