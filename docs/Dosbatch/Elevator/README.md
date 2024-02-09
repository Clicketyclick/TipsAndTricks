

## Elevation, local and domain admin


```batch
@ECHO OFF
SETLOCAL
::## 
:: #  @file      elevator.cmd
:: #  @brief     $(Brief description)
:: #  
:: #  @details   $(More details)
:: #  
:: #  @copyright http://www.gnu.org/licenses/lgpl.txt LGPL version 3
:: #  @author    Erik Bachmann <ErikBachmann@ClicketyClick.dk>
:: #  @since     2023-03-10T13:55:15 / erba
:: #  @version   2023-03-10T13:55:15
:: ##

:MAIN
    CALL :isElevated
    ECHO %ERRORLEVEL%

    CALL :isLocalAdmin
    ECHO %ERRORLEVEL%

    CALL :isDomaineAdmin
    ECHO %ERRORLEVEL%
GOTO :EOF

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
    whoami /groups | find "S-1-16-12288" >:NULL &&  ECHO ELEVATED || ECHO *NOT* elevated 
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
    whoami /groups | find "S-1-5-32-544" >:NULL && Echo I am a local admin || ECHO NOT local admin
GOTO :EOF

::## 
:: #  @fn        :isDomaineAdmin
:: #  @brief     Is current user Domaine Admin?
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
:isDomaineAdmin
    whoami /groups | find "-512 " >:NULL && Echo I am a domain admin || ECHO Not domain admin
GOTO :EOF
```
