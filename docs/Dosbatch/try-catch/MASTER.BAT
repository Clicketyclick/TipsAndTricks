@echo off
setlocal
call exception init

%@Try%
  call testDivide
%@EndTry%
:@Catch
  echo %exception.Msg% detected and handled
  call exception clear
:@EndCatch
echo Finished Successfully!