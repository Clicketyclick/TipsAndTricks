@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION


IF (_-!_)==(_%~1_) (
    SET DEBUG=1
    SHIFT /1
    ECHO Debugging
    SET _log=ANSI.DEBUG.LOG
    IF EXIST "!_log!" DEL "!_log!"
) ELSE ECHO No debug


:tests
    CALL :primary           :: Blunt testing ANSI codes
GOTO :EOF

    CALL :simple            :: Simple tests
    CALL :combinations      :: Testing specific combination [on/off]
    CALL :alerts            :: Alert messages
    call :loop_all_colours  :: Loop all colours

    ECHO Done
GOTO :EOF


:primary
    ECHO %0 :: Blunt testing ANSI codes
    ECHO Code    Test   Windows  Function                       

    FOR /F "delims=^| tokens=1-4" %%a IN ('findstr "^|" ansi_test.cmd') DO (
        SET _code=%%a
        SET _tag=%%b
        SET _code=!_code: =!
        rem ECHO [%%a] [%%b] [%%c]
        SET _msg=[!_code!]	[{{!_code!}}Test{{0}}]	[%%d]	[!_tag!]    
        IF DEFINED DEBUG ECHO:&ECHO !_msg!
        CALL ansi "!_msg!"
        ECHO:
    )
    ::findstr "^|" ansi_test.cmd
GOTO :EOF

:triml
    ::trim left whitespace
    for /f "tokens=* delims= " %%a in ("%input%") do set input=%%a
GOTO :EOF

:trimr
    ::trim right whitespace (up to 100 spaces at the end)
    for /l %%a in (1,1,100) do if "!input:~-1!"==" " set input=!input:~0,-1! 
GOTO :EOF

:simple
    ECHO %0 :: Simple tests
    CALL ANSI "{{5;91}}5;91 TEST{{0}}"
    CALL ANSI "{{1;6;93;40}}1;6;93;40 TEST{{0}}"

    SET STR=TEST{{0;32}}0;32 Green{{1;31}}1;31 yyy{{0}}ZZZ
    CALL ANSI "%STR%"
    ECHO:
GOTO :EOF




:combinations
    ECHO %0 :: Testing specific combination [on/off]
    :: 0=norm, 1=bold 3=italic 4= underline 5=blink
    :: FG= 30-37
    :: BG= 40-47
    :: +60 High Intensity

    SET STR={{0;32}}0;32 Green{{0}}
    CALL ansi "[%STR%]"&ECHO:

    SET STR={{1;32}}1;32 BoldGreen{{0}}
    CALL ansi "[%STR%]"&ECHO:&ECHO:

    SET STR={{2;32}}2;32 LowGreen{{0}}
    CALL ansi "[%STR%]"&ECHO:

    SET STR={{3;32}}3;32 ItalicGreen{{0}}
    CALL ansi "[%STR%]"&ECHO:

    SET STR={{4;32}}4;32 UnderlineGreen{{0}}
    CALL ansi "[%STR%]"&ECHO:

    SET STR={{5;32}}5;32 BlinkGreen{{0}}
    CALL ansi "[%STR%]"&ECHO:

    SET STR={{6;32}}6;32 BlinkGreen{{0}}
    CALL ansi "[%STR%]"&ECHO:

    ECHO END

    SET STR={{0;92}}0;92 Green{{0}}
    CALL ansi "[%STR%]"&ECHO:

    SET STR={{1;92}}1;92 Green{{0}}
    CALL ansi "[%STR%]"&ECHO:

    SET STR={{0;102}}0;102 Green{{0}}
    CALL ansi "[%STR%]"&ECHO:

    SET STR={{1;102}}1;102 Green{{0}}
    CALL ansi "[%STR%]"&ECHO:

    SET STR={{0;32}}0;32 Green{{0}}
    CALL ansi "[%STR%]"&ECHO:
    
    SET STR={{51}}51 Green{{0}}
    CALL ansi "[%STR%]"&ECHO:
    
    SET STR={{52}}52 Green{{0}}
    CALL ansi "[%STR%]"&ECHO:
    
    SET STR={{53}}53 Overlined{{0}}
    CALL ansi "[%STR%]"&ECHO:
    
    SET STR={{9}}9 cross/line through{{0}}
    CALL ansi "[%STR%]"&ECHO:
GOTO :EOF

:alerts
    ECHO %0 :: Alert messages
    call :status 0 "This is ok"
    call :status 1 "This is an error"
    call :status 2 "Warning"
    call :status 3 "Alerting"
    call :status 4 "Notice"
    call :status 5 "Alerting [gtr 1]"
    call :status -2 "I don't know how to handle this [lss 0]"
