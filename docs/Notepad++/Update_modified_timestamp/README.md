## Update a date stamp in the current file on save

<!-- https://chatgpt.com/c/6a56012d-b448-83eb-a53b-a9631cec6ff9 -->
> [!CAUTION]
> Add separator `T` between date and time to match ISO-8601 [^1].
> ```py
>     #timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
>     timestamp = datetime.now().strftime("%Y-%m-%dT%H:%M:%S")
> ```

[^1]: `T` is the time designator that precedes the time components of the duration representation

> [!TIP]
> Use updated [`UpdateTimestamp.py`](UpdateTimestamp.py) that supports JSON style too.
>
> This version is expanded to update `@modified`, `@release`, and `@revision`.


The most reliable approach is the **PythonScript** plugin, using Notepad++’s `FILEBEFORESAVE` event. This updates the text immediately before Notepad++ writes the file. PythonScript supports persistent callbacks for document save events. ([Super User][1])

### 1. Add a timestamp marker

Place this anywhere in the file:

```text
//* @modified 2000-01-01 00:00:00
```

The text preceding `@modified` can be any comment syntax, for example:

```php
//* @modified 2000-01-01 00:00:00
```

```javascript
// @modified 2000-01-01 00:00:00
```

```html
<!-- @modified 2000-01-01 00:00:00 -->
```

### 2. Install PythonScript

Open:

```text
Plugins → Plugins Admin
```

Install **PythonScript** and restart Notepad++.

Then select:

```text
Plugins → Python Script → New Script
```

Save it as:

```text
UpdateTimestamp.py
```

Insert:

```python
from datetime import datetime
from Npp import editor, notepad, NOTIFICATION


def update_timestamp_on_save(args):
    """
    Update the first line containing:

        @modified <timestamp>
    """

    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    editor.rereplace(
        r"^([^\r\n]*?@modified[ \t]+).*$",
        lambda match: match.group(1) + timestamp,
        0,
        0,
        editor.getTextLength(),
        1
    )


notepad.callback(
    update_timestamp_on_save,
    [NOTIFICATION.FILEBEFORESAVE]
)
```

`editor.rereplace()` performs a regular-expression replacement directly in the active document; the final argument limits it to the first matching line. ([GitHub][2])

### 3. Load it automatically

Open the PythonScript configuration:

```text
Plugins → Python Script → Configuration
```

Set **Initialisation** to:

```text
ALLSTARTUP
```

Then add this line to PythonScript’s `startup.py`:

```python
import UpdateTimestamp
```

Restart Notepad++. Every normal save of the current file, including `Ctrl+S`, will now update the timestamp before writing the file. This startup-registration pattern is also the documented solution used for save callbacks. ([Super User][1])

To restrict it to PHP files, add this at the beginning of `update_timestamp_on_save()`:

```python
    if not notepad.getCurrentFilename().lower().endswith(".php"):
        return
```



<!--

### Macros
To be inserted into: `"%APPDATA%\Notepad++\shortcuts.xml"`

- Update version date stamp in DOXYGEN header [Ctrl]+[Alt]+[Shift]+[v]

Like updating the first occurence of:
```script
/**
---8< ---- >8 ---
 * @version    2025-08-01T11:13:24
 */
```

```
       <Macro name="Update version" Ctrl="yes" Alt="yes" Shift="yes" Key="86">
            <Action type="0" message="2316" wParam="0" lParam="0" sParam="" />          <!-- SCI_DOCUMENTSTART -- >
            <Action type="3" message="1700" wParam="0" lParam="0" sParam="" />          <!-- IDC_FRCOMMAND_INIT -- >
            <Action type="3" message="1601" wParam="0" lParam="0" sParam="^\s+\*\s+\@version\s+" />     <!-- IDFINDWHAT -- >
            <Action type="3" message="1625" wParam="0" lParam="2" sParam="" />          <!-- IDNORMAL -- >
            <Action type="3" message="1702" wParam="0" lParam="512" sParam="" />        <!-- IDC_FRCOMMAND_BOOLEANS -- >
            <Action type="3" message="1701" wParam="0" lParam="1" sParam="" />          <!-- IDC_FRCOMMAND_EXEC -- >
            <Action type="0" message="2306" wParam="0" lParam="0" sParam="" />          <!-- SCI_CHARRIGHT -- >
            <Action type="0" message="2452" wParam="0" lParam="0" sParam="" />          <!-- SCI_LINEENDWRAPEXTEND -- >
            <Action type="2" message="0" wParam="42086" lParam="0" sParam="" />
        </Macro>
```


Messages can be found in: 
Prefix | File
---|---
SCI_	| `scintilla\include\Scintilla.h`
ID, IDC	| `PowerEditor\src\ScintillaComponent\FindReplaceDlg_rc.h`

-->


