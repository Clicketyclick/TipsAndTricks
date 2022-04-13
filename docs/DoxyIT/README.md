# DoxyIT Setup

T&T for NotePad++ and DoxyIT

Modifications and implemtation in NotePad++

Note! DoxyIT may only work in the 32bit version of Notepad++


## Php

### Settings

.|.
---|---
Start	|/**
Line	| *  
End	| */
Prefix	|\


### Function
```

$@fn        $FUNCTION
$@brief     $(Brief description)

$@param [in] $PARAM $|$(Description for $PARAM)
$@return    $(Return description)

$@details   $(More details)

$@example   

$@todo      
$@bug       
$@warning   

$@see       https://
$@since     $DATE_Y-$DATE_m-$DATE_dT$DATE_H:$DATE_M:$DATE_S / $USER

```

### File 

```

$@file      $FILENAME
$@brief     $(Brief description)

$@details   $(More details)

$@copyright http://www.gnu.org/licenses/lgpl.txt LGPL version 3
$@author    Erik Bachmann <ErikBachmann@ClicketyClick.dk>
$@since     $DATE_Y-$DATE_m-$DATE_dT$DATE_H:$DATE_M:$DATE_S / $USER
$@version   $DATE_Y-$DATE_m-$DATE_dT$DATE_H:$DATE_M:$DATE_S


```

## Unix Shell

## DOS Batch






## pl*

### Settings

.|.
---|---
Start	|/**
Line	| *  
End	| */
Prefix	|\



### Function

```
$@fn        $FUNCTION
$@brief     $(Brief description)

$@param [in] $PARAM $|$(Description for $PARAM)
$@return    $(Return description)

$@details   $(More details)

$@example   
$@todo      
$@bug       
$@warning   
$@see       
$@since     $DATE_Y-$DATE_m-$DATE_dT$DATE_H:$DATE_M:$DATE_S / $USER
```


### File 

```
$@file      $FILENAME
$@brief     $(Brief description)

$@details   $(More details)

@copyright  http://www.gnu.org/licenses/lgpl.txt LGPL version 3
@author     Erik Bachmann <ErikBachmann@ClicketyClick.dk>
$@since     $DATE_Y-$DATE_m-$DATE_dT$DATE_H:$DATE_M:$DATE_S / $USER
$@version   $DATE_Y-$DATE_m-$DATE_dT$DATE_H:$DATE_M:$DATE_S
```


## sh*

### Settings

.|.
---|---
Start	|#/**
Line	|# *  
End	|# */
Prefix	|#\


### Function

### File 





## CMD Batch

### Settings

.|.
---|---
Start	|::/**
Line	|:: *  
End	|:: */
Prefix	|\


### Function

```
$@fn        $FUNCTION
$@brief     $(Brief description)

$@param [in] $PARAM $|$(Description for $PARAM)
$@return    $(Return description)

$@details   $(More details)

$@example   
$@todo      
$@bug       
$@warning   
$@see       
$@since     $DATE_Y-$DATE_m-$DATE_dT$DATE_H:$DATE_M:$DATE_S / $USER
```

### File 

```

$@file      $FILENAME
$@brief     $(Brief description)

$@details   $(More details)

@copyright  http://www.gnu.org/licenses/lgpl.txt LGPL version 3
@author     Erik Bachmann <ErikBachmann@ClicketyClick.dk>
$@since     $DATE_Y-$DATE_m-$DATE_dT$DATE_H:$DATE_M:$DATE_S / $USER
$@version   $DATE_Y-$DATE_m-$DATE_dT$DATE_H:$DATE_M:$DATE_S
```

## DOS*

### Settings

.|.
---|---
Start	|
Line	|
End	|
Prefix	|


### Function

```
$@brief $(Brief description)

$@param [in] theParam $(Description)
$@return $(Return description)

$@details $(More details)
```

### File 


```
@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=$FILENAME
SET $DESCRIPTION=$(Brief description)
SET $AUTHOR=Erik Bachmann, ClicketyClick.dk [ErikBachmann@ClicketyClick.dk]
SET $SOURCE=%~f0
::@(#)NAME
::@(-)  The name of the command or function, followed by a one-line description of what it does.
::@(#)      %$NAME% -- %$DESCRIPTION%
::@(#) 
::@(#)SYNOPSIS
::@(-)  In the case of a command, a formal description of how to run it and what command line options it takes. 
::@(-)  For program functions, a list of the parameters the function takes and which header file contains its definition.
::@(-)  
::@(#)      %$NAME% [VAR]
::@(#) 
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Help page
::@(#) 
::@ (#) 
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#) 
::@(#) 
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
::@(#) 
::@(#) 
::@(#) 
::@ (#)EXIT STATUS
::@(-)  Exit status / errorlevel is 0 if OK, otherwise 1+.
::@ (#)
::@ (#)ENVIRONMENT
::@(-)  Variables affected
::@ (#)
::@ (#)
::@ (#)FILES, 
::@(-)  Files used, required, affected
::@ (#)
::@ (#)
::@ (#)BUGS / KNOWN PROBLEMS
::@(-)  If any known
::@ (#)
::@ (#)
::@(#)REQUIRES
::@(-)  Dependecies
::@(#)  _Debug.cmd      Setting up debug environment for batch scripts 
::@(#)  _GetOpt.cmd     Parse command line options and create environment vars
::@(#) _Prescript.cmd
::@(#) _PostScript.cmd
::@(#) 
::@ (#)SEE ALSO
::@(-)  A list of related commands or functions.
::@ (#)  
::@ (#)  
::@ (#)REFERENCE
::@(-)  References to inspiration, clips and other documentation
::@ (#)  Author:
::@ (#)  URL: 
::@ (#) 
::@(#)
::@(#)SOURCE
::@(-)  Where to find
```



