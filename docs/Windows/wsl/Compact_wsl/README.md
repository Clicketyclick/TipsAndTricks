## Windows WSL

### Compact 

Source: https://superuser.com/a/1940195

As of WSL v2.9.8, there is now a built-in command to compact WSL's VHDX:


```bat
REM Shutdown wsl
wsl --shutdown
REM UPdate packages
wsl --update
REM List volume
wsl -l -v
wsl --manage Ubuntu --compact
REM Start WSL
wsl 
REM List volume
wsl -l -v
```
