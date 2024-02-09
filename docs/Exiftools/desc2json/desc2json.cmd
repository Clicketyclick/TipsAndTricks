@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION
::/**
:: *  @file      Desc2Json.cmd
:: *  @brief     Compile descriptions into JSON for ExifTool
:: *  
:: *  @details   
:: *  For each description file
:: *  	Find image ( DNG JPG TIF )
:: *  	Get globals
:: *  	Get headline
:: *  		Remove trailing spaces
:: *  		Escape quotes
:: *  		Print headline
:: *  
:: *  @copyright http://www.gnu.org/licenses/lgpl.txt LGPL version 3
:: *  @author    Erik Bachmann <ErikBachmann@ClicketyClick.dk>
:: *  @since     2023-10-17T14:11:51 / Bruger
:: *  @version   2023-10-17T15:13:50
:: */

ECHO:
ECHO:%0

:init
	SET _EXTENTIONS%=DNG JPG TIF
	SET _COUNT=0
	SET _THIS=%~f0
	Set _RESET=[0m
	Set _BOLD=[1m& 			Set _BOLD-=[21m&
	Set _Inverse=[7m& 		Set _Inverse-=[27m&
	Set _fBCyan=[96m&
	Set _fBGreen=[92m&
	SET AnsiOK=[97m[42m
	SET AnsiFAIL=[97m[41m
	SET AnsiSKIP=[97m[44m&
	SET AnsiMissing=[97m[100m
	SET AnsiRESET=[0m
	SET AnsiItalic=[3m
	ECHO %_RESET%
	SET _TEMPJSON=desc.json
	SET _JSON=desc.default.utf-8.json
:run
	(
		ECHO:[
		FOR /F %%a IN ('DIR /b desc ') DO CALL :Build_json %%a
		ECHO:]
	) > %_TEMPJSON%
	::powershell.exe -noprofile -command "Get-Content desc.json -Encoding Oem | Out-File desc.Oem.utf-8.json -Encoding utf8"
	::powershell.exe -noprofile -command "Get-Content desc.json -Encoding Ascii | Out-File desc.Ascii.utf-82.json -Encoding utf8"
	ECHO:Convert %_TEMPJSON% to UTF-8
	TITLE %_THIS%:%0:%_DESCFILE% - Convert charset from DOS to UTF-8
	powershell.exe -noprofile -command "Get-Content %_TEMPJSON% -Encoding Default | Out-File desc.default.utf-8.json -Encoding utf8"
	
	ECHO Update using: %_INVERSE%%%exiftool%% -json="%_JSON%" *.tif%_INVERSE-%
	ECHO:%AnsiOK%Done%_RESET%
	TITLE %_THIS%:%0:Done
GOTO :EOF

::---------------------------------------------------------------------

[{
  "SourceFile": "kbp1970-20232.tif",
  "Headline": "Headline text",
},
{

::---------------------------------------------------------------------

:Build_json
	SET _DESCFILE=%~1
	SET _IMGFILE=%_DESCFILE:~0,-3%
	SET _IMGFILE=%_DESCFILE%

	TITLE %_THIS%:%0:%_DESCFILE% - Get extention
	1>&2 SET /p = - %_fBGreen%%_DESCFILE%%_reset%<nul
	FOR %%e IN ( %_EXTENTIONS% ) DO CALL :test_ext %%e
	1>&2 ECHO: -- %_fBCyan%%AnsiItalic%%_IMGFILE%%_RESET%
	
	IF NOT "0"=="%_count%" ECHO:,
	ECHO:{

	ECHO:  "SourceFile":         "%_IMGFILE%",
	
	FOR /F "delims=½" %%d IN ('TYPE desc\%_DESCFILE%' ) DO (
		TITLE %_THIS%:%0:%_DESCFILE% :: Insert globals
		findstr /v /r "[{|}]" global.JSON

		SET "_Headline=%%d "

		TITLE %_THIS%:%0:%_DESCFILE% :: Remove trailing spaces
		FOR /L %%s in (1,1,31) DO IF "!_Headline:~-1!"==" " SET _Headline=!_Headline:~0,-1!

		TITLE %_THIS%:%0:%_DESCFILE% :: Escape quotes
		SET _Headline=!_Headline:"=\"!
		ECHO:  "Headline":           "!_headline!"
	)
	ECHO:}
	SET /A _COUNT+=1
GOTO :EOF :Build_json

::---------------------------------------------------------------------

:test_ext
	TITLE %_THIS%:%0:%_DESCFILE% :: Test type: %~1
	CALL SET _EXT=%~1
	CALL SET _TEST=%_DESCFILE:~0,-3%%_ext%
	IF EXIST "%_test%" CALL SET _IMGFILE=%_test%
GOTO :EOF :test_ext

::*** End of File ***
