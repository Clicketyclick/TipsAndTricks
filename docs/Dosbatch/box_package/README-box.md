# box.cmd

`box.cmd` prints a titled console message box using Unicode box-drawing characters.

It is a hybrid Windows Batch + JScript script. It runs directly from `cmd.exe` using `cscript.exe`, without Node.js, Python, PowerShell modules, or external tools.

## Features

- Accepts `TITLE` and `MSG` as command-line parameters
- Falls back to environment variables `TITLE` and `MSG`
- Supports literal `\n`, `\r`, `\r\n`, and `\t`
- Supports wrapping of long message lines
- Supports configurable inner box width
- Supports configurable tab width
- Supports multiple box-drawing styles
- Supports custom characters through environment variables
- Restores the original Windows code page after execution

## Requirements

- Windows
- `cmd.exe`
- Windows Script Host / `cscript.exe`

## Encoding

The script changes the console code page to UTF-8 while running:

```bat
chcp 65001
```

The previous code page is restored before the script exits.

The box-drawing characters are stored internally as Unicode escape sequences, which makes the script less sensitive to file encoding issues.

## Usage

```bat
box.cmd [options] [title] [message] [style] [width]
```

## Basic example

```bat
call box.cmd "My title" "Message content1\nMessage content2"
```

Output:

```text
┏━━┫ My title ┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃ Message content1                                                 ┃
┃ Message content2                                                 ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
```

## Positional arguments

| Argument | Description |
| -------- | ----------- |
| `title` | Box title |
| `message` | Message text. Use literal `\n` for line breaks |
| `style` | Optional style name |
| `width` | Optional inner box width |

Example:

```bat
call box.cmd "My title" "Message" single 60
```

## Options

| Option | Description |
| ------ | ----------- |
| `--help` | Show help |
| `-help` | Show help |
| `/?` | Show help |
| `--version` | Show version |
| `--title=TEXT` | Set title |
| `--message=TEXT` | Set message |
| `--msg=TEXT` | Set message |
| `--style=NAME` | Set style |
| `--width=N` | Set inner box width |
| `-w N` | Short form of `--width=N` |
| `--tab-width=N` | Set tab width |
| `--wrap` | Enable wrapping |
| `--no-wrap` | Disable wrapping |

## Environment variables

| Variable | Description |
| -------- | ----------- |
| `TITLE` | Default title |
| `MSG` | Default message |
| `BOX_STYLE` | Default style |
| `BOX_WIDTH` | Default inner box width |
| `BOX_TAB_WIDTH` | Default tab width |
| `TAB_WIDTH` | Fallback tab width |
| `BOX_WRAP` | Default wrapping behavior |

Example:

```bat
set "TITLE=My title"
set "MSG=Message content1\nMessage content2"
set "BOX_STYLE=round"
set "BOX_WIDTH=67"

call box.cmd
```

Command-line options override environment variables.

## Escape sequences

| Sequence | Meaning |
| -------- | ------- |
| `\n` | New line |
| `\r` | New line |
| `\r\n` | New line |
| `\t` | Tab, expanded to spaces |

Example:

```bat
call box.cmd "Columns" "Name\tValue\nOne\t123\nTwo\t456" --tab-width=8
```

## Width and wrapping

`--width=N` sets the inner width of the box, not including the left and right border characters.

Example:

```bat
call box.cmd --width=40 "Wrapped" "This is a long message that should wrap inside the box."
```

Output:

```text
┏━━┫ Wrapped ┣━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃ This is a long message that should    ┃
┃ wrap inside the box.                  ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
```

If the title is longer than the requested width, the box expands to fit the title.

To disable wrapping:

```bat
call box.cmd --no-wrap --width=20 "No wrap" "This line will make the box wider"
```

## Supported styles

### `heavy`

```text
┏━━┫ Title ┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃ Message                              ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
```

### `single`

```text
┌──┤ Title ├────────────────────────────┐
│ Message                              │
└──────────────────────────────────────┘
```

### `double`

```text
╔══╣ Title ╠════════════════════════════╗
║ Message                              ║
╚══════════════════════════════════════╝
```

### `round`

```text
╭──┤ Title ├────────────────────────────╮
│ Message                              │
╰──────────────────────────────────────╯
```

### `ascii`

```text
+--] Title [----------------------------+
| Message                              |
+--------------------------------------+
```

## Custom style

Use `--style=custom` and define these environment variables:

| Variable | Meaning |
| -------- | ------- |
| `BOX_TL` | Top-left corner |
| `BOX_TR` | Top-right corner |
| `BOX_BL` | Bottom-left corner |
| `BOX_BR` | Bottom-right corner |
| `BOX_H` | Horizontal line |
| `BOX_V` | Vertical line |
| `BOX_TITLE_L` | Left title separator |
| `BOX_TITLE_R` | Right title separator |

Example:

```bat
set "BOX_TL=*"
set "BOX_TR=*"
set "BOX_BL=*"
set "BOX_BR=*"
set "BOX_H=*"
set "BOX_V=*"
set "BOX_TITLE_L=*"
set "BOX_TITLE_R=*"

call box.cmd --style=custom "Custom" "Message"
```

## Examples

### Heavy box

```bat
call box.cmd "My title" "Message content1\nMessage content2" heavy
```

### Single-line box

```bat
call box.cmd "My title" "Message content1\nMessage content2" single
```

### Double-line box

```bat
call box.cmd "My title" "Message content1\nMessage content2" double
```

### Rounded box

```bat
call box.cmd "My title" "Message content1\nMessage content2" round
```

### ASCII fallback

```bat
call box.cmd "My title" "Message content1\nMessage content2" ascii
```

### Named options

```bat
call box.cmd --title="My title" --message="Message content1\nMessage content2" --style=double --width=60
```

### Environment-driven usage

```bat
set "TITLE=My title"
set "MSG=Message content1\nMessage content2"
set "BOX_STYLE=round"
set "BOX_WIDTH=60"

call box.cmd
```

## Doxygen notes

The script contains Doxygen/JSDoc-style comments.

Because the file extension is `.cmd`, Doxygen may not scan it by default. Add something like this to your `Doxyfile`:

```text
INPUT                  = .
FILE_PATTERNS          = *.cmd
EXTENSION_MAPPING      = cmd=JavaScript
EXTRACT_ALL            = YES
JAVADOC_AUTOBRIEF      = YES
OPTIMIZE_OUTPUT_JAVA   = YES
```

Alternatively, copy the JScript section to a `.js` file before generating documentation.

## Limitations

- Display width is calculated using JavaScript string length.
- Emoji, combining marks, and East Asian full-width characters may not align perfectly.
- The script is intended for normal console text, not full Markdown rendering.
