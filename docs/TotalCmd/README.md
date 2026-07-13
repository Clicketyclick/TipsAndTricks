<img src="../icons/Totalcmd.logo.png" width=128 style="float: right;">

## Totalcmd

<details><summary>Files to backup</summary>

- `AppData/Roaming/Giesler/wcx_ftp.ini`
- `*.key`
</details>

<details><summary>Hotkey configuration</summary>

`Configuration` / `Options` / `Misc`

<kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>C</kbd> = cm_FileSync

</details>

<details><summary>Preserve data on FTP upload</summary>

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

</details>

### INI tricks

<details><summary>F2 Queue</summary>

```ini
[Configuration]
AlwaysCopyInBackground=2
```
</details>
- [Default rename mask in Multi-rename tool](Default rename mask in Multi-rename tool/)


### SSH / SFTP

- [Total Commander SFTP Setup to One.com](Ssh-ftp@one.com/)
