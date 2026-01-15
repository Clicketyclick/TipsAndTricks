@ECHO OFF&
SetLocal EnableDelayedExpansion
::**
:: * @file       ansi.cmd
:: * @brief      Print a ANSI encoded string to CON:
:: * @details    
:: * 
:: * > CALL ansi "[{{92;40}}Bold green on black{{0}}]"
:: * will be equevelant to
:: * > SET /P _=[[92;40mBold green on black^[0m]>CON:<NUL:
:: * 
:: * @warning   This script MUST be stored with ANSI characterset
:: * 
:: * @copyright  http://www.gnu.org/licenses/lgpl.txt LGPL version 3
:: * @author     Erik Bachmann <Erik@ClicketyClick.dk>
:: * @since      2026-01-13T12:36:05 / erba
:: * @version    2026-01-13T12:36:05
::**

::SET DEBUG=
::IF (-!)==(%~1) (
::    SET DEBUG=1
::    SHIFT /1
::)

::IF DEFINED DEBUG ECHO Debugging %0

SET _ARG=%~1

IF NOT (:)==(%_ARG:~0,1%) (
    rem ECHO %0 Unknown argument [%~1] %_ARG:~0,1%
    rem EXIT /b
    CALL :ansi %*
    rem EXIT /b
    rem GOTO :EOF
) ELSE (
    CALL %~1 %~2 %~3 %~4 %~5 %~6 %~7 %~8 %~9 
)




GOTO :EOF


:ansi
SETLOCAL
    ECHO :: Get string w encoding
    SET STR=%~1
    :: Set prefix
    SET STR=%STR:{{=[%
    :: Set suffix
    SET STR=%STR:}}=m%
    
    IF DEFINED DEBUG ECHO "%STR:=_%" >> ANSI.DEBUG.LOG
    
    :: Print w/o newline!
    SET /P _=%STR%>CON: <NUL:
ENDLOCAL
GOTO :EOF























:clear_line
    :: Clear Line
    CALL ansi {{2K
GOTO :EOF

:erase_eol
    :: Erase to end of line
    CALL ansi {{K
GOTO :EOF

:save_cursor_pos
    :: Save cursor position")
    CALL ansi {{s
GOTO :EOF

:restore_cursor_pos
    :: Restore cursor position\n")
    CALL ansi {{u
GOTO :EOF


:posH col row
    :: Put the cursor at line L and column C.")
    ::CALL ansi {{<L>;<C>H
    CALL ansi "{{%~2;%~1H"
GOTO :EOF

:posf col row
    ECHO:: %0 Does not work on Windows!
    :: Put the cursor at line L and column C.")
    ::    CALL ansi {{<L>;<C>f}}
    CALL ansi {{%~2;%~1f
GOTO :EOF

:pos col
    :: Put the cursor at line L and column C.")
    CALL ansi {{!_pos!C

GOTO :EOF


:moveup row
    :: Move the cursor up N lines
    CALL ansi {{%~1A
GOTO :EOF

:moveForwards
    :: Move the cursor forward N columns
    CALL ansi {{%~1C
GOTO :EOF

:moveBackwards
    :: Move the cursor backward N columns\n")
    CALL ansi {{%~1D
GOTO :EOF


:cls
    :: Clear the screen, move to (0,0)"
    CALL ansi "{{2J"
GOTO :EOF



:ECHOe
    SETLOCAL
    SET /P _=%*<NUL:>CON:
    ENDLOCAL
GOTO :EOF

REM ----------------------------------------------------------------------


