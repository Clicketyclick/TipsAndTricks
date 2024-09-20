@ECHO OFF
::** 
:: * @file      getGithub.cmd
:: * @brief     Download a repository and unpack specific directory - or entire repo
:: * 
:: * @details   $(More details)
:: * 
:: * @examples
:: *    getGithub Clicketyclick progressbar main docs
:: *    getGithub Clicketyclick progressbar "" docs
:: *    getGithub Clicketyclick TipsAndTricks docs/Php
:: * 
:: * @copyright http://www.gnu.org/licenses/lgpl.txt LGPL version 3
:: * @author    Erik Bachmann <ErikBachmann@ClicketyClick.dk>
:: * @since     2024-09-20T13:39:59 / erba
:: * @version   2024-09-20T14:24:17
:: **

:: Header
ECHO: 1>&2
FOR /F "delims=@ tokens=2*" %%a IN ('findstr /r "^::.\*.*@" "%~f0" ^| findstr "@file @brief @version"') DO ECHO * %%a 1>&2
ECHO: 1>&2

::----------------------------------------------------------------------

:main
    CALL :init %*
    CALL :download
    CALL :unpack
GOTO :EOF   :: :Main 

::----------------------------------------------------------------------

:init
    IF DEFINED DEBUG SET VERBOSE=1
    
    SET OWNER=%~1
    IF NOT DEFINED OWNER SET OWNER=Clicketyclick

    SET REPO=%~2
    IF NOT DEFINED REPO SET REPO=progressbar

    SET SUBDIR=%~3
    IF NOT DEFINED SUBDIR SET SUBDIR=*

    SET MASTER=%OWNER%_%REPO%.master.zip
    
    IF DEFINED VERBOSE (
        ECHO Owner	[%OWNER%]
        ECHO Repo	[%REPO%]
        ECHO Master	{%MASTER%]
        ECHO:
    )
GOTO :EOF   :: init

::----------------------------------------------------------------------

:download
    SET URL=https://github.com/%OWNER%/%REPO%/archive/refs/heads/master.zip
    IF DEFINED VERBOSE ECHO Get repro: "%URL%"
    curl -L -o "%MASTER%" "%URL%"
GOTO :EOF   :: download

::----------------------------------------------------------------------

:unpack
    IF DEFINED VERBOSE ECHO:
    SET BRANCH=_
    tar -tf "%MASTER%" > %MASTER%.lst
    
    CALL :head1 REPOBRANCH %MASTER%.lst
    
    SET BRANCH=!REPOBRANCH:%REPO%-=!
    SET BRANCH=!BRANCH:/=!
    IF DEFINED VERBOSE ECHO Branch	[!BRANCH!]

    IF DEFINED DEBUG ECHO List subdir: [%REPO%-%BRANCH%] [%SUBDIR%]
    IF DEFINED DEBUG tar -tf "%MASTER%" "%REPO%-%BRANCH%/%SUBDIR%"
    tar -xf "%MASTER%" "%REPO%-%BRANCH%/%SUBDIR%"
GOTO :EOF   :: unpack

:: Get first line from list
:head1  var filename
SETLOCAL
	FOR /f "tokens=1* delims=:" %%a IN ('findstr /n /r "^" "%~2" ^| findstr /r "^1:"') DO (
		IF DEFINED VERBOSE ECHO:%~1	[%%b]
        ENDLOCAL&SET "%~1=%%b"
        GOTO :EOF
	)
GOTO :EOF   :: head1

::*** End of file ***
