## Message box pop-op

Build a temporary cscript to display a pop-up
`msgbox "message" "title" MB_OK+MB_ICONINFO`

```bat
::@ECHO OFF&SetLocal EnableDelayedExpansion
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
:: * Message can have newline "\n" and tabs "\t"
:: * Icons are prefixed to title as well
:: * 
:: * @code
:: * call msgbox.cmd "You're not admin.\n\tThis is required to run this function" "Not elevated" MB_ICONWARNING+MB_OK
:: * @endcode
:: * 
:: * Should give
::@verbatim
:: * ⚠ Not elevated
:: * You're not admin.
:: *    This is required to run this function
::@endverbatim
:: *
:: * @see        https://ss64.com/vb/msgbox.html
:: * @copyright  http://www.gnu.org/licenses/lgpl.txt LGPL version 3
:: * @author     Erik Bachmann <Erik@ClicketyClick.dk>
:: * @since      2026-06-24T09:47:06 / erba
:: * @version    2026-06-24T10:39:10
::**

:MsgBox
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

:: Aliases
set /a MB_ERROR=16
set /a MB_QUESTION=32
set /a MB_WARNING=48
set /a MB_INFO=64

:: Default buttons
set /a MB_DEFBUTTON2=256
set /a MB_DEFBUTTON3=512
set /a MB_DEFBUTTON4=768

:: Temp script file
set "vbs=%temp%\msgbox_%random%%random%.vbs"

:: Parse arguments
set "msg=%~1"
set "title=%~2"
set "styleExpr=%~3"

:: Parse style
if not defined styleExpr set "styleExpr=0"
2>nul set /a "style=%styleExpr%"
if errorlevel 1 set "style=0"


(
    echo msg = WScript.Arguments^(0^)
    :: Expand newline and tabs
    echo msg = Replace^(msg, "\n", vbCrLf^)
    echo msg = Replace^(msg, "\t", vbTab^)

    echo title = WScript.Arguments^(1^)
    echo style = CLng^(WScript.Arguments^(2^)^)
    :: Icons are prefixed to title as well
    echo icon = style And ^&H70
    echo Select Case icon
    echo     Case 64
    echo         title = ChrW^(^&HD83D^) ^& ChrW^(^&HDEC8^) ^& " " ^& title
    echo     Case 32
    echo         title = ChrW^(^&H2753^) ^& " " ^& title
    echo     Case 48
    echo         title = ChrW^(^&H26A0^) ^& " " ^& title
    echo     Case 16
    echo         title = ChrW^(^&H2757^) ^& " " ^& title
    echo End Select

    echo WScript.Quit^(MsgBox^(msg, style, title^)^)
) > "%vbs%"

:: Call temp script
cscript //nologo "%vbs%" "%msg%" "%title%" "%style%"
set "result=%errorlevel%"
:: Clean up
del "%vbs%" >nul 2>nul

exit /b %result%
```
