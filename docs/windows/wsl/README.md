
## Windows WSL

### Install

Install using Command Prompt
1. Start CMD with administrative privileges.
2. Execute `wsl --install` command.
3. Run `wsl -l -o` to list other Linux releases.
4. You can install your favorite Linux distribution, use `wsl --install -d NameofLinuxDistro`.

>When the operation is finished, restart your PC.You can start the Linux distribution from your Start menu.
 

### Install Using Windows Features

1. Open the Start menu and type `Windows features` into the search bar and click on `Turn Windows Features On or Off`.
2. Tick the `Windows Subsystem for Linux` checkbox and press the `OK` button.
3. When the operation is complete, you will be asked to restart your computer.

> After that, use the Microsoft Store app and look for the Linux distribution you want to use.

### Update

```shell 
sudo nano /etc/wsl.conf
```

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
