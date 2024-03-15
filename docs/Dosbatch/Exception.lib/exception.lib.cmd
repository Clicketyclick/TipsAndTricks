::**********************************************************************
:: @file      exception.cmd
:: @brief     Library with exception rutines
:: 
:: @details   
::  - :BAILOUT
::  - :ExitBatch    - Cleanly exit batch processing, regardless how many CALLs
::  - :CtrlC        - Emulates  [Ctrl]+[C]
::  - :buildYes     - Establish a Yes file for the language used by the OS
:: 
:: 
:: 
:: @copyright  http://www.gnu.org/licenses/lgpl.txt LGPL version 3
:: @author     Erik Bachmann <ErikBachmann@ClicketyClick.dk>
:: @since     2024-03-15T12:51:55 / erba
:: @version   2024-03-15T12:51:55
::**********************************************************************
:init
    SET "bailout=CALL Exception.lib :Bailout"

    SET _exception_function=%1
:main
    IF DEFINED      _exception_function CALL %_exception_function% %2
    IF NOT DEFINED  _exception_function ECHO Function  [%1] not defined

GOTO :EOF

::---------------------------------------------------------------------

:: Just at test
:hello

    ECHO [%1]

GOTO :eof

::---------------------------------------------------------------------

::**********************************************************************
:: @fn        :BailOut / ExitBatch
:: @brief     Perform a real exit emulating a  [Ctrl]+[C]
::  
:: @return    Work even for recurcive calls
::  
:: @details   
:: 
:: @example   CALL exception.lib :BailOut
:: 
:: @todo      
:: @bug       
:: @warning   
:: 
:: @see       https://stackoverflow.com/a/25474648
:: @since     2014-09-14T17:48:00/dbenham
::**********************************************************************

:BAILOUT
:ExitBatch - Cleanly exit batch processing, regardless how many CALLs
    if not exist "%temp%\ExitBatchYes.txt" call :buildYes

    call :CtrlC <"%temp%\ExitBatchYes.txt" 1>nul 2>&1

:CtrlC  - Emulates  [Ctrl]+[C]
    cmd /c exit -1073741510

:buildYes - Establish a Yes file for the language used by the OS
    pushd "%temp%"
    set "yes="
    copy nul ExitBatchYes.txt >nul
    for /f "delims=(/ tokens=2" %%Y in (
      '"copy /-y nul ExitBatchYes.txt <nul"'
    ) do if not defined yes set "yes=%%Y"
    echo %yes%>ExitBatchYes.txt
    popd
exit /b

::---------------------------------------------------------------------

::*** EOF ***