@echo off
cd /d "%~dp0\.."

echo === Basic ===
call mdtable.cmd examples\basic.md

echo.
echo === Long, max width 50 ===
call mdtable.cmd --max-width=50 examples\long.md

echo.
echo === Alignment ===
call mdtable.cmd examples\alignment.md

echo.
echo === Double style ===
call mdtable.cmd --style=double examples\basic.md
