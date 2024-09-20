@ECHO OFF
::** 
:: * @file      _debug_test.cmd
:: * @brief     Testing verbose, debug and log functions - w cleanup
:: * 
:: * @details   
:: * 
:: * @copyright http://www.gnu.org/licenses/lgpl.txt LGPL version 3
:: * @author    Erik Bachmann <ErikBachmann@ClicketyClick.dk>
:: * @since     2024-09-20T20:18:26 / erba
:: * @version   2024-09-20T20:18:26
:: **

:init
    if "%~1" equ ":main" (
        REM :: snip ":main"
        shift /1
        REM :: run main
        goto main
    )
    CALL _header %~f0           &:: Display DoxIT header from caller
    CMD /d /c "%~f0" :main %*   &:: Process main

    CALL :cleanup   &:: Calling cleanup on the way out
GOTO :EOF

::----------------------------------------------------------------------

:main
    ECHO Full name: [%~f0]  &:: Full name of current script
    ECHO Full path: [%~dp0] &:: Full drive + path to current script
    CALL %~dp0_debug        &:: Call _debug in same directory as current script

    ECHO:State:     v:[%verbose%]/d:[%debug%]/l:[%logging%] [%__VERBOSE__%][%__DEBUG__%]
    ECHO:
    CALL :try_me
GOTO:EOF

::----------------------------------------------------------------------

:try_me
    %__VERBOSE__% Verbose: something to verbose
    %__VERBOSE__% Verbose: more to to verbose
    %__DEBUG__% something to debug
    %__DEBUG__% more to debug
    %__LOGGING__% something to log
    %__LOGGING__% some more to log

GOTO:EOF

::----------------------------------------------------------------------

:: Run after exit from main
:: To STDERR
:cleanup
setlocal
    SET _fg=[30m
    SET _bg=[2m[106m
    SET _bg=[47m
    rem SET _bg=[47m
    SET _bg2=[7m
    SET _00=[0m
    (
        REM :: Black on green
        REM ::ECHO:[42m[30m
        REM :: Black on cyan
        ECHO:%_fg%%_bg%
        ECHO:^>^>^> --- %0 ---
        ECHO: Sweeping the floor
        IF EXIST "%logging%" ECHO:&SET /P_=  Logfile: <NUL&dir "%logging%"|find "%logging%"
        IF EXIST "%logging%" ECHO:^>^>^> ---8^<--- Logfile: %logging% ---^>8---%_bg2%&TYPE "%logging%"&ECHO:%_00%%_fg%%_bg%^<^<^< ---8^<---Logfile: %logging% ---^>8---
        ECHO:^<^<^< --- %0 ---%_00%
        
        IF EXIST "%logging%" ( 
            CHOICE /T 5 /C ync /D y /M "Delete log file??"
            IF ERRORLEVEL 3 ECHO Cancel&GOTO :EOF
            IF ERRORLEVEL 2 ECHO No? I'll leave it then.&GOTO :EOF
            IF ERRORLEVEL 1 ECHO Deleting log file [%logging%]

            DEL "%logging%"
            IF EXIST "%logging%" ( ECHO "Failed" & DIR "%logging%") ELSE ( ECHO Done )
        )
    ) >&2
endlocal
GOTO :EOF

::*** End of File ***
