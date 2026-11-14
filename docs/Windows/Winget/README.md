## Winget - The Windows Package Manager <img src="../../winget.jpg" title="Logo to Winget" width=64px height=auto>

The [Windows Package Manager](https://en.wikipedia.org/wiki/Windows_Package_Manager) 
<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/archive/6/63/20050601172023%21Wikipedia-logo.png/120px-Wikipedia-logo.png" title="Link to Wikipedia" width="32px" height=auto>
consists of a command-line utility and a set of services for installing applications. 
Independent software vendors can use it as a distribution channel for their software packages.

Winget is a PowerShell function in Windows 10+.

### Installed packages

```ps
winget installed
```
### Upgrade
```ps
' List upgradable packages
winget upgrade
' Do the upgrade
winget upgrade --all
```
or from CMD:

```bat
powershell -Command "winget upgrade --all"
```
or even simpler

```bat
winget upgrade
winget upgrade --all
winget upgrade --all  --include-unknown
```

### Unknown packages
Packages that do not have a version number available

```ps
winget list | Select-String -Pattern 'unknown'  -SimpleMatch
' or case sensitive
winget list | Select-String -Pattern 'Unknown' -CaseSensitive -SimpleMatch
```

### Automation

Create a script: `%USERPROFILE%\winget_upgrade.cmd`:

```bat
@ECHO OFF
SetLocal EnableDelayedExpansion
::**
:: @file        winget_upgrade.cmd
:: @brief       Automate winget upgrade
:: @details     
:: 
:: Functions | Brief                
:----------- | ---------------------
:: :init     | Init and setup       
:: :admin    | Upgrade if elevated  
:: :user     | Error if not elevated
:: 
:: @copyright   http://www.gnu.org/licenses/lgpl.txt LGPL version 3
:: @author      Erik Bachmann <Erik@ClicketyClick.dk>
:: @since       2026-11-14T07:51:24 / erba
:: @version     2026-11-14T07.54.20
:: @date        2026-11-14T07.54.20
::**

:init
    ::https://stackoverflow.com/questions/7985755/how-to-detect-if-cmd-is-running-as-administrator-has-elevated-privileges#comment103360290_16285248
    net session >nul 2>&1 && (echo IS admin&goto :admin)|| (echo not admin&goto :user&goto :eof)
    :: Time to let it sink in ;-)
    timeout /t 10
GOTO :EOF


:admin
    ::#' List upgradable packages
    winget upgrade
    ::#' Do the upgrade
    winget upgrade --all
GOTO :eof

:user
    SET "TITLE=Not elevated!"
    SET "MSG=You're not admin!.\nThis is required to run this funtion"  MB_WARNING+MS_OD

    call box "%TITLE%" "%MSG%" 
    call msgbox "%MSG%" "%TITLE%" MB_WARNING+MS_OD
GOTO :EOF
```

Create a shortcut with:
- location: `%USERPROFILE%`
- Destination: `%USERPROFILE%\winget_upgrade.cmd`
- icon: `%SystemDrive%\bin\icons\Windows_Package_Manager_logo.ico`
- Advanced/Run as Admin: Checked


### References

- [Winget: The best way to keep Windows apps updated](https://www.computerworld.com/article/3684171/winget-the-best-way-to-keep-windows-apps-updated.html) / Ed Tittel,
Computerworld | JAN 19, 2023 3:00 AM PST
- [How to automatically keep your Windows applications updated](https://www.zdnet.com/home-and-office/work-life/how-to-automatically-keep-your-windows-applications-updated/) / Lance Whitney, Contributor, ZDNET Oct. 26, 2022 at 8:49 a.m. PT
