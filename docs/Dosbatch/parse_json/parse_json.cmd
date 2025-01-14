@ECHO OFF
::&SetLocal EnableDelayedExpansion
::**
:: *   @file       parse_json.cmd
:: *   @brief      Parsing a simple single level compressed JSON into env vars
:: *   @details    
:: *   
:: *   @copyright  http://www.gnu.org/licenses/lgpl.txt LGPL version 3
:: *   @author     Erik Bachmann <Erik@ClicketyClick.dk>
:: *   @since      2025-01-14T13:54:19 / erba
:: *   @version    2025-01-14T13:54:19
::**
:: 

:init
    SET "bailout=CALL Exception.lib :Bailout"

    SET _exception_function=%1
:main
    IF DEFINED      _exception_function CALL %_exception_function% %2
    IF NOT DEFINED  _exception_function ECHO Function  [%1] not defined

GOTO :EOF



::**
:: *   @fn         parse_json
:: *   @brief      Parsing a simple single level compressed JSON into env vars
:: *   
:: *   @param [in]		File    JSON file
:: *   
:: *   @details    $(More details)
:: *   
:: *   @example    
:: *@code
:: *   set mystring={"other":1234,"year":2016,"title":"A Title Str","value":"str","time":"05:01"}
:: *   CALL :parse_json mystring
:: *   SET __
:: *@endcode
:: *   
@verbatim
__other=1234
__time=05:01
__title=A Title Str
__value=str
__year=2016
@endverbatim
:: *   
:: *   @todo       
:: *   @bug        
:: *   @warning    
:: *   
:: *   @see        https://
:: *   @since      2025-01-14T13:54:58
::**
:parse_json
::SETLOCAL
    SET STRING=%~1
    
    CALL SET STRING=%%%STRING%%%
    
    :: Trim braces and blanks
    call :lTrim string "{"
    call :lTrim string
    call :rTrim string "}"
    call :rTrim string 

    :: Escape colon between key and value
    ::- `": `   Quote + Colon + blank
    ::+ `"\t`
     set "string=%string:": =	%"
    ::- `":`    Quote + Colon
    ::+ `"\t`
     set "string=%string:":=	%"

    :: Remove blank in front of keys after string
    ::-  "value": "str", "time": "05:01"
    ::+  "value": "str","time": "05:01"
    set "string=%string:", "=","%"
    
    :: Remove blank in front of keys after number
    ::- ` 1234, "year": `
    ::- ` 1234,"year": `
    set "string=%string:, "=,"%"
    
    rem Remove quotes
    set string=%string:"=%

    rem Change colon+space by "]equal-sign"
    REM I.e. change TAB to `=`
    ::set "string=%string:: =]=%"
    ::set "string=%string::==%"
    set "string=%string:	==%"
    
    rem Separate parts at comma into individual array assignments
    ::set "string[%string:, =" & set "string[%"
    ::set "string[%string:,=]" & set "string[%"

    ::ECHO HELLO %STRING%
    
    ::ECHO set "__%string:,="  set "__%"
ENDLOCAL & set "__%string:,=" & set "__%"
::SET __
GOTO :EOF


:: https://www.dostips.com/?t=Function.lTrim
:lTrim string char -- strips white spaces (or other characters) from the beginning of a string
::                 -- string [in,out] - string variable to be trimmed
::                 -- char   [in,opt] - character to be trimmed, default is space
:$created 20060101 :$changed 20080227 :$categories StringManipulation
:$source https://www.dostips.com
SETLOCAL ENABLEDELAYEDEXPANSION
call set "string=%%%~1%%"
set "charlist=%~2"
if not defined charlist set "charlist= "
for /f "tokens=* delims=%charlist%" %%a in ("%string%") do set "string=%%a"
( ENDLOCAL & REM RETURN VALUES
    IF "%~1" NEQ "" SET "%~1=%string%"
)
EXIT /b


:: https://www.dostips.com/?t=Function.rTrim
:rTrim string char max -- strips white spaces (or other characters) from the end of a string
::                     -- string [in,out] - string variable to be trimmed
::                     -- char   [in,opt] - character to be trimmed, default is space
::                     -- max    [in,opt] - maximum number of characters to be trimmed from the end, default is 32
:$created 20060101 :$changed 20080219 :$categories StringManipulation
:$source https://www.dostips.com
SETLOCAL ENABLEDELAYEDEXPANSION
call set string=%%%~1%%
set char=%~2
set max=%~3
if "%char%"=="" set char= &rem one space
if "%max%"=="" set max=32
for /l %%a in (1,1,%max%) do if "!string:~-1!"=="%char%" set string=!string:~0,-1!
( ENDLOCAL & REM RETURN VALUES
    IF "%~1" NEQ "" SET %~1=%string%
)
EXIT /b


::*** End of File
