<!--
![dos_batch_scripts](https://user-images.githubusercontent.com/15011459/209822156-0371b1a4-ee1f-43ef-a11d-97cdcc4742dd.jpg)
<<img align="right" width="100" height=auto src="dos_batch_scripts.jpg">
-->
@@Dosbatch_logo@@
# DOS batch scripts

- The ["_" Windows Batch Library](https://github.com/ClicketyClickDK/Underscore) (The "underscore" Windows Batch Library)  
is a collection of generic, ready-to-use batch scripts - and has a life (and repository) of it's own.
- The ["_" Windows Batch Library Tips &amp; Tricks](https://github.com/ClicketyClickDK/Underscore/blob/master/Tips2tricks.md)
- [getBookCover](getBookCover/)  
Download book covers by ISBN
- [How to get piped input in windows batch file? @@Stackoverflow_icon@@](https://stackoverflow.com/a/52583931/7485823)
- [Elevation, local and domain admin](Elevator/)
- [Get Doxy header](get_doxy_header/)
- [`FORFILES`](forfiles/) is The-Windows-way of finding directories and files.
- [Tail](../Powershell/tail.bat) Print the last 30 lines of each FILE to standard output.
- [ISO 86001](Iso86001_date/) - Current date in ISO 86001 (YYYY-MM-DDThh:mm:ss.000z)
- [getGithub.cmd](getGithub.cmd) - Download a repository and unpack specific directory - or entire repo
- [default value of Set /p in batch script @@Stackoverflow_icon@@](https://stackoverflow.com/a/48655341): `SET /P "MyVar=" || SET "MyVar=My Default Value"`

## Get first/last line from file

Source: [Fetch only first line from text file using Windows Batch File @@Stackoverflow_icon@@](https://stackoverflow.com/a/46134683)

```cmd

(ECHO:A a&ECHO:B b&ECHO:C c)>file.txt

:: Fetch only first line from text file using Windows Batch File - https://stackoverflow.com/a/46134683
ECHO Get first line from file:
SET first_line=
SET /P first_line=<file.txt&CALL ECHO %first_line%

ECHO Get last line from file:
SET last_line=
FOR /F "UseBackQ Delims==" %%A In ("file.txt") DO SET "last_line=%%A" 
ECHO %last_line%
```

## ZIP

On Windows 10 build 17063 or later you can use `tar.exe` (Source: [Superuser @@Superuser_icon@@](https://superuser.com/a/1473255) )
```batch
C:\> tar -xf archive.zip
```

## ls -l

```cmd
@echo off&SETLOCAL enabledelayedexpansion
# ls -l
for /f "tokens=*" %%i in ('dir /a /b /-p /o:gen') do ( 
    SET "_FILE=%%i                                       ."
    SET "_ATTRIB=%%~ai ."
    SET "_SIZE=           %%~zi"
    ECHO !_FILE:~0,40!	%%~ti !_SIZE:~-11!  !_ATTRIB:~0,11!.
)
```

## Get last token

```cmd
:: https://stackoverflow.com/a/26493855
:getLastToken
SETLOCAL
    for %%a in ("%~2\.") do set "lastPart=%%~nxa"
    ENDLOCAL&SET "%~1=%lastPart%"
GOTO :EOF
```


## Usefull links

- [DosTips - The DOS Batch Guide @@dostips_icon@@]](https://www.dostips.com).  
This DOS batch guide brings structure into your DOS script by using real function like constructs within a DOS batch file.
 
<!--
### Not so usefull links

- [DOS Batch Programming - Eric Phelps](https://www.ericphelps.com/batch/)
    - Common DOS workarounds and methods to accomplish tasks not covered in the Win9x manual. Particular emphasis on processing lists and lines of data.
- [Converting DOS Batch Files to Shell Scripts](https://linux.die.net/abs-guide/dosbatch)
    - Even the crippled DOS batch file language allowed writing some fairly powerful scripts and applications, though they often required extensive kludges and ...
-->
