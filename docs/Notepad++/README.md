@@Notepadpp_logo@@

# Notepad++

<!--
<fieldset>
<legend>32Bit</legend>
DoxyIT works <strong>ONLY</strong> on NotePad++ 32 bit!
</fieldset>
-->

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



### Configuration


- Settings
	- Preferences
		- Dark Mode: Select darkmode
	- Preferences
		- Multi-Instance & Date
			- Customize Insert Data Time
				- Reverse default data time oder: Select
				- Custom format: `yyyy-MM-ddTHH:mm:ss`
	- Preferences
 		- style Configurator
   			-  <details><summary>Global Styles + White space symbol</summary>To change the color of the arrow sign/dot sign go to Settings -> style Configurator and in Language section select Global Styles & in Style section select White space symbol and change the Foreground Color as your wish. [Notepad++ background color for tabs (tabulations)?](https://superuser.com/questions/1193558/notepad-background-color-for-tabs-tabulations)</details>
        - Language
            - Tab Settings
                - Tab size: 4
                - Replace by space
    - Shortcut mapper
        - Filter on `Date` and add shortcut [Alt]+[F5] to "Date Time (Customized)

> [!NOTE]
> Tab Setting has moved to Settings / Preferences / Indentation

## Plugins
### NppMarkdownPanel

- Styles.css - [Border in tables and fieldsets](NppMarkdownPanel.html)

- ComparePlugin
- ComparePlus
- Converter [^1]
- DarkTheme
- ~~@@Doxyit_icon@@[DoxyIt](Doxyit)~~ [^2]
- HexEditor
- JSLintNpp
- JsonTools
- MarkdownViewerPlusPlus
- mimeTools [^1]
- NppConverter
- NppExport [^1]
- NPPJSONViewer
- NppMarkdownPanel
- NppSnippets
- PlantUmlViewer
- PoorMansTSqlFormatterNppPlugin
- Python Indent
- PythonScript
- Tidy2
- Translate

[^1]: Default
[^2]: DoxyIT plugin works ***ONLY*** on NotePad++ 32 bit! See [Notepad++ Community](https://community.notepad-plus-plus.org/topic/25465/doxyit-on-64bit-access-violation). Use the Python script instead: [DoxyIT](Doxyit/)
