## Wrapper for Notepad++ - or Windows Notepad


```cmd
::/**
:: *  @file      notepad.cmd
:: *  @brief     Calling Notepad++ or default to Windows Notepad
:: *  
:: *  @details   Calling Notepad++ (32bit or 64bit) or default to windows notepad
:: *  
:: *  @copyright http://www.gnu.org/licenses/lgpl.txt LGPL version 3
:: *  @author    Erik Bachmann <ErikBachmann@ClicketyClick.dk>
:: *  @since     2024-09-23T10:13:15 / erba
:: *  @version   2024-09-23T10:13:15
:: */

IF EXIST "C:\Program Files (x86)\Notepad++\notepad++.exe" (
    "C:\Program Files (x86)\Notepad++\notepad++.exe" %*
) ELSE (
    IF EXIST "C:\Program Files\Notepad++\notepad++.exe" (
        "C:\Program Files\Notepad++\notepad++.exe" %*
    ) ELSE (
        c:\windows\notepad.exe %*
    )
)
```
