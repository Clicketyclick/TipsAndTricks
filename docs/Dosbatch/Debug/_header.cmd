::** 
:: * @file      _header.cmd
:: * @brief     Display DoxIT header from caller
:: * 
:: * @details   DoxIT header
:: * 
:: * @copyright http://www.gnu.org/licenses/lgpl.txt LGPL version 3
:: * @author    Erik Bachmann <ErikBachmann@ClicketyClick.dk>
:: * @since     2024-09-20T20:31:04 / erba
:: * @version   2024-09-20T20:31:04
:: **

::>>> _Header ----------------------------------------------------------
:: Header    :: Bright white on Blue
@(
    @ECHO:[44m[97m
    @ECHO:
    @IF DEFINED verbose  (
        IF NOT [0]==[%verbose%] (
            FOR /F "delims=@ tokens=2*" %%a IN ('findstr /r "^::.\*.*@" "%~f1" ') DO ECHO * %%a
        ) else (
            FOR /F "delims=@ tokens=2*" %%a IN ('findstr /r "^::.\*.*@" "%~f1" ^| findstr "@file @brief @version"') DO @ECHO * %%a
        )
    ) else (
        FOR /F "delims=@ tokens=2*" %%a IN ('findstr /r "^::.\*.*@" "%~f1" ^| findstr "@file @brief @version"') DO @ECHO * %%a
    )
    @ECHO:[0m
) 1>&2
::<<< _Header ----------------------------------------------------------
