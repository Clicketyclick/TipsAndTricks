
#::**
#:: * @file       UpdateTimestamp.py
#:: * @brief      Make Notepad++ update a date stamp in the current file on save
#:: * @details    Define the supported tags in one list and update every existing occurrence of `@date`
#:: * 
#:: *  Legacy date tags (`@modified`, `@release`, and `@revision`) are removed and replaced by `@date`.
#:: * 
#:: * 
#:: * Functions|Brief
#:: * ---|---
#:: * update_timestamp_on_save(args)    | Pattern match and replace.
#:: * 
#:: * @copyright  http://www.gnu.org/licenses/lgpl.txt LGPL version 3
#:: * @author     Erik Bachmann <Erik@ClicketyClick.dk>
#:: * @since      2026-07-14T16:50:00 / erba
#:: * @version    2026-07-16T13:36:07
#:: * @date       2026-07-20T13.50.23
#:: **

from datetime import datetime
import re

from Npp import editor, notepad, NOTIFICATION


DATE_TAG = "@date"

LEGACY_DATE_TAGS = (
    "@modified",
    "@release",
    "@revision",
)

ALL_DATE_TAGS = (DATE_TAG,) + LEGACY_DATE_TAGS

TAG_PATTERN = "|".join(
    re.escape(tag)
    for tag in ALL_DATE_TAGS
)


JSON_DATE_RE = re.compile(
    r'^(?P<indent>[ \t]*)'
    r'"(?P<tag>' + TAG_PATTERN + r')"'
    r'(?P<separator>[ \t]*:[ \t]*)'
    r'"[^"\r\n]*"'
    r'(?P<after>[ \t]*)'
    r'(?P<comma>,?)'
    r'(?P<trail>[ \t]*)'
    r'(?P<newline>\r\n|\r|\n|$)'
)


JSON_DATE_LINE_RE = re.compile(
    r'^(?P<body>'
        r'[ \t]*'
        r'"@date"'
        r'[ \t]*:[ \t]*'
        r'"[^"\r\n]*"'
        r'[ \t]*'
    r')'
    r',?'
    r'(?P<trail>[ \t]*)'
    r'(?P<newline>\r\n|\r|\n|$)'
)


TEXT_DATE_RE = re.compile(
    r'^(?P<prefix>[^\r\n]*?)'
    r'(?P<tag>' + TAG_PATTERN + r')'
    r'(?P<space>[ \t]+)'
    r'(?P<value>[^\r\n]*?)'
    r'(?P<newline>\r\n|\r|\n|$)'
)


def merge_json_date_fields(text, timestamp):
    """

    The following properties are recognized:

        "@date": ""
        "@modified": ""
        "@release": ""
        "@revision": ""

    legacy property is converted to @date. Additional properties are removed.
    """

    lines = text.splitlines(True)
    matches = []

    for index, line in enumerate(lines):
        match = JSON_DATE_RE.match(line)

        if match:
            matches.append((index, match))

    if not matches:
        return text

    keep = next(
        (
            item
            for item in matches
            if item[1].group("tag") == DATE_TAG
        ),
        matches[0]
    )

    keep_original_index = keep[0]

    new_lines = []
    keep_new_index = None

    for index, line in enumerate(lines):
        match = JSON_DATE_RE.match(line)

        if not match:
            new_lines.append(line)
            continue

        # Remove duplicate and legacy date properties.
        if index != keep_original_index:
            continue

        keep_new_index = len(new_lines)

        new_lines.append(
            match.group("indent")
            + '"@date"'
            + match.group("separator")
            + '"'
            + timestamp
            + '"'
            + match.group("after")
            + match.group("comma")
            + match.group("trail")
            + match.group("newline")
        )

    # Determine whether the retained property needs a trailing comma.
    next_significant_line = None

    for line in new_lines[keep_new_index + 1:]:
        stripped = line.strip()

        if stripped:
            next_significant_line = stripped
            break

    if (
        next_significant_line is None
        or next_significant_line.startswith("}")
        or next_significant_line.startswith("]")
    ):
        comma = ""
    else:
        comma = ","

    match = JSON_DATE_LINE_RE.match(new_lines[keep_new_index])

    if match:
        new_lines[keep_new_index] = (
            match.group("body")
            + comma
            + match.group("trail")
            + match.group("newline")
        )

    return "".join(new_lines)


def merge_text_date_fields(text, timestamp):
    """

    Examples recognized:


    """

    lines = text.splitlines(True)
    matches = []

    for index, line in enumerate(lines):
        match = TEXT_DATE_RE.match(line)

        if match:
            matches.append((index, match))

    if not matches:
        return text

    keep = next(
        (
            item
            for item in matches
            if item[1].group("tag") == DATE_TAG
        ),
        matches[0]
    )

    keep_index = keep[0]
    new_lines = []

    for index, line in enumerate(lines):
        match = TEXT_DATE_RE.match(line)

        if not match:
            new_lines.append(line)
            continue

        # Remove additional date commands.
        if index != keep_index:
            continue

        value = match.group("value")

        # Preserve a closing block-comment marker when present.
        suffix_match = re.search(
            r'([ \t]*(?:\*/|-->)[ \t]*)$',
            value
        )

        suffix = (
            suffix_match.group(1)
            if suffix_match
            else ""
        )

        new_lines.append(
            match.group("prefix")
            + DATE_TAG
            + match.group("space")
            + timestamp
            + suffix
            + match.group("newline")
        )

    return "".join(new_lines)


def update_date_on_save(args):
    """
    """

    # This retains your selected dotted time representation.
    timestamp = datetime.now().strftime(
        "%Y-%m-%dT%H.%M.%S"
    )

    filename = notepad.getCurrentFilename().lower()
    original_text = editor.getText()

    if filename.endswith(".json"):
        updated_text = merge_json_date_fields(
            original_text,
            timestamp
        )
    else:
        updated_text = merge_text_date_fields(
            original_text,
            timestamp
        )

    if updated_text == original_text:
        return

    selection_start = editor.getSelectionStart()
    selection_end = editor.getSelectionEnd()

    editor.beginUndoAction()

    try:
        editor.setText(updated_text)

        document_length = editor.getTextLength()

        editor.setSel(
            min(selection_start, document_length),
            min(selection_end, document_length)
        )
    finally:
        editor.endUndoAction()


notepad.callback(
    update_date_on_save,
    [NOTIFICATION.FILEBEFORESAVE]
)