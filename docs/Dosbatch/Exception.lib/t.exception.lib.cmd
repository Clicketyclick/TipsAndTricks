@ECHO OFF

::CALL "%~dp0library" :hello world
CALL "%~dp0exception" :hello world

echo %BAILOUT%

call :test
ECHO :main
GOTO :EOF


:test
    ECHO:- %0
    call :test1
    ECHO:- end test
GOTO :EOF

:test1
    ECHO:-- %0
    call :test2
    ECHO:-- end test1 
GOTO :EOF

:test2
    ECHO:--- %0
    echo bail out

    ECHO HELLO
    CALL %BAILOUT%
    echo HELLO again
    CALL library :BAILOUT
    echo NO GO 
    CALL library :ExitBatch
    ECHO again
    ECHO:--- end test2
GOTO :EOF


