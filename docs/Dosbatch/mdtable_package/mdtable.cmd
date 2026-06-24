@if (@X)==(@Y) @end /*
@echo off
setlocal EnableExtensions DisableDelayedExpansion

rem ---------------------------------------------------------------------------
rem mdtable.cmd
rem
rem Converts a Markdown pipe table into a box-drawing table.
rem
rem This is a hybrid Windows CMD + JScript script.
rem Save this file as UTF-8 if possible.
rem ---------------------------------------------------------------------------

for /f "tokens=2 delims=:" %%C in ('chcp') do set "OLDCP=%%C"
set "OLDCP=%OLDCP: =%"
chcp 65001 >nul

cscript //nologo //E:JScript "%~f0" %*
set "RC=%ERRORLEVEL%"

if defined OLDCP chcp %OLDCP% >nul
exit /b %RC%
*/

/**
 * @file mdtable.cmd
 * @brief Convert Markdown pipe tables to box-drawing console tables.
 *
 * @details
 * This script reads a Markdown pipe table from a file or from STDIN and renders
 * it as a console table using Unicode box-drawing characters.
 *
 * The script supports:
 *
 * - Markdown pipe table parsing
 * - Optional Markdown alignment syntax
 * - Escaped pipe characters: `\|`
 * - Unicode, single, heavy, double, rounded, and ASCII styles
 * - Wrapping of long cell contents
 * - Maximum total table width
 * - Maximum individual column width
 * - Minimum column width
 * - Input from file or pipe
 *
 * @par Basic usage
 *
 * @code{.bat}
 * call mdtable.cmd table.md
 * type table.md | call mdtable.cmd
 * call mdtable.cmd --style=double --max-width=80 table.md
 * @endcode
 *
 * @par Markdown input
 *
 * @code{.md}
 * | Syntax    | Description |
 * | --------- | ----------- |
 * | Header    | Title       |
 * | Paragraph | Text        |
 * @endcode
 *
 * @author Erik Bachmann / generated helper
 * @version 1.0.0
 */

