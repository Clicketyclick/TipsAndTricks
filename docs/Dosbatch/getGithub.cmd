@ECHO OFF
SETLOCAL enabledelayedexpansion
::** 
:: * @file      getGithub.cmd
:: * @brief     Download a repository and unpack specific directory - or entire repo
:: * 
:: * @details   Download a public repository from Github
:: * 
:: * @examples
:: *    getGithub Clicketyclick progressbar main docs
:: *    getGithub Clicketyclick progressbar "" docs
:: *    getGithub Clicketyclick TipsAndTricks docs/Php
:: * 
:: * @copyright http://www.gnu.org/licenses/lgpl.txt LGPL version 3
:: * @author    Erik Bachmann <ErikBachmann@ClicketyClick.dk>
:: * @since     2024-09-20T13:39:59 / erba
:: * @version   2024-09-21T00:40:32
:: **

:: Header
::ECHO: 1>&2
::FOR /F "delims=@ tokens=2*" %%a IN ('findstr /r "^::.\*.*@" "%~f0" ^| findstr "@file @brief @version"') DO ECHO * %%a 1>&2
::ECHO: 1>&2

::GOTO :EOF
::----------------------------------------------------------------------

:main
    CALL :init %*
    CALL :download
    CALL :unpack
GOTO :EOF   :: :Main 

::----------------------------------------------------------------------

:init
    CALL %~dp0_debug
    CALL %~dp0_header %~f0
    
    SET OWNER=%~1
    IF NOT DEFINED OWNER SET OWNER=Clicketyclick

    SET REPO=%~2
    IF NOT DEFINED REPO SET REPO=progressbar

    SET SUBDIR=%~3
    IF NOT DEFINED SUBDIR SET SUBDIR=*

    SET MASTER=%OWNER%_%REPO%.master.zip
    
    %__VERBOSE__% Owner	[%OWNER%]
    %__VERBOSE__% Repo	[%REPO%]
    %__VERBOSE__% Master	{%MASTER%]
    %__VERBOSE__% :

GOTO :EOF   :: init

::----------------------------------------------------------------------

:download
    SET URL=https://github.com/%OWNER%/%REPO%/archive/refs/heads/master.zip
    %__VERBOSE__% Get repro: "%URL%"
    curl -L -o "%MASTER%" "%URL%"
GOTO :EOF   :: download

::----------------------------------------------------------------------

:unpack
    %__VERBOSE__%
    SET BRANCH=_
    tar -tf "%MASTER%" > %MASTER%.lst
    
    CALL :head1 REPOBRANCH %MASTER%.lst
    
    SET BRANCH=!REPOBRANCH:%REPO%-=!
    SET BRANCH=!BRANCH:/=!
    %__VERBOSE__% Branch	[!BRANCH!]

    %__DEBUG__% List subdir:	[%REPO%-%BRANCH%] [%SUBDIR%]
    IF DEFINED debug tar -tf "%MASTER%" "%REPO%-%BRANCH%/%SUBDIR%"
    tar -xf "%MASTER%" "%REPO%-%BRANCH%/%SUBDIR%"
GOTO :EOF   :: unpack

:: Get first line from list
:head1  var filename
SETLOCAL
	FOR /f "tokens=1* delims=:" %%a IN ('findstr /n /r "^" "%~2" ^| findstr /r "^1:"') DO (
		%__VERBOSE__% %~1	[%%b]
        ENDLOCAL&SET "%~1=%%b"
        GOTO :EOF
	)
GOTO :EOF   :: head1

::*** End of file ***
