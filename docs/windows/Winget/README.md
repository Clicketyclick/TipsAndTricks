## Winget - The Windows Package Manager <img src="../../winget.jpg" title="Logo to Winget" width=48px height=auto>

The [Windows Package Manager](https://en.wikipedia.org/wiki/Windows_Package_Manager) 
<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/archive/6/63/20050601172023%21Wikipedia-logo.png/120px-Wikipedia-logo.png" title="Link to Wikipedia" width="48px" height=auto>
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

### Unknown packages
Packages that do not have a version number available

```ps
winget list | Select-String -Pattern 'unknown'  -SimpleMatch
' or case sensitive
winget list | Select-String -Pattern 'Unknown' -CaseSensitive -SimpleMatch
```
## References

- [Winget: The best way to keep Windows apps updated](https://www.computerworld.com/article/3684171/winget-the-best-way-to-keep-windows-apps-updated.html) / Ed Tittel,
Computerworld | JAN 19, 2023 3:00 AM PST
- [How to automatically keep your Windows applications updated](https://www.zdnet.com/home-and-office/work-life/how-to-automatically-keep-your-windows-applications-updated/) / Lance Whitney, Contributor, ZDNET Oct. 26, 2022 at 8:49 a.m. PT
