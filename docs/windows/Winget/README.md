

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
winget list | Select-String -Pattern 'Unknown' -CaseSensitive -SimpleMatch
```
