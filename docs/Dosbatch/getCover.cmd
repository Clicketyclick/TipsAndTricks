@ECHO OFF&SETLOCAL
::
::@file      getCover.cmd
::@brief     Download book covers by ISBN
:: 
::@details   Read ISBN as argument 1 - or piped in
::@example   
::      getCover.cmd 9788712065142
:: or
::      type isbn.txt | getcover.cmd
:: 
::@copyright http://www.gnu.org/licenses/lgpl.txt LGPL version 3
::@author    Erik Bachmann <ErikBachmann@ClicketyClick.dk>
::@since     2022-12-27T22:31:16 / Erik Bachmann Pedersen
::@version   2022-12-27T22:31:16 / Erik Bachmann Pedersen
::

SET ISBN=%1
SET CURL_GET=curl --location --insecure --request GET 

ECHO Downloading %ISBN% from Bkm, Saxo or OpenLibrary.org
ECHO:

IF "!" == "!%1" (
    ECHO - Getting ISBN's from pipe
    CALL :linebyline :getcover
) else (
    ECHO - Getting single ISB
    CALL :getcover %ISBN%
)

GOTO :EOF

::----------------------------------------------------------------------

:linebyline
:: https://stackoverflow.com/a/6980605
:: Process input line by line
    FOR /F "tokens=*" %%a IN ('findstr "^"') do (
        CALL %1 %%a
    )
GOTO :EOF

::----------------------------------------------------------------------

:getCover
:: Get cover using one of several links
    setlocal
    SET ISBN=%1
    ECHO ISBN=%ISBN%

    %CURL_GET% "https://images.bogportalen.dk/images/%ISBN%.jpg" --output "%ISBN%.jpg" || ^
    %CURL_GET% "https://imgcdn.saxo.com/_%ISBN%/0x1500" --output "%ISBN%.jpg" || ^
    %CURL_GET% "https://covers.openlibrary.org/b/isbn/%ISBN%-L.jpg" --output "%ISBN%.jpg"
    IF ERRORLEVEL 1 (
        ECHO ERROR %ERRORLEVEL%
        
        ECHO Try: https://bookcover-api.onrender.com/bookcover/%ISBN%
        %CURL_GET% "https://bookcover-api.onrender.com/bookcover/%ISBN%"
    ) ELSE (
        ECHO OK %ERRORLEVEL%
        DIR /N/Q "%ISBN%*.jpg" | FIND ".jpg"
        rem explore "%ISBN%*.jpg"
    )
    ECHO:
GOTO :EOF
::----------------------------------------------------------------------
