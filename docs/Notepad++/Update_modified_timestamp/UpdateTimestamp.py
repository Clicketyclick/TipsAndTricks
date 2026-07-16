
#::**
#:: * @file       UpdateTimestamp.py
#:: * @brief      Make Notepad++ update a date stamp in the current file on save
#:: * @details    Define the supported tags in one list and update every existing occurrence of @modified, @release, and @revision
#:: * 
#:: * On running the field after the tag gets updated
#:: * 
#:: * 
#:: * Functions|Brief
#:: * ---|---
#:: * update_timestamp_on_save(args)    | Pattern match and replace.
#:: * 
#:: * @copyright  http://www.gnu.org/licenses/lgpl.txt LGPL version 3
#:: * @author     Erik Bachmann <Erik@ClicketyClick.dk>
#:: * @since      2026-07-16T08:47:48 / erba
#:: * @version    2026-07-16T08:47:48
#:: * @revision   2026-07-16T08.59.15
#:: * @modified   2026-07-16T08.59.15
#:: **

from datetime import datetime
import re
from Npp import editor, notepad, NOTIFICATION

TIMESTAMP_TAGS = (
    "@modified",
    "@release",
    "@revision",
)


def update_timestamp_on_save(args):
    """
    Update supported timestamp tags before saving.

    Supported JSON properties:

        "@modified": ""
        "@release": ""
        "@revision": ""

    Supported text markers:

        //* @modified 2026-07-16T08.59.15
        //* @release  2026-07-16T08.59.15
        //* @revision 2026-07-16T08.59.15
    """

    timestamp = datetime.now().strftime("%Y-%m-%dT%H.%M.%S")
    filename = notepad.getCurrentFilename().lower()

    escaped_tags = [re.escape(tag) for tag in TIMESTAMP_TAGS]
    tag_pattern = "|".join(escaped_tags)

    if filename.endswith(".json"):
        #*
        #* Preserve indentation, property name and whitespace.
        #* Update every matching JSON property.
        #*
        pattern = (
            r'(^[ \t]*"('
            + tag_pattern
            + r')"[ \t]*:[ \t]*")'
            r'[^"\r\n]*'
            r'(")'
        )

        editor.rereplace(
            pattern,
            lambda match: (
                match.group(1)
                + timestamp
                + match.group(3)
            ),
            re.MULTILINE,
            0,
            editor.getTextLength()
        )

        return

    #*
    #* Update matching tags in non-JSON files.
    #* Preserve everything before the timestamp value.
    #*
    pattern = (
        r"^([^\r\n]*?(?:"
        + tag_pattern
        + r")[ \t]+).*$"
    )

    editor.rereplace(
        pattern,
        lambda match: match.group(1) + timestamp,
        re.MULTILINE,
        0,
        editor.getTextLength()
    )


notepad.callback(
    update_timestamp_on_save,
    [NOTIFICATION.FILEBEFORESAVE]
)
