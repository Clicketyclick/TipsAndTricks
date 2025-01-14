@echo off
setlocal

set mystring={ "other": 1234, "year": 2016, "title": "A Title Str", "value": "str", "time": "05:01"    }
::set mystring={"other":1234,"year":2016,"title":"A Title Str","value":"str","time":"05:01"}

SET mystring
CALL "%~dp0parse_json" :parse_json mystring

ECHO Display all __
SET __

ECHO Display "__time"
ECHO [%__TIME%]

ECHO Loop
FOR /F "tokens=*" %%a IN ('SET __' ) DO ECHO [%%a]

GOTO :EOF
