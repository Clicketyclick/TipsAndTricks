<!--
## Powershell ![logo](logo.png)
-->

@@Powershell_logo@@

## Powershell 

- [Change screen orientation](/ChangeScreenOrientation) Powershell shortcut to changing screen orientation.
- [Winget](../windows/Winget) WinGet is the Windows Package Manager used to upgrade apps.
- [Tail](tail.bat) Print the last 30 lines of each FILE to standard output.


### From command line
```cmd
powershell -command "Test-NetConnection 10.20.30.40 -port 10001"
```

Or
<!--
# Source - https://superuser.com/a/1815230
# Posted by sionta, modified by community. See post 'Timeline' for change history
# Retrieved 2026-03-10, License - CC BY-SA 4.0
-->
```cmd
powershell -command "& {git clone $(Get-Clipboard)} %*"

```
Source: [ ![Superuser](..//icons/Superuser.icon.png "Superuser.com")&#91;&middot;} Superuser](https://superuser.com/a/1815230 "Run Powershell command from cmd with parameters")
