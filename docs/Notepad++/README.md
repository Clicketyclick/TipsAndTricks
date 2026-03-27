# Notepad++ <img src='../icons/Notepadpp.logo.png' width=256>

- [Configuration](Configuration/)

<!--
<fieldset>
<legend>32Bit</legend>
DoxyIT works <strong>ONLY</strong> on NotePad++ 32 bit!
</fieldset>
-->

### Decode Unicode escaped characters

Source: <img src='../icons/Stackoverflow.icon.png' width=16>[How to convert escaped Unicode e.g. \u0432\u0441\u0435 to UTF-8 chars...](https://stackoverflow.com/a/39126723)

1. Install the plugin named "HTML Tag". 
2. Select text
3. Invoke command Plugins > HTML Tag > Decode JS (Ctrl+Shift+J).

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
            <Action type="0" message="2316" wParam="0" lParam="0" sParam="" />          <!-- SCI_DOCUMENTSTART -->
            <Action type="3" message="1700" wParam="0" lParam="0" sParam="" />          <!-- IDC_FRCOMMAND_INIT -->
            <Action type="3" message="1601" wParam="0" lParam="0" sParam="^\s+\*\s+\@version\s+" />     <!-- IDFINDWHAT -->
            <Action type="3" message="1625" wParam="0" lParam="2" sParam="" />          <!-- IDNORMAL -->
            <Action type="3" message="1702" wParam="0" lParam="512" sParam="" />        <!-- IDC_FRCOMMAND_BOOLEANS -->
            <Action type="3" message="1701" wParam="0" lParam="1" sParam="" />          <!-- IDC_FRCOMMAND_EXEC -->
            <Action type="0" message="2306" wParam="0" lParam="0" sParam="" />          <!-- SCI_CHARRIGHT -->
            <Action type="0" message="2452" wParam="0" lParam="0" sParam="" />          <!-- SCI_LINEENDWRAPEXTEND -->
            <Action type="2" message="0" wParam="42086" lParam="0" sParam="" />
        </Macro>
```


Messages can be found in: 
Prefix | File
---|---
SCI_	| `scintilla\include\Scintilla.h`
ID, IDC	| `PowerEditor\src\ScintillaComponent\FindReplaceDlg_rc.h`



