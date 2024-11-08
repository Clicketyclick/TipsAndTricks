## Get users full name from Windows

Full name is on line 2 pos 36 in output from `NET USER`:

```batch
@ECHO OFF
SETLOCAL

:init
    SET _TMPFILE=%random%
    SET _TMPFILE=usn
:main
    NET USER %username% > %_TMPFILE%
    CALL :token _VAR %_TMPFILE% 2
:output
    ECHO [%_VAR:~36%]
GOTO :EOF

:token
    set "_file=%~2"
    set "lineNr=%3"
    set /a lineNr-=1
    for /f "usebackq delims=" %%a in (`more +%lineNr% %_file%`) DO (
      ENDLOCAL&set "%~1=%%a"
      GOTO :EOF
    )
GOTO :EOF
```
