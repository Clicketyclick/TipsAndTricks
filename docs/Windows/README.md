@@Windows_logo@@

## M$ Windows

- [Windows System Icons](WindowsSystemFiles/)
- [Windows WSL](wsl/)
- [Attach shortcut](attach_to_taskbar/) to taskbar
- [Winget](Winget/) - WinGet is the Windows Package Manager used to upgrade apps
- [Auto sync](Sync_folder_to_onedrive/) folders using OneDrive
- Remove [drop shadow](DropShadow/) under windows
- [Windows Spotlight Images](SpotlightFiles/)

## Uninstall bloat ware

[Win11Debloat](https://github.com/Raphire/Win11Debloat) - Win11Debloat is a simple, easy to use and lightweight PowerShell script that allows you to quickly declutter and improve your Windows experience. It can remove pre-installed bloatware apps, disable telemetry, remove intrusive interface elements and much more. No need to painstakingly go through all the settings yourself or remove apps one by one. Win11Debloat makes the process quick and easy!
- [Uninstall Windows 10 Builtin Apps](UninstallWindows10BuiltinApps.ps1)

## Install telnet Using Command Prompt

Open the Start menu, type CMD, and right-click on Command Prompt. Select Run as administrator.

Enter the following command and press Enter:
```
dism /online /Enable-Feature /FeatureName:TelnetClient
```
Wait for the process to complete. Once done, Telnet will be installed.
