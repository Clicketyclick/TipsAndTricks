@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

:: Clear the screen, move to (0,0)
CALL ansi :posH 1 999            
:: Go to last row

CALL ansi :CLS                   :: Clear screen and return to current position
CALL ansi :ECHOe 0,0 bottom left

CALL ansi :save_cursor_pos


::CALL :posf_test 25;12     :: Does not work on Windows!
CALL :posh_test


CALL ansi :restore_cursor_pos
CALL ansi :ECHOe Restored c14

CALL ansi :moveup 5

CALL ansi "{{36;43}}Color{{0}}No color"

GOTO :EOF


SET _COL=25
SET _ROW=15

::CALL :posf_test 25;12
CALL ansi :posh_test

CALL ansi :moveBackwards 25
CALL ansi :echoe c-25r12

CALL ansi :moveForwards 50
CALL ansi :echoe c+50r12

SET _COL=2
SET _ROW=3
CALL ansi :posH "!_col!" "!_row!"
CALL ansi :echoe 123456789012345678901234567890

SET _COL=5
SET _ROW=3
CALL ansi :posH "!_col!" "!_row!"
CALL ansi :erase_eol



SET _COL=2
SET _ROW=4
CALL ansi :posH "!_col!" "!_row!"
CALL ansi :echoe 123456789012345678901234567890
CALL ansi :clear_line

SET _COL=1
SET _ROW=6
CALL ansi :posH "!_col!" "!_row!"
CALL ansi :echoe 123456789012345678901234567890
::CALL ansi :clear_line
ECHO:
ECHO:123456789012345678901234567890


CALL ansi :posH "0" "0"

GOTO :EOF




:: Not working in Windws
:posF_test
    CALL ansi :posF "!_col!" "!_row!"
    CALL echoe ":posF c!_col! r!_row!"

    SET _ROW=5

    CALL ansi :posF "!_col!" "!_row!"
    CALL echoe ":posF c!_col! r!_row!"

    ::GOTO :EOF


    SET _ROW=12

    CALL ansi :posF "!_col!" "!_row!"
    CALL echoe ":posF c!_col! r!_row!"
GOTO :EOF

:posh_test

    FOR /L %%i IN ( 5, 1, 8) DO (
        :: Set X
        SET /A _COL=25-2*%%i
        SET _ROW=%%i
        CALL ansi :posH "!_col!" "!_row!"
        CALL ansi :echoe "X c!_col! r!_row!"

        :: Description
        SET _COL=50
        CALL ansi :posH "!_col!" "!_row!"
        CALL ansi :echoe ":posH c!_col! r!_row!"
    )

GOTO :EOF