GOTO :EOF


:loop_all_colours
    ECHO %0 :: Loop all colours
    ECHO Loop through all colours
    FOR /L %%f IN (0,1,7) DO (
        FOR /L %%b IN (0,1,7) DO (
            CALL SET "STR={{3%%f;4%%b}}_3%%f;4%%b_{{0}}"
            CALL ansi.cmd "!STR!"
        )
        ECHO:
    )
GOTO :EOF


:status code msg
    SETLOCAL
    SET _code=%~1
    SET _msg=%~2
    SET _status=UNKNOWN

    IF (0)==(%_code%) SET _status=OK
    IF (1)==(%_code%) SET _status=ERROR
    IF (2)==(%_code%) SET _status=WARNING
    IF (3)==(%_code%) SET _status=ALERT
    IF (4)==(%_code%) SET _status=NOTICE

    SET _status=%_status%            !

    IF (0)==(%_code%) SET _status=[{{92;40}}%_status:~0,10%{{0}}]0
    IF (1)==(%_code%) SET _status=[{{91;40}}%_status:~0,10%{{0}}]1
    IF (2)==(%_code%) SET _status=[{{1;95;40}}%_status:~0,10%{{0}}]2
    IF (3)==(%_code%) SET _status=[{{5;37;101}}%_status:~0,10%{{0}}]3
    IF (4)==(%_code%) SET _status=[{{96;40}}%_status:~0,10%{{0}}]4
    IF %_code% GTR 4  SET _status=[{{5;93;101}}%_status:~0,10%{{0}}]+
    ::IF %_code% LSS 0  SET _status=+[{{30;103;6}}%_status:~0,10%{{0}}]
    IF %_code% LSS 0  SET _status=[{{5;94;103}}%_status:~0,10%{{0}}]-

    CALL ansi "%_status% %_msg%"
    ECHO:
    ENDLOCAL
GOTO :EOF

:data
:: https://stackoverflow.com/a/33206814
 |0       |Function                       |Comments |Windows
|0       |Reset / Normal                 |all attributes off    |OK
|1       |Bold or increased intensity    |                          |OK
|2       |Faint (decreased intensity)    |Not widely supported.    |OK
|3       |Italic                         |Not widely supported. Sometimes treated as inverse.    |OK
|4       |Underline                      |    |OK
|5       |Slow Blink                     |less than 150 per minute    |OK
|6       |Rapid Blink                    |MS-DOS ANSI.SYS; 150+ per minute; not widely supported    |OK
|7       |[[reverse video]]              |swap foreground and background colours    |OK
|8       |Conceal                        |Not widely supported.    |OK
|9       |Crossed-out                    |Characters legible, but marked for deletion. Not widely supported.    |OK
|10      |Primary(default) font          |  | ?
    |11–19   |Alternate font                 |Select alternate font n-10| ?
|20      |Fraktur                        |hardly ever supported| -
|21      |Bold off or Double Underline   |Bold off not widely supported; double underline hardly ever supported.| ?
|22      |Normal colour or intensity      |Neither bold nor faint    | ?
|23      |Not italic, not Fraktur        |      | ?
|24      |Underline off                  |Not singly or doubly underlined   | ?
|25      |Blink off                      |   | ?
|27      |Inverse off                    |   | ?
|28      |Reveal                         |conceal off   | ?
|29      |Not crossed out                |   | ?
    |30–37   |Set foreground colour           |See colour table below   | OK
    |38      |Set foreground colour           |Next arguments are 5;<n> or 2;<r>;<g>;<b>, see below   | OK
|39      |Default foreground colour       |implementation defined (according to standard)   | ?
    |40–47   |Set background colour           |See colour table below   | OK
    |48      |Set background colour           |Next arguments are 5;<n> or 2;<r>;<g>;<b>, see below   | OK
|49      |Default background colour       |implementation defined (according to standard)   | ?
|51      |Framed                         |      | -
|52      |Encircled                      |      | -
|53      |Overlined                      |    |OK
|54      |Not framed or encircled        |   | ?
|55      |Not overlined                  |   | ?
|60      |ideogram underline             |hardly ever supported      | -
|61      |ideogram double underline      |hardly ever supported      | -
|62      |ideogram overline              |hardly ever supported      | -
|63      |ideogram double overline       |hardly ever supported      | -
|64      |ideogram stress marking        |hardly ever supported      | -
|65      |ideogram attributes off        |reset the effects of all of 60-64   | ?
    |90–97   |Set bright foreground colour    |aixterm (not in standard)   | OK
    |100–107 |Set bright background colour    |aixterm (not in standard)   | OK 

