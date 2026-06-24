@echo off
call "%~dp0..\box.cmd" --style=round --width=45 "Wrapped" "This is a long message that should wrap inside the box instead of expanding the box width."
