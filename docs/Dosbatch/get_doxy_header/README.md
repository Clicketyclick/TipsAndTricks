## Get Doxy header in batch


```batch
::/**
:: *  @file      Filename
:: *  @brief     Brief description
:: *  
:: *  @details   More details
:: *  
:: *  @copyright  http://www.gnu.org/licenses/lgpl.txt LGPL version 3
:: *  @author     Erik Bachmann <ErikBachmann@ClicketyClick.dk>
:: *  @since     2024-03-11T16:22:15 / erba
:: *  @version   2024-03-11T16:22:15
:: */

FOR /F "delims=@ tokens=2*" %%a IN ('findstr /r "^::.\*.*@" "%~f0" ^| findstr "@file @brief @version"') DO ECHO * %%a 1>&2

```

Should give:

```console
*  file      Filename
*  brief     Brief description
*  version   2024-03-11T16:22:15
```


