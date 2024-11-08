## Get users full name from Windows

Full name is on line 2 pos 36 in output from `NET USER`:

```batch
@ECHO OFF&SETLOCAL

:init
    SET _TMPFILE=%random%
    SET _TMPFILE=usn
:main
    NET USER %username% > %_TMPFILE%
    :: Echo line
    CALL :token  %_TMPFILE% 2
    echo :--
    :: Grap line
    CALL :token  %_TMPFILE% 2 _VAR
:output
    :: Echo from pos 36
    ECHO [%_VAR:~36%]
GOTO :EOF

:token
    set "_file=%~1"
    set "lineNr=%2"
    set /a lineNr-=1
    for /f "usebackq delims=" %%a in (`more +%lineNr% %_file%`) DO (
        IF "_"=="_%~3" ECHO %%a
        ENDLOCAL&set "%~3=%%a" 2>nul
        GOTO :EOF
    )
GOTO :EOF
```


```console
FuLL Name                           User Full Name
:--
[User Full Name]
```
