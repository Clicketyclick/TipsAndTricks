
## Windows WSL

### Access user home

``` Shell
dir \\wsl$\Ubuntu\home\%USERNAME%
```

## Mapping WSL drive in Windows

https://superuser.com/a/1502631 

With the current Windows 10 Insider (Fast ring: Windows 10 build 19025.1) you can mount your distro as a network drive.

WSL is accessible as wsl$, the path is your distribution name (wsl -l -q).

For example 
``` Batchfile
net use U: \\wsl$\Ubuntu /PERSISTENT:YES
```
