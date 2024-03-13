## Tee


```batch
@ECHO OFF&setLocal
::/**
:: *  @file       tee.cmd
:: *  @brief      read from standard input and write to standard output and files
:: *  
:: *  @details    Default log is `tee.%random%.txt`. Default cmd is `DIR /s`
:: * 
:: * 
:: *  @see			https://stackoverflow.com/a/27772454
:: * 
:: *  @copyright  http://www.gnu.org/licenses/lgpl.txt LGPL version 3
:: *  @author     Erik Bachmann <ErikBachmann@ClicketyClick.dk>
:: *  @since      2024-03-13T11:31:50 / erba
:: *  @version    2024-03-13T12:10:27
:: */

:init
	SET _Log=%~1
	SET _CMD=%2

	IF NOT DEFINED _CMD SET _CMD=DIR /s
	IF NOT DEFINED _LOG SET _Log=tee.%random%.txt

:main
	:: For any token from cmd store in %%I
	FOR /F "tokens=*" %%I IN ('%_CMD%') DO ECHO %%I & ECHO %%I>>"%_Log%"

	ECHO Log: "%_Log%"

::*** EOF ***
```
