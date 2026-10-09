### Preserve data on FTP upload

https://www.ghisler.ch/board/viewtopic.php?t=48954

In `"%USERPROFILE%\AppData\Roaming\GHISLER\wcx_ftp.ini"` set

```ini
[default]
PreserveDates=1
;Preserve file date/time on downloads
```

AND under the specific FTP configuration in `"%USERPROFILE%\AppData\Roaming\GHISLER\wcx_ftp.ini"`

```ini
PreserveDates=1
SpecialFlags=4096
```
