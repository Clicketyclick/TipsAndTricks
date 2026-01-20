## Attatch to taskbar

### Shortcut

Make a directory for you shortcuts and icon like `%HOMEPATH%\links`

Create your shortcut in this directory and add a new icon.

1. Right click on the shortcut
2. Select "Show more options"
3. Select "Pin to taskbar"

The link will be stored in `%USERPROFILE%\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar`

If there is no "Pin to.." entries you will have to prefix the target with
`C:\Windows\System32\cmd.exe` in order to "persuade" Window to accept the link on startup and taskbar.  

Start in: `%HOMEDRIVE%%HOMEPATH%`
