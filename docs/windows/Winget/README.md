## Winget - The Windows Package Manager

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
