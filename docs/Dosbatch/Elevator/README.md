

## Elevation, local and domain admin

To elevate a DOS cmd use this:

```batch
elevate "command"
```

```batch
elevate rocknroll.cmd all "over the" world
```

`elevate.cmd`
```batch
@ECHO OFF&SetLocal EnableDelayedExpansion
GOTO :Init
::**
:: * @file       elevate.cmd
:: * @brief      Elevate cmd and run a cmd
:: * @details    
:: * 
:: * @warning    IF the command includes quotes, these will be escaped as `¤`
:: *    Therefor you cannot use `¤` anywhere in the commands
:: * 
                                                                        
:: * Functions|Brief
:: * ---|---
:: * :BatchGotAdmin     | Check for permissions
:: * :UACPrompt         | Prompt user
:: * :gotAdmin          | Got admin and run cmd
:: * :getWindowTitle    | Retrieve the current title and store it in var. %thisTitle%
:: * :isElevated        | Is this process elevated.|.
:: * :isLocalAdmin      | Is current user local admin?.|.
:: * :isDomaineAdmin    | Is current user Domaine Admin?.|.
:: * .|.
:: * 
:: * @code
:: *        elevate rocknroll.cmd
:: * @endcode
@verbatim
[Requesting administrative privileges for: rocknroll.cmd]
- Is elevated:  ☒ [1]
- Local admin:  ☑ [0]
- Domain admin: ☒ [1]
@endverbatim
:: * 
:: * @copyright  http://www.gnu.org/licenses/lgpl.txt LGPL version 3
:: * @author     Erik Bachmann <Erik@ClicketyClick.dk>
:: * @since      2025-08-31T14:56:47 / erba
:: * @version    2025-08-31T16:29:10
::**

:INIT
::GOTO :EOF
    IF NOT DEFINED _TRUE SET _TRUE=☑
    IF NOT DEFINED _FALSE SET _FALSE=☒

    CALL :BatchGotAdmin %*
GOTO :EOF

:: ----------------------------------------------------------------------

:BatchGotAdmin
    ::  --> Check for permissions
    >nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

    REM --> If error flag set, we do not have admin.
    if '%errorlevel%' NEQ '0' (
        TITLE Requesting administrative privileges for: %*
        CALL :getWindowTitle
        ECHO [!thisTitle!]

        CALL :isElevated
        CALL :isLocalAdmin
        CALL :isDomaineAdmin

        GOTO UACPrompt %*
    ) ELSE ( 
        GOTO gotAdmin %*
    )
GOTO :EOF

:: ----------------------------------------------------------------------

:UACPrompt
    ECHO SET UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    ::set params = %*:"=""
    SET params=%*
    :: Strip ALL quotes
    ::SET params=%params:"=%
    :: Strip leading and traling quotes
    FOR /F "useback tokens=*" %%a IN ('%params%') DO SET params=%%~a
    ::[%params:~0,2%]

    ::echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"
    ECHO UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=¤%", "", "runas", 1 >> "%temp%\getadmin.vbs"
    ::ECHO UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"
    ::TYPE "%temp%\getadmin.vbs"
    
    "%temp%\getadmin.vbs"
    ::DEL "%temp%\getadmin.vbs"

    EXIT /B
GOTO :EOF

:: ----------------------------------------------------------------------

:gotAdmin
    ::ECHO Got admin
    PUSHD "%CD%"
    CD /D "%~dp0"
    ::ECHO Running elevated [%*]
    SET _CMD=%*
    TITLE Running elevated [%_CMD%]
    
    ::CALL %*
    CALL %_CMD:¤="%
GOTO :EOF

:: ----------------------------------------------------------------------

:: https://superuser.com/a/1489755
:getWindowTitle
    :: Retrieve the current title and store it in var. %thisTitle%
    FOR /f "delims=" %%t IN (
        'powershell -noprofile -c [Console]::Title ^| FINDSTR .'
    ) DO SET "thisTitle=%%t"
GOTO :EOF

:: ----------------------------------------------------------------------

::## 
:: #  @fn        :isElevated
:: #  @brief     Is this process elevated
:: #  
:: #  @return    0: TRUE 1: False
:: #  
:: #  @details   Testing elevation on current process
:: #  
:: #  @example   
:: #  
:: #  @todo      
:: #  @bug       
:: #  @warning   
:: #  
:: #  @see       https://stackoverflow.com/a/17803989
:: #  @since     2023-03-10T13:54:45 / erba
:: #  
:: ##  
:isElevated
    ::whoami /groups | find "S-1-16-12288" >:NULL &&  ECHO ELEVATED || ECHO *NOT* elevated 
    whoami /groups | find "S-1-16-12288" >:NULL &&  ECHO - Is elevated:  %_TRUE% [!ErrorLevel!] || ECHO - Is elevated:  %_FALSE% [!ErrorLevel!]

GOTO :EOF


::## 
:: #  @fn        :isLocalAdmin
:: #  @brief     Is current user local admin?
:: #  
:: #  @return    0: TRUE 1: False
:: #  
:: #  @details   
:: #  
:: #  @example   
:: #  
:: #  @todo      
:: #  @bug       
:: #  @warning   
:: #  
:: #  @see       https://stackoverflow.com/a/17803989
:: #  @since     2023-03-10T13:54:45 / erba
:: #  
:: ##  
:isLocalAdmin
    whoami /groups | find "S-1-5-32-544" >:NULL && ECHO - Local admin:  %_TRUE% [!ErrorLevel!] || ECHO - Local admin:  %_FALSE% [!ErrorLevel!]
GOTO :EOF

::**
:: * @fn         :isDomaineAdmin
:: * @brief      Is current user Domaine Admin?
:: * 
:: * @param [in]		$(description)
:: * @return     0: TRUE 1: False
:: * 
:: * @details    
:: * 
:: * @code
:: *        CALL :isDomaineAdmin
:: * @endcode
@verbatim
@endverbatim
:: * <!--
:: * @todo       
:: * @bug        
:: * @warning    
:: * @note    
:: * -->
:: * @see        https://stackoverflow.com/a/17803989
:: * @since      2023-03-10T13:54:45 / erba
::**
:isDomaineAdmin
    ::whoami /groups | find "-512 " >:NULL && Echo I am a domain admin || ECHO Not domain admin
    whoami /groups | find "-512 " >:NULL && ECHO - Domain admin: %_TRUE% [!ErrorLevel!] || ECHO - Domain admin: %_FALSE% [!ErrorLevel!]
GOTO :EOF

::*** End of File ***
```
