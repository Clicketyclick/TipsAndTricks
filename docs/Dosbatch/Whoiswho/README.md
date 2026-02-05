

Determine what script and which function you're in:

```bat
@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION

    ECHO :: Caller [cmd]                    [%CMDCMDLINE%] 
    ECHO :: Script mame                     [%~n0] 
    ECHO :: Script name + extention         [%0]
    ECHO :: Script full name                [%~FNX0]
    ECHO:

    CALL :DEBUG unique11 "%~0" "-- Calling :init"
    CALL :init
    ECHO:

    CALL :getParentDir
    ECHO:
    ECHO _parentDir=[%_parentDir%]
    ECHO:
    CALL :getLineNumber unique_ID1 & ECHO - Call from: %~n0(%0)[!__LINE__!] i.e. script(function)[lineNo] [Line 18]
GOTO :EOF


:init
::
    ECHO :: Script name:                    Got[%~n0] Exp[whoiswho.cmd] 
    ECHO :: Function name:                  Got[%0]    Exp[:init]      
    ECHO:
    CALL :getLineNumber unique_init1 0  :: ˂━-- Get line no
    ECHO - Call from: %~n0(%0)[!__LINE__!] i.e. script(function)[lineNo]
    ECHO:
    CALL :test
GOTO :EOF


:DEBUG
::
SETLOCAL
    CALL :getLineNumber "%~1"
    SET _CALLER=%~2
    SET _MSG=%~3 %~4 %5
    >&2 ECHO DEBUG %_CALLER%[%__LINE__%](%0) %_msg:__LINE__=!__LINE__!%
GOTO :EOF


:getParentDir
:: Get parent to current working directory
SETLOCAL ENABLEDELAYEDEXPANSION
    SET _return=%~1
    IF NOT DEFINED _return SET _return=_ParentDir
    :: https://stackoverflow.com/a/16623984
    FOR %%i IN ("%~dp0..") DO SET "_parentDIR=%%~fi"
    IF DEFINED DEBUG ECHO _parentDIR=%_parentDIR%
    
    CALL :DEBUG 2026-02-03T11:19:47 "%~0" "   Got[__LINE__]  Exp[53]"
ENDLOCAL&SET %_return%=%_parentDIR%
GOTO :EOF


:test
::
    CALL :DEBUG 2026-02-03T11:34:18 "%~0" "           Got[__LINE__]  Exp[60]"
GOTO :EOF


:::::::::::::::::::::::::::::::::::::::::::::
:GetLineNumber <uniqueID> [LineOffset]
:: Detects the line number of the caller, the uniqueID have to be unique in the batch file
:: The lineno is return in the variable <resultVar> add with the [LineOffset]
:: [How to get the current line number?](https://stackoverflow.com/a/4683824)
SETLOCAL ENABLEDELAYEDEXPANSION
    ::CALL :DEBUG [uniqueID]=%~1 [LineOffset]=%~2

    FOR /F " USEBACKQ TOKENS=1 DELIMS=:" %%L IN (`FINDSTR /N  /C:" %~1 " "%~f0"`) DO SET /A lineNr=%~2 + %%L
    ( 
        ::echo FOUND: %LineNr%
        ENDLOCAL&SET "__LINE__=%LineNr%"
        GOTO :EOF
    )
GOTO :EOF
```
Will produce something like:
```console
:: Caller [cmd]                    ["C:\Windows\System32\cmd.exe" ]
:: Script mame                     [whoiswho]
:: Script name + extention         [whoiswho.cmd]
:: Script full name                [c:\...\06.02\utils\whoiswho.cmd]

DEBUG whoiswho.cmd[10](:DEBUG) -- Calling :init
:: Script name:                    Got[whoiswho] Exp[whoiswho.cmd]
:: Function name:                  Got[:init]    Exp[:init]

- Call from: whoiswho(:init)[27] i.e. script(function)[lineNo]

DEBUG :test[60](:DEBUG)            Got[60]  Exp[60]

DEBUG :getParentDir[53](:DEBUG)    Got[53]  Exp[53]

_parentDir=[c:\\06.02]

- Call from: whoiswho(whoiswho.cmd)[18] i.e. script(function)[lineNo] [Line 18]
```