(function () {
    /**
     * @brief Windows Script Host shell object.
     * @type {ActiveXObject}
     */
    var sh = new ActiveXObject("WScript.Shell");

    /**
     * @brief Process environment variables.
     * @type {Object}
     */
    var env = sh.Environment("PROCESS");

    /**
     * @brief FileSystemObject used for file input.
     * @type {ActiveXObject}
     */
    var fso = new ActiveXObject("Scripting.FileSystemObject");

    /**
     * @brief Parsed command-line options.
     * @type {Object}
     */
    var options = parseOptions(WScript.Arguments, env);

    if (options.help) {
        printHelp();
        WScript.Quit(0);
    }

    if (options.version) {
        write("mdtable.cmd 1.0.0");
        WScript.Quit(0);
    }

    /**
     * @brief Style character map used by the renderer.
     * @type {Object}
     */
    var chars = getStyle(options.style);

    /**
     * @brief Markdown input source text.
     * @type {String}
     */
    var input = "";

    if (options.file) {
        input = readFileUtf8(options.file);
    } else {
        input = WScript.StdIn.ReadAll();
    }

    /**
     * @brief Parsed Markdown table.
     * @type {Object}
     */
    var table = parseMarkdownTable(input, options);

    if (table.rows.length === 0) {
        fail("No markdown table rows found.", 1);
    }

    renderTable(table, chars, options);

    /**
     * @brief Parse command-line options and environment fallbacks.
     *
     * @param {Object} args
     *        WScript.Arguments collection.
     *
     * @param {Object} env
     *        Process environment.
     *
     * @return {Object}
     *         Parsed option object.
     *
     * @details
     * Supported command-line options:
     *
     * - `--help`
     * - `--version`
     * - `--style=single|heavy|double|round|ascii`
     * - `--max-width=N`
     * - `-w N`
     * - `--min-col-width=N`
     * - `--col-max=N`
     * - `--wrap`
     * - `--no-wrap`
     * - `--tab-width=N`
     *
     * Environment variables:
     *
     * - `TABLE_STYLE`
     * - `TABLE_MAX_WIDTH`
     * - `TABLE_MIN_COL_WIDTH`
     * - `TABLE_COL_MAX_WIDTH`
     * - `TABLE_TAB_WIDTH`
     *
     * @note
     * If no input file is provided, the script reads from STDIN.
     */
    function parseOptions(args, env) {
        var o = {
            help: false,
            version: false,
            style: env("TABLE_STYLE") || "single",
            file: "",
            maxWidth: parsePositiveInt(env("TABLE_MAX_WIDTH"), 0),
            minColWidth: parsePositiveInt(env("TABLE_MIN_COL_WIDTH"), 6),
            colMaxWidth: parsePositiveInt(env("TABLE_COL_MAX_WIDTH"), 0),
            tabWidth: parsePositiveInt(env("TABLE_TAB_WIDTH"), 4),
            wrap: true
        };

        var i;
        var arg;
        var value;

        for (i = 0; i < args.length; i++) {
            arg = String(args.Item(i));

            if (/^--?help$/i.test(arg) || /^\/\?$/i.test(arg)) {
                o.help = true;
                continue;
            }

            if (/^--?version$/i.test(arg)) {
                o.version = true;
                continue;
            }

            value = optionValue(arg, /^--?style(?:[:=](.*))?$/i);
            if (value !== null) {
                if (value === "") {
                    i++;
                    requireArg(args, i, "--style");
                    value = String(args.Item(i));
                }

                o.style = value;
                continue;
            }

            value = optionValue(arg, /^--?max[-_]?width(?:[:=](.*))?$/i);
            if (value !== null) {
                if (value === "") {
                    i++;
                    requireArg(args, i, "--max-width");
                    value = String(args.Item(i));
                }

                o.maxWidth = parsePositiveInt(value, 0);
                continue;
            }

            value = optionValue(arg, /^-w(?:[:=](.*))?$/i);
            if (value !== null) {
                if (value === "") {
                    i++;
                    requireArg(args, i, "-w");
                    value = String(args.Item(i));
                }

                o.maxWidth = parsePositiveInt(value, 0);
                continue;
            }

            value = optionValue(arg, /^--?min[-_]?col[-_]?width(?:[:=](.*))?$/i);
            if (value !== null) {
                if (value === "") {
                    i++;
                    requireArg(args, i, "--min-col-width");
                    value = String(args.Item(i));
                }

                o.minColWidth = parsePositiveInt(value, 6);
                continue;
            }

            value = optionValue(arg, /^--?col[-_]?max(?:[:=](.*))?$/i);
            if (value !== null) {
                if (value === "") {
                    i++;
                    requireArg(args, i, "--col-max");
                    value = String(args.Item(i));
                }

                o.colMaxWidth = parsePositiveInt(value, 0);
                continue;
            }

            value = optionValue(arg, /^--?max[-_]?col[-_]?width(?:[:=](.*))?$/i);
            if (value !== null) {
                if (value === "") {
                    i++;
                    requireArg(args, i, "--max-col-width");
                    value = String(args.Item(i));
                }

                o.colMaxWidth = parsePositiveInt(value, 0);
                continue;
            }

            value = optionValue(arg, /^--?tab[-_]?width(?:[:=](.*))?$/i);
            if (value !== null) {
                if (value === "") {
                    i++;
                    requireArg(args, i, "--tab-width");
                    value = String(args.Item(i));
                }

                o.tabWidth = parsePositiveInt(value, 4);
                continue;
            }

            if (/^--?wrap$/i.test(arg)) {
                o.wrap = true;
                continue;
            }

            if (/^--?no[-_]?wrap$/i.test(arg)) {
                o.wrap = false;
                continue;
            }

            if (isKnownStyle(arg)) {
                o.style = arg;
                continue;
            }

            if (!o.file) {
                o.file = arg;
                continue;
            }

            fail("Unexpected argument: " + arg, 2);
        }

        o.style = String(o.style || "single").toLowerCase();

        if (!isKnownStyle(o.style)) {
            fail("Unknown style: " + o.style, 2);
        }

        if (o.minColWidth < 1) {
            o.minColWidth = 1;
        }

        if (o.tabWidth < 1) {
            o.tabWidth = 4;
        }

        return o;
    }

    /**
     * @brief Extract an option value from a command-line argument.
     *
     * @param {String} arg
     *        Command-line argument.
     *
     * @param {RegExp} regex
     *        Regular expression with optional capture group for the value.
     *
     * @return {String|null}
     *         `null` if the argument does not match.
     *         Empty string if the option matched but the value must be read
     *         from the following argument.
     */
    function optionValue(arg, regex) {
        var m = String(arg).match(regex);

        if (!m) {
            return null;
        }

        if (m.length > 1 && m[1] !== undefined) {
            return String(m[1]);
        }

        return "";
    }

    /**
     * @brief Ensure that an option expecting a following value has one.
     *
     * @param {Object} args
     *        WScript.Arguments collection.
     *
     * @param {Number} index
     *        Candidate index.
     *
     * @param {String} optionName
     *        Option name for the error message.
     */
    function requireArg(args, index, optionName) {
        if (index >= args.length) {
            fail("Missing value for " + optionName, 2);
        }
    }

    /**
     * @brief Parse a positive integer.
     *
     * @param {String} value
     *        Input value.
     *
     * @param {Number} fallback
     *        Fallback value.
     *
     * @return {Number}
     *         Parsed integer or fallback.
     */
    function parsePositiveInt(value, fallback) {
        var n = parseInt(value, 10);

        if (isNaN(n) || n < 0) {
            return fallback;
        }

        return n;
    }

    /**
     * @brief Parse Markdown input into table rows and alignment metadata.
     *
     * @param {String} input
     *        Markdown source text.
     *
     * @param {Object} options
     *        Runtime options.
     *
     * @return {Object}
     *         Parsed table object:
     *
     *         - `rows`
     *         - `separatorIndex`
     *         - `alignments`
     *
     * @details
     * A Markdown separator row such as:
     *
     * @code
     * | --- | :---: | ---: |
     * @endcode
     *
     * is not emitted as data. Instead, it is used to determine column
     * alignment and the position of the header separator line.
     */
    function parseMarkdownTable(input, options) {
        input = String(input || "").replace(/\r\n/g, "\n").replace(/\r/g, "\n");

        var rawLines = input.split("\n");
        var rows = [];
        var separatorIndex = -1;
        var alignments = [];

        for (var i = 0; i < rawLines.length; i++) {
            var line = trim(rawLines[i]);

            if (!line) {
                continue;
            }

            if (line.indexOf("|") < 0) {
                continue;
            }

            var cells = splitMarkdownRow(line, options);

            if (cells.length === 0) {
                continue;
            }

            if (isSeparatorRow(cells)) {
                separatorIndex = rows.length;
                alignments = getAlignments(cells);
                continue;
            }

            rows.push(cells);
        }

        normalizeColumnCount(rows, alignments);

        return {
            rows: rows,
            separatorIndex: separatorIndex,
            alignments: alignments
        };
    }

    /**
     * @brief Split one Markdown pipe-table row into cells.
     *
     * @param {String} line
     *        Markdown source line.
     *
     * @param {Object} options
     *        Runtime options.
     *
     * @return {String[]}
     *         List of cell values.
     *
     * @details
     * Leading and trailing pipe characters are optional.
     *
     * Escaped pipe characters are supported:
     *
     * @code
     * | A \| B | C |
     * @endcode
     *
     * The escaped pipe becomes a literal pipe in the cell content.
     */
    function splitMarkdownRow(line, options) {
        line = trim(line);

        if (line.charAt(0) === "|") {
            line = line.substring(1);
        }

        if (line.charAt(line.length - 1) === "|") {
            line = line.substring(0, line.length - 1);
        }

        var cells = [];
        var cell = "";
        var escaped = false;

        for (var i = 0; i < line.length; i++) {
            var ch = line.charAt(i);

            if (escaped) {
                cell += ch;
                escaped = false;
                continue;
            }

            if (ch === "\\") {
                escaped = true;
                continue;
            }

            if (ch === "|") {
                cells.push(normalizeCell(cell, options));
                cell = "";
                continue;
            }

            cell += ch;
        }

        cells.push(normalizeCell(cell, options));

        return cells;
    }

    /**
     * @brief Normalize a cell value.
     *
     * @param {String} cell
     *        Raw cell text.
     *
     * @param {Object} options
     *        Runtime options.
     *
     * @return {String}
     *         Normalized cell text.
     *
     * @details
     * This function:
     *
     * - Trims leading and trailing whitespace
     * - Expands tab characters
     * - Converts literal `\t` to tabs before expansion
     * - Leaves literal `\n` available for wrapping as hard line breaks
     */
    function normalizeCell(cell, options) {
        cell = trim(cell);
        cell = cell.replace(/\\t/g, "\t");
        cell = expandTabs(cell, options.tabWidth);

        return cell;
    }

    /**
     * @brief Determine whether a row is a Markdown separator row.
     *
     * @param {String[]} cells
     *        Cell values.
     *
     * @return {Boolean}
     *         True if the row is a separator row.
     */
    function isSeparatorRow(cells) {
        if (cells.length === 0) {
            return false;
        }

        for (var i = 0; i < cells.length; i++) {
            var cell = trim(cells[i]).replace(/\s+/g, "");

            if (!/^:?-{3,}:?$/.test(cell)) {
                return false;
            }
        }

        return true;
    }

    /**
     * @brief Extract Markdown alignment settings from a separator row.
     *
     * @param {String[]} cells
     *        Separator row cells.
     *
     * @return {String[]}
     *         Alignment list:
     *
     *         - `left`
     *         - `center`
     *         - `right`
     */
    function getAlignments(cells) {
        var alignments = [];

        for (var i = 0; i < cells.length; i++) {
            var cell = trim(cells[i]).replace(/\s+/g, "");
            var left = cell.charAt(0) === ":";
            var right = cell.charAt(cell.length - 1) === ":";

            if (left && right) {
                alignments.push("center");
            } else if (right) {
                alignments.push("right");
            } else {
                alignments.push("left");
            }
        }

        return alignments;
    }

    /**
     * @brief Normalize all rows to the same column count.
     *
     * @param {String[][]} rows
     *        Table rows.
     *
     * @param {String[]} alignments
     *        Column alignments.
     *
     * @details
     * Missing cells are filled with empty strings.
     * Missing alignments default to left alignment.
     */
    function normalizeColumnCount(rows, alignments) {
        var colCount = 0;

        for (var r = 0; r < rows.length; r++) {
            if (rows[r].length > colCount) {
                colCount = rows[r].length;
            }
        }

        if (alignments.length > colCount) {
            colCount = alignments.length;
        }

        for (var rr = 0; rr < rows.length; rr++) {
            while (rows[rr].length < colCount) {
                rows[rr].push("");
            }
        }

        while (alignments.length < colCount) {
            alignments.push("left");
        }
    }

    /**
     * @brief Render a parsed table.
     *
     * @param {Object} table
     *        Parsed table object.
     *
     * @param {Object} c
     *        Style character map.
     *
     * @param {Object} options
     *        Runtime options.
     */
    function renderTable(table, c, options) {
        var rows = table.rows;
        var widths = calculateWidths(rows, options);

        write(borderLine(c.tl, c.tm, c.tr, widths, c.h));

        for (var i = 0; i < rows.length; i++) {
            writeWrappedRow(rows[i], widths, table.alignments, c, options.wrap);

            if (table.separatorIndex > 0 && (i + 1) === table.separatorIndex) {
                write(borderLine(c.ml, c.mm, c.mr, widths, c.h));
            }
        }

        write(borderLine(c.bl, c.bm, c.br, widths, c.h));
    }

    /**
     * @brief Calculate final column widths.
     *
     * @param {String[][]} rows
     *        Table rows.
     *
     * @param {Object} options
     *        Runtime options.
     *
     * @return {Number[]}
     *         Calculated column widths.
     *
     * @details
     * Width processing order:
     *
     * 1. Start with the longest cell in each column.
     * 2. Apply `--col-max`, if set.
     * 3. Shrink columns to fit `--max-width`, if set.
     *
     * The `--max-width` option is the full rendered table width including
     * borders and padding.
     */
    function calculateWidths(rows, options) {
        var widths = [];

        for (var r = 0; r < rows.length; r++) {
            for (var col = 0; col < rows[r].length; col++) {
                var len = longestVisualLineLength(rows[r][col]);

                if (widths[col] === undefined || len > widths[col]) {
                    widths[col] = len;
                }
            }
        }

        for (var i = 0; i < widths.length; i++) {
            if (!widths[i] || widths[i] < 1) {
                widths[i] = 1;
            }

            if (options.colMaxWidth && options.colMaxWidth > 0 && widths[i] > options.colMaxWidth) {
                widths[i] = options.colMaxWidth;
            }
        }

        if (options.maxWidth && options.maxWidth > 0) {
            widths = shrinkToMaxTableWidth(widths, options.maxWidth, options.minColWidth);
        }

        return widths;
    }

    /**
     * @brief Shrink column widths until the whole table fits a maximum width.
     *
     * @param {Number[]} widths
     *        Current column widths.
     *
     * @param {Number} maxWidth
     *        Maximum total rendered table width.
     *
     * @param {Number} minColWidth
     *        Minimum allowed column width.
     *
     * @return {Number[]}
     *         Adjusted column widths.
     *
     * @details
     * Rendered table width is calculated as:
     *
     * @code
     * sum(column_widths) + 2 * column_count + column_count + 1
     * @endcode
     *
     * That is:
     *
     * - Cell content widths
     * - One leading and one trailing padding space per cell
     * - One vertical border/separator for every boundary
     *
     * If `--max-width` is smaller than what `--min-col-width` permits, the
     * script will honor `--min-col-width` and the rendered table may exceed
     * `--max-width`.
     */
    function shrinkToMaxTableWidth(widths, maxWidth, minColWidth) {
        var colCount = widths.length;
        var maxContentWidth = maxWidth - (3 * colCount + 1);

        if (maxContentWidth < colCount) {
            maxContentWidth = colCount;
        }

        var minTotal = 0;

        for (var i = 0; i < widths.length; i++) {
            minTotal += Math.min(widths[i], minColWidth);
        }

        if (maxContentWidth < minTotal) {
            maxContentWidth = minTotal;
        }

        while (sum(widths) > maxContentWidth) {
            var index = indexOfLargestShrinkableColumn(widths, minColWidth);

            if (index < 0) {
                break;
            }

            widths[index]--;
        }

        return widths;
    }

    /**
     * @brief Find the largest column that can still be shrunk.
     *
     * @param {Number[]} widths
     *        Column widths.
     *
     * @param {Number} minColWidth
     *        Minimum allowed column width.
     *
     * @return {Number}
     *         Column index, or `-1` if no column can be shrunk.
     */
    function indexOfLargestShrinkableColumn(widths, minColWidth) {
        var index = -1;
        var largest = -1;

        for (var i = 0; i < widths.length; i++) {
            if (widths[i] > minColWidth && widths[i] > largest) {
                largest = widths[i];
                index = i;
            }
        }

        return index;
    }

    /**
     * @brief Render one logical table row, wrapping cells as needed.
     *
     * @param {String[]} row
     *        Row cells.
     *
     * @param {Number[]} widths
     *        Column widths.
     *
     * @param {String[]} alignments
     *        Column alignments.
     *
     * @param {Object} c
     *        Style character map.
     *
     * @param {Boolean} wrap
     *        Whether wrapping is enabled.
     */
    function writeWrappedRow(row, widths, alignments, c, wrap) {
        var wrapped = [];
        var height = 1;

        for (var i = 0; i < widths.length; i++) {
            var cell = row[i] || "";

            if (wrap) {
                wrapped[i] = wrapText(cell, widths[i]);
            } else {
                wrapped[i] = [cell];
            }

            if (wrapped[i].length > height) {
                height = wrapped[i].length;
            }
        }

        for (var lineNo = 0; lineNo < height; lineNo++) {
            var out = c.v;

            for (var col = 0; col < widths.length; col++) {
                var part = wrapped[col][lineNo] || "";
                out += " " + align(part, widths[col], alignments[col]) + " " + c.v;
            }

            write(out);
        }
    }

    /**
     * @brief Wrap text to a given display width.
     *
     * @param {String} text
     *        Cell text.
     *
     * @param {Number} width
     *        Maximum line width.
     *
     * @return {String[]}
     *         Wrapped visual lines.
     *
     * @details
     * Wrapping behavior:
     *
     * - Wraps on whitespace when possible
     * - Splits overlong words when necessary
     * - Treats literal `\n`, `\r`, and `\r\n` as hard line breaks
     */
    function wrapText(text, width) {
        text = String(text || "");

        if (width < 1) {
            return [text];
        }

        var result = [];
        var paragraphs = text.replace(/\\r\\n/g, "\n")
                             .replace(/\\n/g, "\n")
                             .replace(/\\r/g, "\n")
                             .split(/\n/);

        for (var p = 0; p < paragraphs.length; p++) {
            var paragraph = trim(paragraphs[p]);

            if (paragraph === "") {
                result.push("");
                continue;
            }

            var words = paragraph.split(/\s+/);
            var line = "";

            for (var i = 0; i < words.length; i++) {
                var word = words[i];

                while (displayLength(word) > width) {
                    if (line !== "") {
                        result.push(line);
                        line = "";
                    }

                    result.push(word.substring(0, width));
                    word = word.substring(width);
                }

                if (line === "") {
                    line = word;
                    continue;
                }

                if (displayLength(line + " " + word) <= width) {
                    line += " " + word;
                } else {
                    result.push(line);
                    line = word;
                }
            }

            if (line !== "") {
                result.push(line);
            }
        }

        if (result.length === 0) {
            result.push("");
        }

        return result;
    }

    /**
     * @brief Create a border line.
     *
     * @param {String} left
     *        Left border character.
     *
     * @param {String} middle
     *        Middle separator character.
     *
     * @param {String} right
     *        Right border character.
     *
     * @param {Number[]} widths
     *        Column widths.
     *
     * @param {String} h
     *        Horizontal line character.
     *
     * @return {String}
     *         Rendered border line.
     */
    function borderLine(left, middle, right, widths, h) {
        var out = left;

        for (var i = 0; i < widths.length; i++) {
            out += repeat(h, widths[i] + 2);

            if (i < widths.length - 1) {
                out += middle;
            }
        }

        out += right;

        return out;
    }

    /**
     * @brief Align text within a fixed-width cell.
     *
     * @param {String} s
     *        Text to align.
     *
     * @param {Number} width
     *        Cell width.
     *
     * @param {String} mode
     *        Alignment mode: `left`, `center`, or `right`.
     *
     * @return {String}
     *         Aligned text.
     */
    function align(s, width, mode) {
        s = String(s || "");

        var len = displayLength(s);
        var diff = width - len;

        if (diff <= 0) {
            return s;
        }

        if (mode === "right") {
            return repeat(" ", diff) + s;
        }

        if (mode === "center") {
            var left = Math.floor(diff / 2);
            var right = diff - left;
            return repeat(" ", left) + s + repeat(" ", right);
        }

        return s + repeat(" ", diff);
    }

    /**
     * @brief Return the longest visual line length in a cell.
     *
     * @param {String} s
     *        Cell text.
     *
     * @return {Number}
     *         Longest visual line length.
     */
    function longestVisualLineLength(s) {
        s = String(s || "")
            .replace(/\\r\\n/g, "\n")
            .replace(/\\n/g, "\n")
            .replace(/\\r/g, "\n");

        var lines = s.split(/\n/);
        var max = 0;

        for (var i = 0; i < lines.length; i++) {
            var len = displayLength(lines[i]);

            if (len > max) {
                max = len;
            }
        }

        return max;
    }

    /**
     * @brief Return display length of a string.
     *
     * @param {String} s
     *        Input string.
     *
     * @return {Number}
     *         Display length.
     *
     * @warning
     * This currently uses JavaScript string length. It works well for normal
     * Latin text, but does not calculate terminal width correctly for all
     * emoji, combining marks, or East Asian full-width characters.
     */
    function displayLength(s) {
        return String(s || "").length;
    }

    /**
     * @brief Return a style character map.
     *
     * @param {String} style
     *        Style name.
     *
     * @return {Object}
     *         Box-drawing character map.
     *
     * @details
     * Supported style names:
     *
     * - `single`
     * - `heavy`
     * - `double`
     * - `round`
     * - `ascii`
     */
    function getStyle(style) {
        var styles = {
            single: {
                tl: "\u250c", tm: "\u252c", tr: "\u2510",
                ml: "\u251c", mm: "\u253c", mr: "\u2524",
                bl: "\u2514", bm: "\u2534", br: "\u2518",
                h: "\u2500", v: "\u2502"
            },

            heavy: {
                tl: "\u250f", tm: "\u2533", tr: "\u2513",
                ml: "\u2523", mm: "\u254b", mr: "\u252b",
                bl: "\u2517", bm: "\u253b", br: "\u251b",
                h: "\u2501", v: "\u2503"
            },

            double: {
                tl: "\u2554", tm: "\u2566", tr: "\u2557",
                ml: "\u2560", mm: "\u256c", mr: "\u2563",
                bl: "\u255a", bm: "\u2569", br: "\u255d",
                h: "\u2550", v: "\u2551"
            },

            round: {
                tl: "\u256d", tm: "\u252c", tr: "\u256e",
                ml: "\u251c", mm: "\u253c", mr: "\u2524",
                bl: "\u2570", bm: "\u2534", br: "\u256f",
                h: "\u2500", v: "\u2502"
            },

            ascii: {
                tl: "+", tm: "+", tr: "+",
                ml: "+", mm: "+", mr: "+",
                bl: "+", bm: "+", br: "+",
                h: "-", v: "|"
            }
        };

        return styles[String(style || "single").toLowerCase()];
    }

    /**
     * @brief Test whether a style name is known.
     *
     * @param {String} style
     *        Style name.
     *
     * @return {Boolean}
     *         True if known.
     */
    function isKnownStyle(style) {
        style = String(style || "").toLowerCase();
        return /^(single|heavy|double|round|ascii)$/.test(style);
    }

    /**
     * @brief Read a text file as UTF-8.
     *
     * @param {String} path
     *        File path.
     *
     * @return {String}
     *         File contents.
     *
     * @details
     * Uses `ADODB.Stream` for UTF-8 support.
     * Falls back to `FileSystemObject.OpenTextFile()` if ADODB is unavailable.
     */
    function readFileUtf8(path) {
        if (!fso.FileExists(path)) {
            fail("File not found: " + path, 2);
        }

        try {
            var stream = new ActiveXObject("ADODB.Stream");
            stream.Type = 2;
            stream.Charset = "utf-8";
            stream.Open();
            stream.LoadFromFile(path);
            var text = stream.ReadText();
            stream.Close();
            return text;
        } catch (e) {
            var file = fso.OpenTextFile(path, 1);
            var fallback = file.ReadAll();
            file.Close();
            return fallback;
        }
    }

    /**
     * @brief Expand tab characters to spaces.
     *
     * @param {String} s
     *        Input string.
     *
     * @param {Number} tabWidth
     *        Tab width.
     *
     * @return {String}
     *         String with tabs expanded.
     */
    function expandTabs(s, tabWidth) {
        var out = "";
        var col = 0;

        for (var i = 0; i < s.length; i++) {
            var ch = s.charAt(i);

            if (ch === "\t") {
                var spaces = tabWidth - (col % tabWidth);
                out += repeat(" ", spaces);
                col += spaces;
            } else {
                out += ch;
                col++;
            }
        }

        return out;
    }

    /**
     * @brief Trim whitespace from both ends of a string.
     *
     * @param {String} s
     *        Input string.
     *
     * @return {String}
     *         Trimmed string.
     */
    function trim(s) {
        return String(s || "").replace(/^\s+|\s+$/g, "");
    }

    /**
     * @brief Repeat a string.
     *
     * @param {String} ch
     *        String to repeat.
     *
     * @param {Number} count
     *        Number of repetitions.
     *
     * @return {String}
     *         Repeated string.
     */
    function repeat(ch, count) {
        var s = "";

        for (var i = 0; i < count; i++) {
            s += ch;
        }

        return s;
    }

    /**
     * @brief Sum an array of numbers.
     *
     * @param {Number[]} values
     *        Values to sum.
     *
     * @return {Number}
     *         Sum.
     */
    function sum(values) {
        var total = 0;

        for (var i = 0; i < values.length; i++) {
            total += values[i];
        }

        return total;
    }

    /**
     * @brief Write a line to STDOUT.
     *
     * @param {String} s
     *        Output line.
     */
    function write(s) {
        WScript.StdOut.WriteLine(s);
    }

    /**
     * @brief Write an error and exit.
     *
     * @param {String} message
     *        Error message.
     *
     * @param {Number} code
     *        Exit code.
     */
    function fail(message, code) {
        WScript.StdErr.WriteLine("ERROR: " + message);
        WScript.Quit(code || 1);
    }

    /**
     * @brief Print command-line help.
     */
    function printHelp() {
        write("");
        write("mdtable.cmd - Convert Markdown pipe tables to box-drawing console tables");
        write("");
        write("USAGE:");
        write("  mdtable.cmd [options] [file]");
        write("  type table.md | mdtable.cmd [options]");
        write("");
        write("OPTIONS:");
        write("  --help, -help, /?              Show this help text");
        write("  --version                      Show version");
        write("  --style=NAME                   Table style");
        write("                                 single, heavy, double, round, ascii");
        write("  --max-width=N, -w N            Maximum total rendered table width");
        write("  --min-col-width=N              Minimum column width when shrinking");
        write("  --col-max=N                    Maximum width of each individual column");
        write("  --tab-width=N                  Tab width, default 4");
        write("  --wrap                         Enable wrapping, default");
        write("  --no-wrap                      Disable wrapping");
        write("");
        write("ENVIRONMENT:");
        write("  TABLE_STYLE                    Default style");
        write("  TABLE_MAX_WIDTH                Default maximum total table width");
        write("  TABLE_MIN_COL_WIDTH            Default minimum column width");
        write("  TABLE_COL_MAX_WIDTH            Default maximum column width");
        write("  TABLE_TAB_WIDTH                Default tab width");
        write("");
        write("EXAMPLES:");
        write("  mdtable.cmd table.md");
        write("  mdtable.cmd --style=double table.md");
        write("  mdtable.cmd --max-width=60 table.md");
        write("  mdtable.cmd --style=round --max-width=70 --min-col-width=8 table.md");
        write("  type table.md | mdtable.cmd --max-width=50");
        write("");
    }
})();
