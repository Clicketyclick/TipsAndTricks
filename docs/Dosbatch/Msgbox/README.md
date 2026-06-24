## Message box pop-op

Build a temporary cscript to display a pop-up
`msgbox "message" "title" MB_OK+MB_ICONINFO`

```bat
@ECHO OFF&SetLocal EnableDelayedExpansion
::**
:: * @file       msgbox.cmd
:: * @brief      Message box pop-op
:: * @details    Build a temporary cscript to display a pop-up
:: * 
:: *  %1 = Message
:: *  %2 = Title
:: *  %3 = Icon/Button style
:: * 
:: *  Styles:
:: *  0=OK, 1=OK/Cancel, 2=Abort/Retry/Ignore, 3=Yes/No/Cancel
:: *  4=Yes/No, 5=Retry/Cancel
:: * 
:: *  Add icons: 16=Critical, 32=Question, 48=Warning, 64=Information
:: * 
:: * @copyright  http://www.gnu.org/licenses/lgpl.txt LGPL version 3
:: * @author     Erik Bachmann <Erik@ClicketyClick.dk>
:: * @since      2026-06-24T09:47:06 / erba
:: * @version    2026-06-24T09:47:06
::**

:MsgBox

set "msg=%~1"
set "title=%~2"

:: Buttons
set /a MB_OK=0
set /a MB_OKCANCEL=1
set /a MB_ABORTRETRYIGNORE=2
set /a MB_YESNOCANCEL=3
set /a MB_YESNO=4
set /a MB_RETRYCANCEL=5

:: Icons
set /a MB_ICONERROR=16
set /a MB_ICONQUESTION=32
set /a MB_ICONWARNING=48
set /a MB_ICONINFO=64

:: Default buttons
set /a MB_DEFBUTTON2=256
set /a MB_DEFBUTTON3=512
set /a MB_DEFBUTTON4=768

set /a "style=%~3"


set "msg=%~1"
set "title=%~2"
set /a "style=%~3"


echo stype=%style%

set "vbs=%temp%\msgbox_%random%.vbs"
(
    echo MsgBox "%msg%", %style%, "%title%"
) > "%vbs%"

cscript //nologo "%vbs%"
set "result=%errorlevel%"
del "%vbs%"

exit /b %result%
```
