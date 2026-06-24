@echo off
setlocal

set "BOX=%~dp0..\box.cmd"

echo.
echo === Heavy default ===
call "%BOX%" "My title" "Message content1\nMessage content2"

echo.
echo === Single ===
call "%BOX%" "My title" "Message content1\nMessage content2" single 67

echo.
echo === Double ===
call "%BOX%" "My title" "Message content1\nMessage content2" double 67

echo.
echo === Round with wrapping ===
call "%BOX%" --style=round --width=45 "Wrapped" "This is a long message that should wrap inside the box instead of expanding the box width."

echo.
echo === ASCII fallback ===
call "%BOX%" "My title" "Message content1\nMessage content2" ascii 67

echo.
echo === Environment variables ===
set "TITLE=Environment title"
set "MSG=Line one\nLine two\nName\tValue"
set "BOX_STYLE=single"
set "BOX_WIDTH=50"
set "BOX_TAB_WIDTH=8"
call "%BOX%"

endlocal
