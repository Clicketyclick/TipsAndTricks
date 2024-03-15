# JSON in batch

***DRAFT***

- https://stackoverflow.com/questions/59972169/return-multiple-values-from-sqlcmd-query-in-batch-script
- https://stackoverflow.com/questions/36374496/parse-simple-json-string-in-batch

```batch
@echo off&setlocal 
::enabledelayedexpansion
::enabledelayedexpansion
:: https://stackoverflow.com/a/36378904/7485823

:: json XXX "{ "other": 1234, "year": 2016, "value": "str" }" YY

SET _SEP=;
SET _VAR=%~1
IF NOT DEFINED _VAR SET _VAR=JSON
CALL SET "_JSON=%~2"
SET _JSON
set _var_string=%~3
IF NOT DEFINED _VAR_string SET _VAR_string=JSON_str
set _var_str=
::set "JSON={ "other": 1234, "year": 2016, "value": "str", "time": "05:01" }"


set "_JSON=%_JSON:~1,-1%"
set "_JSON=%_JSON:":=",%"

set mod=0
for %%I in (%_JSON%) do (
    set /a mod = !mod
    setlocal enabledelayedexpansion
    if !mod! equ 0 (
        for %%# in ("!var!") do (
            endlocal 
            set "%_VAR%[%%~#]=%%~I"
            rem echo set "%_VAR%[%%~#]=%%~I"
            CALL :app_var _VAR_str "%%~#=%%~I" ";"
            rem CALL set "_VAR_str=!_var_str!;%%~#=%%~I"
        )
        rem for %%# in ("!var!") do endlocal & set "%_VAR%[%%~#]=%%~I"
        rem for %%# in ("!var!") do endlocal & CALL set "_VAR_str=!_var_str!;%%~#=%%~I"
    ) else (
        endlocal & set "var=%%~I"
    )
)


:: Remove leading separator
ECHO On
IF "%_sep%"=="%_var_str:~0,1%" SET _var_str=%_var_str:~1%

SET _var_str
GOTO :EOF


ECHO [%_var_string%]
CALL SET "%_var_string%=%_var_str%"
::for %%I in (%_var%) do (
echo _Var&set %_var%[
echo _var_str&set _var_str
echo _var_string&set _var_string
echo _var_string&set %_var_string%


GOTO :EOF
:app_var
    CALL SET "%~1=%%%~1%%%~3%%~2"
GOTO :EOF



SET XXX[1234]=
SET XXX[2016]=
SET XXX[minor]=
SET XXX[my]=
SET XXX[str]=
SET XXX[value]=
SET XXX[year]=




```
