@ECHO OFF&SETLOCAL 
::/**
:: *  @file      iso_pack.cmd
:: *  @brief     Using MarcEdit to pack ISO-2709 file
:: *  
:: *  @details   Load ISO-2709 and dump to same file w. extention
:: *  
:: *  @example  ..\iso_pack SDUB45_hold_001_2024-08-26.txt
:: *  
:: * @note    Requires that MarcEdit is already installed
:: *  
:: *  @copyright http://www.gnu.org/licenses/lgpl.txt LGPL version 3
:: *  @author    Erik Bachmann <BIT@bib.sdu.dk>
:: *  @since     2024-09-03T16:25:50 / erba
:: *  @version   2025-09-16T15:46:40
:: */

    CALL :init
    CALL :main
GOTO :EOF

::----------------------------------------------------------------------

:init
    :: Get Doxy header
    FOR /F "delims=@ tokens=2*" %%a IN ('findstr /r "^::.\*.*@" "%~f0" ^| findstr "@file @brief @version"') DO ECHO * %%a 1>&2
    ECHO: 1>&2

    CALL :SetCmarcedit
    ECHO [%_CMARC%]

    ::SET _CMARC="C:\Program Files\Terry Reese\MarcEdit 7.7\cmarcedit.exe"    
    IF NOT EXIST %_CMARC% ECHO MarcEdit not found [%_CMARC%]&TIMEOUT /T 10 & GOTO :EOF
GOTO :EOF :init

::----------------------------------------------------------------------

:main
    :: Get input
    SET _ISOFILE=%1
    :: set /p "id=Enter ID: "
    IF NOT EXIST "%_ISOFILE%" ECHO Not valid input given [%_ISOFILE%]&GOTO :EOF
    ECHO ISOfile     [%_ISOFILE%]

    :: Set out as input with new extention
    FOR /F "usebackq delims==" %%i IN ('%_ISOFILE%') DO (
        ::@echo %%~dpni
        SET _DUMPFILE="%%~dpni.mrc"
    )
    ECHO Dumpfile    [%_DUMPFILE%]

    IF EXIST %_DUMPFILE% (
        ECHO Dump file already exists [%_ISOFILE%]
        CHOICE /C YNC /M "Overwrite file? Press Y for Yes, N for No or C for Cancel."
        IF ERRORLEVEL 3 ECHO Cancel& GOTO :EOF
        IF ERRORLEVEL 2 ECHO No& GOTO :EOF
        IF ERRORLEVEL 1 ECHO Yes
    )

    ECHO Packing ..
    %_CMARC% -s %_ISOFILE% -d %_DUMPFILE% -make -utf8

    ECHO Output:
    DIR /B %_DUMPFILE%

GOTO :EOF


::----------------------------------------------------------------------

:: Extract value from registry
:getRegVal  https://stackoverflow.com/a/13674631
    SETLOCAL
    SET "ValueName=%~3"
    :: /v ValueName
    IF DEFINED ValueName SET "ValueName= /v %ValueName%"
    :: 
    FOR /F "usebackq tokens=3*" %%A IN (`REG QUERY "%~2" %ValueName%`) DO (
        set getRegVal=%%A %%B
    )
    ENDLOCAL&CALL SET "%~1=%getRegVal%"
GOTO :EOF :getRegVal

::----------------------------------------------------------------------

:: Trim to first arg only
:GetFirstArg
    SET %~1=%~2
GOTO :EOF :GetFirstArg

::----------------------------------------------------------------------

:SetCmarcedit
    SET _CMARC=
    :: Setting cmarcedit
    CALL :getRegVal _CMARC "HKEY_CLASSES_ROOT\Applications\MarcEdit.exe\shell\open\command"
    ::SET _X
    :: _Y_ get first val
    CALL :GetFirstArg _CMARC %_CMARC%
    SET _CMARC=%_CMARC:\marcedit.exe=\cmarcedit.exe%
GOTO :EOF :SetCmarcedit

::*** EOF ***