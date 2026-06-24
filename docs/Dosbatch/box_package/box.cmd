@if (@X)==(@Y) @end /*
@echo off
setlocal EnableExtensions DisableDelayedExpansion

rem ---------------------------------------------------------------------------
rem box.cmd
rem
rem Prints a titled message box using Unicode box-drawing characters.
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
 * @file box.cmd
 * @brief Render a titled console message box from Windows CMD.
 *
 * @details
 * This script reads a title and message from command-line parameters or from
 * environment variables and prints a box-drawing message block to STDOUT.
 *
 * The script supports:
 *
 * - Positional title and message arguments
 * - Environment fallback: `TITLE` and `MSG`
 * - Literal escape decoding: `\n`, `\r`, `\r\n`, and `\t`
 * - Multiple box-drawing styles
 * - Optional wrapping of long message lines
 * - Configurable inner width
 * - Configurable tab width
 * - Optional custom characters through environment variables
 *
 * @par Basic usage
 *
 * @code{.bat}
 * call box.cmd "My title" "Message content1\nMessage content2"
 * call box.cmd "My title" "Message" single 60
 * call box.cmd --style=double --width=60 "My title" "Message"
 * @endcode
 *
 * @par Environment usage
 *
 * @code{.bat}
 * set "TITLE=My title"
 * set "MSG=Message content1\nMessage content2"
 * set "BOX_STYLE=round"
 * set "BOX_WIDTH=67"
 * call box.cmd
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
     * @brief Runtime options parsed from arguments and environment.
     * @type {Object}
     */
    var options = parseOptions(WScript.Arguments, env);

    if (options.help) {
        printHelp();
        WScript.Quit(0);
    }

    if (options.version) {
        write("box.cmd 1.0.0");
        WScript.Quit(0);
    }

    /**
     * @brief Character map for the selected style.
     * @type {Object}
     */
    var chars = getStyle(options.style, env);

    /**
     * @brief Normalized title string.
     * @type {String}
     */
    var title = decodeEscapes(options.title);

    /**
     * @brief Normalized message string.
     * @type {String}
     */
    var msg = decodeEscapes(options.message);

    title = expandTabs(title.replace(/\r?\n/g, " "), options.tabWidth);
    msg = expandTabsPerLine(msg, options.tabWidth);

    renderBox(title, msg, chars, options);

    /**
     * @brief Parse command-line options and environment fallback values.
     *
     * @param {Object} args
     *        WScript.Arguments collection.
     *
     * @param {Object} env
     *        Process environment.
     *
     * @return {Object}
     *         Parsed runtime options.
     *
     * @details
     * Positional syntax:
     *
     * @code{.bat}
     * box.cmd [title] [message] [style] [width]
     * @endcode
     *
     * Named options:
     *
     * - `--help`
     * - `--version`
     * - `--title=TEXT`
     * - `--message=TEXT`
     * - `--msg=TEXT`
     * - `--style=heavy|single|double|round|ascii|custom`
     * - `--width=N`
     * - `-w N`
     * - `--tab-width=N`
     * - `--wrap`
     * - `--no-wrap`
     *
     * Environment variables:
     *
     * - `TITLE`
     * - `MSG`
     * - `BOX_STYLE`
     * - `BOX_WIDTH`
     * - `BOX_TAB_WIDTH`
     * - `TAB_WIDTH`
     * - `BOX_WRAP`
     */
    function parseOptions(args, env) {
        var o = {
            help: false,
            version: false,
            title: env("TITLE") || "",
            message: env("MSG") || "",
            style: env("BOX_STYLE") || "heavy",
            width: parsePositiveInt(env("BOX_WIDTH"), 67),
            tabWidth: parsePositiveInt(env("BOX_TAB_WIDTH") || env("TAB_WIDTH"), 4),
            wrap: envBool(env("BOX_WRAP"), true)
        };

        var positionals = [];
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

            value = optionValue(arg, /^--?title(?:[:=](.*))?$/i);
            if (value !== null) {
                if (value === "") {
                    i++;
                    requireArg(args, i, "--title");
                    value = String(args.Item(i));
                }

                o.title = value;
                continue;
            }

            value = optionValue(arg, /^--?(?:msg|message)(?:[:=](.*))?$/i);
            if (value !== null) {
                if (value === "") {
                    i++;
                    requireArg(args, i, "--message");
                    value = String(args.Item(i));
                }

                o.message = value;
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

            value = optionValue(arg, /^--?width(?:[:=](.*))?$/i);
            if (value !== null) {
                if (value === "") {
                    i++;
                    requireArg(args, i, "--width");
                    value = String(args.Item(i));
                }

                o.width = parsePositiveInt(value, o.width);
                continue;
            }

            value = optionValue(arg, /^-w(?:[:=](.*))?$/i);
            if (value !== null) {
                if (value === "") {
                    i++;
                    requireArg(args, i, "-w");
                    value = String(args.Item(i));
                }

                o.width = parsePositiveInt(value, o.width);
                continue;
            }

            value = optionValue(arg, /^--?tab[-_]?width(?:[:=](.*))?$/i);
            if (value !== null) {
                if (value === "") {
                    i++;
                    requireArg(args, i, "--tab-width");
                    value = String(args.Item(i));
                }

                o.tabWidth = parsePositiveInt(value, o.tabWidth);
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

            positionals.push(arg);
        }

        if (positionals.length >= 1) {
            o.title = positionals[0];
        }

        if (positionals.length >= 2) {
            o.message = positionals[1];
        }

        if (positionals.length >= 3) {
            o.style = positionals[2];
        }

        if (positionals.length >= 4) {
            o.width = parsePositiveInt(positionals[3], o.width);
        }

        if (positionals.length > 4) {
            fail("Too many positional arguments.", 2);
        }

        o.style = String(o.style || "heavy").toLowerCase();

        if (!isKnownStyle(o.style)) {
            fail("Unknown style: " + o.style, 2);
        }

        if (!o.width || o.width < 10) {
            o.width = 10;
        }

        if (!o.tabWidth || o.tabWidth < 1) {
            o.tabWidth = 4;
        }

        return o;
    }

    /**
     * @brief Extract an option value from one command-line argument.
     *
     * @param {String} arg
     *        Command-line argument.
     *
     * @param {RegExp} regex
     *        Regular expression with an optional value capture group.
     *
     * @return {String|null}
     *         `null` if not matched.
     *         Empty string if matched but the value must be read from the next
     *         argument.
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
     * @brief Require that an option has a following argument value.
     *
     * @param {Object} args
     *        WScript.Arguments collection.
     *
     * @param {Number} index
     *        Argument index to test.
     *
     * @param {String} optionName
     *        Name for error reporting.
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
     *        Input string.
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
     * @brief Parse an environment-style boolean value.
     *
     * @param {String} value
     *        Input value.
     *
     * @param {Boolean} fallback
     *        Fallback value.
     *
     * @return {Boolean}
     *         Boolean result.
     */
    function envBool(value, fallback) {
        value = String(value || "").toLowerCase();

        if (value === "1" || value === "yes" || value === "true" || value === "on") {
            return true;
        }

        if (value === "0" || value === "no" || value === "false" || value === "off") {
            return false;
        }

        return fallback;
    }

    /**
     * @brief Render the message box.
     *
     * @param {String} title
     *        Box title.
     *
     * @param {String} msg
     *        Message body.
     *
     * @param {Object} c
     *        Character map.
     *
     * @param {Object} options
     *        Runtime options.
     */
    function renderBox(title, msg, c, options) {
        var innerWidth = options.width;
        var header = makeHeader(title, c);

        if (header.length > innerWidth) {
            innerWidth = header.length;
        }

        var lines = splitMessageLines(msg);
        var renderedLines = [];

        for (var i = 0; i < lines.length; i++) {
            if (options.wrap) {
                appendArray(renderedLines, wrapText(lines[i], innerWidth));
            } else {
                renderedLines.push(lines[i]);

                if (lines[i].length + 1 > innerWidth) {
                    innerWidth = lines[i].length + 1;
                }
            }
        }

        if (renderedLines.length === 0) {
            renderedLines.push("");
        }

        write(c.tl + padRight(header, innerWidth, c.h) + c.tr);

        for (var j = 0; j < renderedLines.length; j++) {
            write(c.v + padRight(" " + renderedLines[j], innerWidth, " ") + c.v);
        }

        write(c.bl + repeat(c.h, innerWidth) + c.br);
    }

    /**
     * @brief Create the top header line content.
     *
     * @param {String} title
     *        Box title.
     *
     * @param {Object} c
     *        Character map.
     *
     * @return {String}
     *         Header content without corner characters.
     *
     * @details
     * If title is empty, the top border is a plain horizontal line.
     * If title is present, the format is:
     *
     * @code
     * hh<title-left> title <title-right>
     * @endcode
     */
    function makeHeader(title, c) {
        title = String(title || "");

        if (title === "") {
            return "";
        }

        return c.h + c.h + c.titleL + " " + title + " " + c.titleR;
    }

    /**
     * @brief Split message text into logical lines.
     *
     * @param {String} msg
     *        Message text.
     *
     * @return {String[]}
     *         Message lines.
     */
    function splitMessageLines(msg) {
        msg = String(msg || "").replace(/\r\n/g, "\n").replace(/\r/g, "\n");
        return msg.split(/\n/);
    }

    /**
     * @brief Decode literal escape sequences used from CMD.
     *
     * @param {String} s
     *        Input string.
     *
     * @return {String}
     *         Decoded string.
     *
     * @details
     * Supported escapes:
     *
     * - `\r\n`
     * - `\n`
     * - `\r`
     * - `\t`
     */
    function decodeEscapes(s) {
        return String(s || "")
            .replace(/\\r\\n/g, "\n")
            .replace(/\\n/g, "\n")
            .replace(/\\r/g, "\n")
            .replace(/\\t/g, "\t");
    }

    /**
     * @brief Wrap one line of text to a fixed width.
     *
     * @param {String} text
     *        Input text.
     *
     * @param {Number} width
     *        Maximum output line width.
     *
     * @return {String[]}
     *         Wrapped lines.
     *
     * @details
     * Wrapping prefers whitespace boundaries but splits long words when needed.
     */
    function wrapText(text, width) {
        text = String(text || "");

        if (width < 1) {
            return [text];
        }

        if (text === "") {
            return [""];
        }

        var result = [];
        var words = text.split(/\s+/);
        var line = "";

        for (var i = 0; i < words.length; i++) {
            var word = words[i];

            while (word.length > width) {
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

            if ((line + " " + word).length <= width) {
                line += " " + word;
            } else {
                result.push(line);
                line = word;
            }
        }

        if (line !== "") {
            result.push(line);
        }

        if (result.length === 0) {
            result.push("");
        }

        return result;
    }

    /**
     * @brief Append one array to another.
     *
     * @param {Array} target
     *        Target array.
     *
     * @param {Array} source
     *        Source array.
     */
    function appendArray(target, source) {
        for (var i = 0; i < source.length; i++) {
            target.push(source[i]);
        }
    }

    /**
     * @brief Expand tab characters to spaces.
     *
     * @param {String} s
     *        Input string.
     *
     * @param {Number} tabWidth
     *        Tab stop width.
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
     * @brief Expand tabs independently for each message line.
     *
     * @param {String} s
     *        Input string.
     *
     * @param {Number} tabWidth
     *        Tab stop width.
     *
     * @return {String}
     *         String with tabs expanded per line.
     */
    function expandTabsPerLine(s, tabWidth) {
        s = String(s || "").replace(/\r\n/g, "\n").replace(/\r/g, "\n");

        var lines = s.split(/\n/);

        for (var i = 0; i < lines.length; i++) {
            lines[i] = expandTabs(lines[i], tabWidth);
        }

        return lines.join("\n");
    }

    /**
     * @brief Pad a string to the right.
     *
     * @param {String} s
     *        Input string.
     *
     * @param {Number} len
     *        Target length.
     *
     * @param {String} ch
     *        Padding character.
     *
     * @return {String}
     *         Padded string.
     */
    function padRight(s, len, ch) {
        s = String(s || "");

        while (s.length < len) {
            s += ch;
        }

        return s;
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
     * @brief Return the character map for a named style.
     *
     * @param {String} style
     *        Style name.
     *
     * @param {Object} env
     *        Environment object for custom style lookup.
     *
     * @return {Object}
     *         Character map.
     *
     * @details
     * Supported styles:
     *
     * - `heavy`
     * - `single`
     * - `double`
     * - `round`
     * - `ascii`
     * - `custom`
     *
     * For `custom`, these environment variables are used:
     *
     * - `BOX_TL`, `BOX_TR`, `BOX_BL`, `BOX_BR`
     * - `BOX_H`, `BOX_V`
     * - `BOX_TITLE_L`, `BOX_TITLE_R`
     */
    function getStyle(style, env) {
        var styles = {
            heavy: {
                tl: "\u250f", tr: "\u2513", bl: "\u2517", br: "\u251b",
                h:  "\u2501", v:  "\u2503",
                titleL: "\u252b", titleR: "\u2523"
            },

            single: {
                tl: "\u250c", tr: "\u2510", bl: "\u2514", br: "\u2518",
                h:  "\u2500", v:  "\u2502",
                titleL: "\u2524", titleR: "\u251c"
            },

            double: {
                tl: "\u2554", tr: "\u2557", bl: "\u255a", br: "\u255d",
                h:  "\u2550", v:  "\u2551",
                titleL: "\u2563", titleR: "\u2560"
            },

            round: {
                tl: "\u256d", tr: "\u256e", bl: "\u2570", br: "\u256f",
                h:  "\u2500", v:  "\u2502",
                titleL: "\u2524", titleR: "\u251c"
            },

            ascii: {
                tl: "+", tr: "+", bl: "+", br: "+",
                h:  "-", v:  "|",
                titleL: "]", titleR: "["
            }
        };

        style = String(style || "heavy").toLowerCase();

        if (style === "custom") {
            return {
                tl: env("BOX_TL") || "+",
                tr: env("BOX_TR") || "+",
                bl: env("BOX_BL") || "+",
                br: env("BOX_BR") || "+",
                h: env("BOX_H") || "-",
                v: env("BOX_V") || "|",
                titleL: env("BOX_TITLE_L") || "]",
                titleR: env("BOX_TITLE_R") || "["
            };
        }

        return styles[style];
    }

    /**
     * @brief Test whether a style name is supported.
     *
     * @param {String} style
     *        Style name.
     *
     * @return {Boolean}
     *         True if supported.
     */
    function isKnownStyle(style) {
        style = String(style || "").toLowerCase();
        return /^(heavy|single|double|round|ascii|custom)$/.test(style);
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
        write("box.cmd - Print a titled message box using box-drawing characters");
        write("");
        write("USAGE:");
        write("  box.cmd [options] [title] [message] [style] [width]");
        write("");
        write("POSITIONAL ARGUMENTS:");
        write("  title                          Box title");
        write("  message                        Message text. Use literal \\n for line breaks");
        write("  style                          heavy, single, double, round, ascii, custom");
        write("  width                          Inner box width, default 67");
        write("");
        write("OPTIONS:");
        write("  --help, -help, /?              Show this help text");
        write("  --version                      Show version");
        write("  --title=TEXT                   Set title");
        write("  --message=TEXT, --msg=TEXT     Set message");
        write("  --style=NAME                   Set style");
        write("  --width=N, -w N                Set inner box width");
        write("  --tab-width=N                  Set tab width, default 4");
        write("  --wrap                         Enable wrapping, default");
        write("  --no-wrap                      Disable wrapping and expand box if needed");
        write("");
        write("ENVIRONMENT:");
        write("  TITLE                          Default title");
        write("  MSG                            Default message");
        write("  BOX_STYLE                      Default style");
        write("  BOX_WIDTH                      Default inner width");
        write("  BOX_TAB_WIDTH, TAB_WIDTH       Default tab width");
        write("  BOX_WRAP                       1/0, yes/no, true/false, on/off");
        write("");
        write("CUSTOM STYLE ENVIRONMENT:");
        write("  BOX_TL BOX_TR BOX_BL BOX_BR    Corners");
        write("  BOX_H BOX_V                    Horizontal and vertical characters");
        write("  BOX_TITLE_L BOX_TITLE_R        Title separator characters");
        write("");
        write("EXAMPLES:");
        write("  box.cmd \"My title\" \"Message content1\\nMessage content2\"");
        write("  box.cmd \"My title\" \"Message\" single 60");
        write("  box.cmd --style=double --width=60 \"My title\" \"Message\"");
        write("");
    }
})();
