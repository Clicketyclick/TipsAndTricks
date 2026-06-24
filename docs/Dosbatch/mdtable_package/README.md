# mdtable.cmd

`mdtable.cmd` converts a Markdown pipe table into a console table using box-drawing characters.

It is a hybrid Windows Batch + JScript script, so it can be called directly from `cmd.exe` without installing Node.js, Python, PowerShell modules, or external tools.

## Features

- Reads Markdown pipe tables from a file or from `STDIN`
- Supports Markdown header separator rows
- Supports Markdown alignment syntax
- Supports escaped pipe characters: `\|`
- Supports wrapping of long cell contents
- Supports total table width limit
- Supports per-column maximum width
- Supports multiple box styles
- Restores the original Windows code page after execution

## Requirements

- Windows
- `cmd.exe`
- Windows Script Host / `cscript.exe`

## Encoding

The script switches the console to UTF-8 while running:

```bat
chcp 65001
```

The original code page is restored when the script exits.

The box-drawing characters are stored internally as Unicode escape sequences, so the script is less sensitive to file encoding problems than scripts containing literal Unicode characters.

## Usage

```bat
mdtable.cmd [options] [file]
```

or:

```bat
type table.md | mdtable.cmd [options]
```

## Basic example

Input file `table.md`:

```markdown
| Syntax      | Description |
| ----------- | ----------- |
| Header      | Title       |
| Paragraph   | Text        |
```

Command:

```bat
call mdtable.cmd table.md
```

Output:

```text
┌───────────┬─────────────┐
│ Syntax    │ Description │
├───────────┼─────────────┤
│ Header    │ Title       │
│ Paragraph │ Text        │
└───────────┴─────────────┘
```

## Options

| Option | Description |
| ------ | ----------- |
| `--help` | Show help |
| `-help` | Show help |
| `/?` | Show help |
| `--version` | Show version |
| `--style=NAME` | Select table style |
| `--max-width=N` | Set maximum total rendered table width |
| `-w N` | Short form of `--max-width=N` |
| `--min-col-width=N` | Set minimum column width when shrinking columns |
| `--col-max=N` | Set maximum width for each individual column |
| `--tab-width=N` | Set tab width |
| `--wrap` | Enable wrapping |
| `--no-wrap` | Disable wrapping |

## Supported styles

### `single`

```text
┌──────┬──────┐
│ A    │ B    │
├──────┼──────┤
│ One  │ Two  │
└──────┴──────┘
```

### `heavy`

```text
┏━━━━━━┳━━━━━━┓
┃ A    ┃ B    ┃
┣━━━━━━╋━━━━━━┫
┃ One  ┃ Two  ┃
┗━━━━━━┻━━━━━━┛
```

### `double`

```text
╔══════╦══════╗
║ A    ║ B    ║
╠══════╬══════╣
║ One  ║ Two  ║
╚══════╩══════╝
```

### `round`

```text
╭──────┬──────╮
│ A    │ B    │
├──────┼──────┤
│ One  │ Two  │
╰──────┴──────╯
```

### `ascii`

```text
+------+------+ 
| A    | B    |
+------+------+ 
| One  | Two  |
+------+------+ 
```

## Width and wrapping

### Maximum total table width

```bat
call mdtable.cmd --max-width=50 table.md
```

The value is the full rendered table width, including:

- Left border
- Right border
- Column separators
- Cell padding spaces
- Cell content

For a two-column table:

```text
┌────────┬────────┐
│ value  │ value  │
└────────┴────────┘
```

the total width is:

```text
sum(column_widths) + 2 * column_count + column_count + 1
```

or:

```text
sum(column_widths) + 3 * column_count + 1
```

### Example with wrapping

Input:

```markdown
| Syntax | Description |
| ------ | ----------- |
| Header | This is a very long description that should wrap inside the table cell |
| Paragraph | Text |
```

Command:

```bat
call mdtable.cmd --max-width=50 table.md
```

Output:

```text
┌───────────┬──────────────────────────────┐
│ Syntax    │ Description                  │
├───────────┼──────────────────────────────┤
│ Header    │ This is a very long          │
│           │ description that should wrap │
│           │ inside the table cell        │
│ Paragraph │ Text                         │
└───────────┴──────────────────────────────┘
```

## Per-column maximum width

```bat
call mdtable.cmd --col-max=20 table.md
```

This limits each individual column to 20 characters before wrapping.

You can combine it with `--max-width`:

```bat
call mdtable.cmd --max-width=80 --col-max=30 table.md
```

## Minimum column width

```bat
call mdtable.cmd --max-width=40 --min-col-width=8 table.md
```

When shrinking columns to satisfy `--max-width`, no column will be made smaller than `--min-col-width`.

If `--max-width` is too small to satisfy `--min-col-width`, the rendered table may exceed `--max-width`.

## Markdown alignment

Input:

```markdown
| Left | Center | Right |
| :--- | :----: | ----: |
| A    | B      | C     |
| 123  | 456    | 789   |
```

Command:

```bat
call mdtable.cmd table.md
```

Output:

```text
┌──────┬────────┬───────┐
│ Left │ Center │ Right │
├──────┼────────┼───────┤
│ A    │   B    │     C │
│ 123  │  456   │   789 │
└──────┴────────┴───────┘
```

## Escaped pipe characters

Input:

```markdown
| Syntax | Description |
| ------ | ----------- |
| A \| B | Literal pipe in cell |
```

Output:

```text
┌────────┬──────────────────────┐
│ Syntax │ Description          │
├────────┼──────────────────────┤
│ A | B  │ Literal pipe in cell │
└────────┴──────────────────────┘
```

## Hard line breaks inside cells

Literal `\n` is treated as a hard line break inside a cell:

```markdown
| Field | Value |
| ----- | ----- |
| Note  | Line one\nLine two\nLine three |
```

## Environment variables

You can define default behavior through environment variables.

```bat
set "TABLE_STYLE=round"
set "TABLE_MAX_WIDTH=70"
set "TABLE_MIN_COL_WIDTH=8"
set "TABLE_COL_MAX_WIDTH=30"
set "TABLE_TAB_WIDTH=4"

call mdtable.cmd table.md
```

Command-line options override environment defaults.

## Examples

### Read from file

```bat
call mdtable.cmd table.md
```

### Read from pipe

```bat
type table.md | call mdtable.cmd
```

### Use double lines

```bat
call mdtable.cmd --style=double table.md
```

### Use rounded corners and wrapping

```bat
call mdtable.cmd --style=round --max-width=60 table.md
```

### Use ASCII fallback

```bat
call mdtable.cmd --style=ascii table.md
```

### Disable wrapping

```bat
call mdtable.cmd --no-wrap table.md
```

## Doxygen notes

The script contains Doxygen/JSDoc-style comments.

Because the file extension is `.cmd`, Doxygen may not scan it by default. Add a configuration like this to your `Doxyfile`:

```text
INPUT                  = .
FILE_PATTERNS          = *.cmd
EXTENSION_MAPPING      = cmd=JavaScript
EXTRACT_ALL            = YES
JAVADOC_AUTOBRIEF      = YES
OPTIMIZE_OUTPUT_JAVA   = YES
```

Alternatively, copy the JScript section to a `.js` file for documentation generation.

## Limitations

- Display width is calculated using JavaScript string length.
- Emoji, combining marks, and East Asian full-width characters may not align perfectly.
- Markdown parsing is intentionally simple and focused on pipe tables.
- Inline Markdown formatting is not interpreted; it is printed literally.
