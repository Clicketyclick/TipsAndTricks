
## Start a local PHP server (DOS batch)
```bat
@ECHO OFF
::## 
:: #  @file      run.cmd
:: #  @brief     Starting PHP webserver
:: #  
:: #  @details   Starting a local PHP webserver with root in current directory
:: #  
:: #  @copyright http://www.gnu.org/licenses/lgpl.txt LGPL version 3
:: #  @author    Erik Bachmann <ErikBachmann@ClicketyClick.dk>
:: #  @since     2023-03-13T12:29:14 / erba
:: #  @version   2023-03-13T12:29:14
:: ##  
ECHO Running PHP webserver for test
SET _PORT=8081
:: Start browser
START /B http://localhost:%_PORT%/
:: Get current subdir
FOR %%a IN ("%__CD__%\.") DO SET "currentDir=%%~nxa"
ECHO [%currentDir%]
:: Set window title
TITLE localhost:%_PORT% - [%currentDir%]
:: Star server
php -S localhost:%_PORT%/
```
