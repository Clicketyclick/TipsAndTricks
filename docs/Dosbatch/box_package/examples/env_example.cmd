@echo off
setlocal

set "TITLE=Environment title"
set "MSG=Line one\nLine two\nName\tValue"
set "BOX_STYLE=single"
set "BOX_WIDTH=50"
set "BOX_TAB_WIDTH=8"

call "%~dp0..\box.cmd"

endlocal
