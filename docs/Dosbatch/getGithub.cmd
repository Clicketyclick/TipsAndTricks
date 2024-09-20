@ECHO OFF
::** 
:: * @file      getGithub.cmd
:: * @brief     Download a repository and unpack specific directory - or entire repo
:: * 
:: * @details   
:: * 
:: * @examples
:: *    getGithub Clicketyclick progressbar main docs
:: *    getGithub Clicketyclick progressbar "" docs
:: *    getGithub Clicketyclick TipsAndTricks docs/Php
:: * 
:: * @copyright http://www.gnu.org/licenses/lgpl.txt LGPL version 3
:: * @author    Erik Bachmann <ErikBachmann@ClicketyClick.dk>
:: * @since     2024-09-20T13:39:59 / erba
:: * @version   2024-09-20T13:39:59
:: **

:: Header
ECHO: 1>&2
FOR /F "delims=@ tokens=2*" %%a IN ('findstr /r "^::.\*.*@" "%~f0" ^| findstr "@file @brief @version"') DO ECHO * %%a 1>&2
ECHO: 1>&2


:main
    CALL :init %*
    CALL :download
    CALL :unpack
GOTO :EOF

:init
    SET OWNER=%~1
    IF NOT DEFINED OWNER SET OWNER=Clicketyclick

    SET REPO=%~2
    IF NOT DEFINED REPO SET REPO=progressbar

    ::SET BRANCH=%~3
    ::IF NOT DEFINED BRANCH SET BRANCH=main

    SET SUBDIR=%~3
    IF NOT DEFINED SUBDIR SET SUBDIR=*

    SET MASTER=%OWNER%_%REPO%.master.zip
    
    ECHO Owner	[%OWNER%]
    ECHO Repo	[%REPO%]
    ECHO Master	{%MASTER%]
    ECHO:
GOTO :EOF

:download
    ECHO Get repro: "https://github.com/%OWNER%/%REPO%/archive/refs/heads/master.zip"
    ::curl -L -O "https://github.com/Clicketyclick/TipsAndTricks/archive/refs/heads/master.zip"
    ::curl -L -O "https://github.com/%OWNER%/%REPO%/archive/refs/heads/master.zip"
    curl -L -o "%MASTER%" "https://github.com/%OWNER%/%REPO%/archive/refs/heads/master.zip"
GOTO :EOF

:unpack
::    for /f "tokens=* delims=" %%a in ('tar -tf "%MASTER%"' ) do (
::      set "BRANCH=%%~a"
::      goto continue
::    )
::    :continue
    ::ECHO 43 [%BRANCH%] 
    ECHO:
    SET BRANCH=_
    tar -tf "%MASTER%" > %MASTER%.lst
    
    CALL :head1 REPOBRANCH %MASTER%.lst
    ::ECHO 47 [%BRANCH%]

    
    SET BRANCH=!REPOBRANCH:%REPO%-=!
    SET BRANCH=!BRANCH:/=!
    ECHO Branch	[!BRANCH!]

    ::ECHO List entire repo
    ::tar -tf "%MASTER%"
    ::progressbar-main/doc/

    ECHO List subdir: [%REPO%-%BRANCH%] [%SUBDIR%]
    ::tar -tf "%MASTER%" "%REPO%-%BRANCH%/%SUBDIR%"
    tar -xf "%MASTER%" "%REPO%-%BRANCH%/%SUBDIR%"


GOTO :EOF

:head1  var filename
SETLOCAL
	FOR /f "tokens=1* delims=:" %%a IN ('findstr /n /r "^" "%~2" ^| findstr /r "^1:"') DO (
		ECHO:%~1	[%%b]
        ENDLOCAL&SET "%~1=%%b"
        GOTO :EOF
	)
GOTO :EOF

::*** End of file ***
