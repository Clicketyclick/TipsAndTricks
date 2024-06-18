@ECHO OFF
setlocal ENABLEDELAYEDEXPANSION 
::/**
:: *  @file      isodate.cmd
:: *  @brief     Convert tab separated list to ics calendar
:: *  
:: *  @details   Please see README.md
:: *
:: *  @example   isodate %Y-%m-%d
:: *  @example   isodate %Y-%m-%dT%H:%M:%S.000Z
:: *  @example   isodate %Y%m%dT%H%M%SZ
:: *  
:: *  @copyright http://www.gnu.org/licenses/lgpl.txt LGPL version 3
:: *  @author    Erik Bachmann <ErikBachmann@ClicketyClick.dk>
:: *  @since     2024-06-17T15:00:31 / erba
:: *  @version   2024-06-17 17:40:41
:: */
FOR /F "delims=@ tokens=2*" %%a IN ('findstr /r "^::.\*.*@" "%~f0" ^| findstr "@file @brief @version"') DO ECHO * %%a 1>&2
ECHO:

:init
    SET "$DATE=%~1"
    SET "$START=%~2"
    SET "$END=%~3"
    SET "$TITLE=%~4"
    SET "$DESC=%~5"
    SET "$LOCATION=%~6"
    :: Default UTC
    SET "$TZ=Z"
    :: Local time zone
    SET "$TZ=Europe/Copenhagen"
    SET "$TAB=	"
    :: SET NOW
    FOR /F %%d IN ('CALL isodate %%Y%%m%%dT%%H%%M%%SZ') DO SET "$NOW=%%d"

:process
    CALL :header
    ::CALL :event "20241003T080000Z" "20241003T100000Z" "Hello world" "Nothing really to do\nBut who cares" "Somewhere"
    IF DEFINED $END CALL :event "%$START:-=%" "%$END:.=%" "%$TITLE%" "%$DESC%" "%$LOCATION%"
    IF NOT DEFINED $END CALL :loop
    CALL :footer
GOTO :EOF


:loop
echo loop 1>&2
    FOR /F "tokens=1,2,3,4,5,6* delims=%$TAB%" %%a IN ('type %$DATE%') DO (
        CALL :event "%%a" "%%b" "%%c" "%%d" "%%e" "%%f"
    )

GOTO :EOF

:header
    ECHO:BEGIN:VCALENDAR
    ECHO:VERSION:2.0
    ECHO:PRODID:-//isodate.cmd v2024-06-17 17:40:41//Erik Bachmann ErikBachmann@ClicketyClick.dk//EN
    ECHO:CALSCALE:GREGORIAN
    ECHO:METHOD:PUBLISH
    
    if "!Europe/Copenhagen"=="%$TZ%" (
        ::https://stackoverflow.com/a/35649729/7485823 - VTIMEZONE
        :: Copenhagen
        ECHO:BEGIN:VTIMEZONE
        ECHO:TZID:Europe/Copenhagen
        ECHO:X-LIC-LOCATION:Europe/Copenhagen
        ECHO:BEGIN:DAYLIGHT
        ECHO:TZOFFSETFROM:+0100
        ECHO:TZOFFSETTO:+0200
        ECHO:TZNAME:CEST
        ECHO:DTSTART:19700329T020000
        ECHO:RRULE:FREQ=YEARLY;BYDAY=-1SU;BYMONTH=3
        ECHO:END:DAYLIGHT
        ECHO:BEGIN:STANDARD
        ECHO:TZOFFSETFROM:+0200
        ECHO:TZOFFSETTO:+0100
        ECHO:TZNAME:CET
        ECHO:DTSTART:19701025T030000
        ECHO:RRULE:FREQ=YEARLY;BYDAY=-1SU;BYMONTH=10
        ECHO:END:STANDARD
        ECHO:END:VTIMEZONE
        ECHO:
        :: Blank time zone
        SET "$TZ="
    )
GOTO :EOF   :header

:event
    SET "$DATE=%~1"
    SET "$START=%~2"
    SET "$END=%~3"
    SET "$TITLE=%~4"
    SET "$DESC=%~5"
    SET "$LOCATION=%~6"
 
    :: Remove . and : from time
    IF DEFINED $DATE (
        SET "$DATE=%$DATE:-=%
    )
    IF DEFINED $START (
        SET "$START=!$START:.=!
        SET "$START=!$START::=!
        SET "$START=!$START!0000
        SET "$START=!$START:~0,6!
    )
    ::SET "$START=!$START:~0,6!
    IF DEFINED $END (
        SET "$END=!$END:.=!
        SET "$END=!$END::=!
        SET "$END=!$END!0000
        SET "$END=!$END:~0,6!
    )

    1>&2 ECHO [%$DATE%] [%$START%] [%$END%] [%$TZ%] [%$TITLE%] [%$DESC%] [%$LOCATION%]
    
    ECHO:BEGIN:VEVENT
    ECHO:DTSTAMP:%$DATE%T%$START%%$TZ%
    ECHO:DTSTART:%$DATE%T%$START%%$TZ%
    ECHO:DTEND:%$DATE%T%$END%%$TZ%
    ECHO:SUMMARY:%$TITLE%
    ECHO:DESCRIPTION:%$DESC%
    ECHO:LOCATION:%$LOCATION%
    ECHO:CLASS:PUBLIC
    ECHO:SEQUENCE:0
    ECHO:CREATED:%$NOW%
    ECHO:LAST-MODIFIED:%$NOW%
    ECHO:STATUS:CONFIRMED
    ECHO:TRANSP:OPAQUE
    ECHO:END:VEVENT
    ECHO:
GOTO :EOF   :event

:footer
    ECHO END:VCALENDAR
GOTO :EOF :footer

::*** EOF ***