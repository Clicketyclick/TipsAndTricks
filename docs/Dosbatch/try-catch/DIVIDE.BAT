:: divide.bat  numerator  divisor
@echo off
setlocal
set /a result=%1 / %2 2>nul || call exception throw -100 "Division exception" "divide.bat"
echo %1 / %2 = %result%
exit /b