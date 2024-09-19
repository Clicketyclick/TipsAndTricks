@ECHO OFF
setlocal enabledelayedexpansion

:: run Clicketyclick progressbar main docs
:: run Clicketyclick progressbar "" docs
:: run Clicketyclick TipsAndTricks docs/Php

SET OWNER=%~1
IF NOT DEFINED OWNER SET OWNER=Clicketyclick

SET REPO=%~2
IF NOT DEFINED REPO SET REPO=progressbar

::SET BRANCH=%~3
::IF NOT DEFINED BRANCH SET BRANCH=main

SET SUBDIR=%~3
IF NOT DEFINED SUBDIR SET SUBDIR=*

SET MASTER=%OWNER%_%REPO%.master.zip

ECHO Get repro: "https://github.com/%OWNER%/%REPO%/archive/refs/heads/master.zip"
::curl -L -O "https://github.com/Clicketyclick/TipsAndTricks/archive/refs/heads/master.zip"
::curl -L -O "https://github.com/%OWNER%/%REPO%/archive/refs/heads/master.zip"
curl -L -o "%MASTER%" "https://github.com/%OWNER%/%REPO%/archive/refs/heads/master.zip"


for /f "tokens=* delims=" %%a in ('tar -tf "%MASTER%"' ) do (
  set "BRANCH=%%~a"
  goto continue
)
:continue

SET BRANCH=!BRANCH:%REPO%-=!
SET BRANCH=!BRANCH:/=!
ECHO [!BRANCH!]
::ECHO 34 !BRANCH:%REPO%-=!

::ECHO List entire repo
::tar -tf "%MASTER%"
::progressbar-main/doc/

ECHO List subdir: [%REPO%-%BRANCH%] [%SUBDIR%]
::tar -tf "%MASTER%" "%REPO%-%BRANCH%/%SUBDIR%"
tar -xf "%MASTER%" "%REPO%-%BRANCH%/%SUBDIR%"


GOTO :EOF
