from datetime import datetime
import re
from Npp import editor, notepad, NOTIFICATION


def update_timestamp_on_save(args):
    """
    Update an @modified 2026-07-14T16.56.41

    JSON example:

        "@modified": ""

    becomes:

        "@modified": "2026-07-14T16.32.45"

    Non-JSON example:

        //* @modified 2000-01-01T00.00.00
    """

    timestamp = datetime.now().strftime("%Y-%m-%dT%H:%M:%S")
    filename = notepad.getCurrentFilename().lower()

    if filename.endswith(".json"):
        #*
        #* Preserve indentation and whitespace around the colon.
        #* Replace only the first @modified JSON property.
        #*
        pattern = (
            r'(^[ \t]*"@modified"[ \t]*:[ \t]*")'
            r'[^"\r\n]*'
            r'(")'
        )

        editor.rereplace(
            pattern,
            lambda match: (
                match.group(1)
                + timestamp
                + match.group(2)
            ),
            re.MULTILINE,
            0,
            editor.getTextLength(),
            1
        )

        return

    #*
    #* Handle @modified markers in other file types.
    #*
    pattern = r"^([^\r\n]*?@modified[ \t]+).*$"

    editor.rereplace(
        pattern,
        lambda match: match.group(1) + timestamp,
        re.MULTILINE,
        0,
        editor.getTextLength(),
        1
    )


notepad.callback(
    update_timestamp_on_save,
    [NOTIFICATION.FILEBEFORESAVE]
)

