@@Totalcmd_logo@@

## Totalcmd

### Backup

- AppData/Roaming/Giesler/wcx_ftp.ini
- *.key


### Hotkeys

Configuration / Options / Misc

<kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>C</kbd> = cm_FileSync


### Rename

Mask: ISO8601
- Filename: `[N].[Y]-[M]-[D]T[hms]`
  - or `[N].[d]T[t]`
- Extension: `[E]`

### Preserve data on FTP upload 

https://www.ghisler.ch/board/viewtopic.php?t=48954

```ini
[default]
PreserveDates=1
;Preserve file date/time on downloads
```

AND under the specific FTP configuration

```ini
PreserveDates=1
SpecialFlags=4096
```

