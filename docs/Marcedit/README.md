[@@Marcedit_logo@@](https://marcedit.reeset.net/)
## [MarcEdit](https://marcedit.reeset.net/)

> MarcEdit has become one of the more complete metadata edit suites available to librarians.

Basically an advanced editor for packing/unpacking ISO 2709 files with bibliographic data.

## Potential problems

When installing the app the default path is: `"%USERPROFILE%\AppData\Roaming\MarcEdit 7.6 (User)"`

If your operating in an environment with "enhanded windows security" you might not be able to run an app from this "non standard" directory.

And further more - you may not be able to uninstall either!

### "Uninstall"

Simply delete the directory `"%USERPROFILE%\AppData\Roaming\MarcEdit 7.6 (User)"`

### Reinstall

Select a standard location like: 
```console
ProgramFiles=C:\Program Files
ProgramFiles(x86)=C:\Program Files (x86)
```
Like:
`"%ProgramFiles%\MarcEdit 7.6 (User)\MarcEdit.exe"`
