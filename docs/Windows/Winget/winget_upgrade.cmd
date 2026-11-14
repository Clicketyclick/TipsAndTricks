@ECHO OFF
SetLocal EnableDelayedExpansion
::**
:: @file        winget_upgrade.cmd
:: @brief       Automate winget upgrade
:: @details     
:: 
:: Functions | Brief                
:----------- | ---------------------
:: :init     | Init and setup       
:: :admin    | Upgrade if elevated  
:: :user     | Error if not elevated
:: 
:: @copyright   http://www.gnu.org/licenses/lgpl.txt LGPL version 3
:: @author      Erik Bachmann <Erik@ClicketyClick.dk>
:: @since       2026-11-14T07:51:24 / erba
:: @version     2026-11-14T12.01.07
:: @date        2026-11-14T12.01.07
::**

:init
    ::https://stackoverflow.com/questions/7985755/how-to-detect-if-cmd-is-running-as-administrator-has-elevated-privileges#comment103360290_16285248
    net session >nul 2>&1 && (echo IS admin&CALL :admin)|| (echo not admin&CALL :user)
    ::net session >nul 2>&1 && (echo IS admin&CALL :admin)|| (echo not admin&CALL :user&timeout /t 10&goto :eof)
    :: Time to let it sink in ;-)
    timeout /t 10
GOTO :EOF


:admin
    ::#' List upgradable packages
    winget upgrade
    ::#' Do the upgrade
    winget upgrade --all
    
GOTO :eof

:user
    SET "TITLE=Not elevated!"
    SET "MSG=You're not admin!.\nThis is required to run this funtion"  MB_WARNING+MS_OD

    call box "%TITLE%" "%MSG%" 
    call msgbox "%MSG%" "%TITLE%" MB_WARNING+MS_OD
GOTO :EOF
