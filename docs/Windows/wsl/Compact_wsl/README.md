## Windows WSL

### Compact 

Source: https://superuser.com/a/1940195

As of WSL v2.9.8, there is now a built-in command to compact WSL's VHDX:


```bat
:: Shutdown wsl
wsl --shutdown
:: UPdate packages
wsl --update
:: List volume
wsl -l -v
wsl --manage Ubuntu --compact
:: Start WSL
wsl 
:: List volume
wsl -l -v
```
