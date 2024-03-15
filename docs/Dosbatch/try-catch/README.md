## Try-catch




Windows batch scripting certainly does not have any formal exception handling - hardly surprising considering how primitive the language is. Never in my wildest dreams did I ever think effective exception handling could be hacked up.

But then some amazing discoveries were made on a Russian site concerning the behavior of an erroneous GOTO statement (I have no idea what is said, I can't read Russian). An English summary was posted at DosTips, and the behavior was further investigated.

It turns out that (GOTO) 2>NUL behaves almost identically to EXIT /B, except concatenated commands within an already parsed block of code are still executed after the effective return, within the context of the CALLer!

Here is a short example that demonstrates most of the salient points.

```batch
@echo off
setlocal enableDelayedExpansion
set "var=Parent Value"
(
  call :test
  echo This and the following line are not executed
  exit /b
)
:break
echo How did I get here^^!^^!^^!^^!
exit /b

:test
setlocal disableDelayedExpansion
set "var=Child Value"
(goto) 2>nul & echo var=!var! & goto :break
echo This line is not executed

:break
echo This line is not executed
```
-- OUTPUT --

```console
var=Parent Value
How did I get here!!!!
```
This feature is totally unexpected, and incredibly powerful and useful. It has been used to:

Create PrintHere.bat - an emulation of the 'nix here document feature
Create a RETURN.BAT utility that any batch "function" can conveniently CALL to return any value across the ENDLOCAL barrier, with virtually no limitations. The code is a fleshed out version of jeb's original idea.
Now I can also add exception handling to the list :-)

The technique relies on a batch utility called EXCEPTION.BAT to define environment variable "macros" that are used to specify TRY/CATCH blocks, as well as to throw exceptions.

Before a TRY/CATCH block can be implemented, the macros must be defined using:

call exception init
Then TRY/CATCH blocks are defined with the following syntax:

```batch
:calledRoutine
setlocal
%@Try%
  REM normal code goes here
%@EndTry%
:@Catch
  REM Exception handling code goes here
:@EndCatch
```

Exceptions can be thrown at any time via:

```batch
call exception throw  errorNumber  "messageString"  "locationString"
```

When an exception is thrown, it pops the CALL stack iteratively using (GOTO) 2>NUL until it finds an active TRY/CATCH, whereupon it branches to the CATCH block and executes that code. A series of exception attribute variables are available to the CATCH block:

- exception.Code - The numeric exception code
- exception.Msg - The exception message string
- exception.Loc - The string describing the location where the exception was thrown
- exception.Stack - A string that traces the call stack from the CATCH block (or command line if not caught), all the way to the exception origin.

If the exception is fully handled, then the exception should be cleared via call exception clear, and the script carries on normally. If the exception is not fully handled, then a new exception can be thrown with a brand new exception.Stack, or the old stack can be preserved with

```batch
call exception rethrow  errorNumber  "messageString"  "locationString"
```

If an exception is not handled, then an "unhandled exception" message is printed, including the four exception attributes, all batch processing is terminated, and control is returned to the command line context.

Here is the code that makes all this possible - full documentation is embedded within the script and available from the command line via exception help or exception /?.

EXCEPTION.BAT
```batch
::EXCEPTION.BAT Version 1.4
::
:: Provides exception handling for Windows batch scripts.
::
:: Designed and written by Dave Benham, with important contributions from
:: DosTips users jeb and siberia-man
::
:: Full documentation is at the bottom of this script
::
:: History:
::   v1.4 2016-08-16  Improved detection of command line delayed expansion
::                    using an original idea by jeb
::   v1.3 2015-12-12  Added paged help option via MORE
::   v1.2 2015-07-16  Use COMSPEC instead of OS to detect delayed expansion
::   v1.1 2015-07-03  Preserve ! in exception attributes when delayed expansion enabled
::   v1.0 2015-06-26  Initial versioned release with embedded documentation
::
@echo off
if "%~1" equ "/??" goto pagedHelp
if "%~1" equ "/?" goto help
if "%~1" equ "" goto help
shift /1 & goto %1


:throw  errCode  errMsg  errLoc
set "exception.Stack="
:: Fall through to :rethrow


:rethrow  errCode  errMsg  errLoc
setlocal disableDelayedExpansion
if not defined exception.Restart set "exception.Stack=[%~1:%~2] %exception.Stack%"
for /f "delims=" %%1 in ("%~1") do for /f "delims=" %%2 in ("%~2") do for /f "delims=" %%3 in ("%~3") do (
  setlocal enableDelayedExpansion
  for /l %%# in (1 1 10) do for /f "delims=" %%S in (" !exception.Stack!") do (
    (goto) 2>NUL
    setlocal enableDelayedExpansion
    if "!!" equ "" (
      endlocal
      setlocal disableDelayedExpansion
      call set "funcName=%%~0"
      call set "batName=%%~f0"
      if defined exception.Restart (set "exception.Restart=") else call set "exception.Stack=%%funcName%%%%S"
      setlocal EnableDelayedExpansion
      if !exception.Try! == !batName!:!funcName! (
        endlocal
        endlocal
        set "exception.Code=%%1"
        if "!!" equ "" (
          call "%~f0" setDelayed
        ) else (
          set "exception.Msg=%%2"
          set "exception.Loc=%%3"
          set "exception.Stack=%%S"
        )
        set "exception.Try="
        (CALL )
        goto :@Catch
      )
    ) else (
      for %%V in (Code Msg Loc Stack Try Restart) do set "exception.%%V="
      if "^!^" equ "^!" (
        call "%~f0" showDelayed
      ) else (
        echo(
        echo Unhandled batch exception:
        echo   Code = %%1
        echo   Msg  = %%2
        echo   Loc  = %%3
        echo   Stack=%%S
      )
      echo on
      call "%~f0" Kill
    )>&2
  )
  set exception.Restart=1
  setlocal disableDelayedExpansion
  call "%~f0" rethrow %1 %2 %3
)
:: Never reaches here


:init
set "@Try=call set exception.Try=%%~f0:%%~0"
set "@EndTry=set "exception.Try=" & goto :@endCatch"
:: Fall through to :clear


:clear
for %%V in (Code Msg Loc Stack Restart Try) do set "exception.%%V="
exit /b


:Kill - Cease all processing, ignoring any remaining cached commands
setlocal disableDelayedExpansion
if not exist "%temp%\Kill.Yes" call :buildYes
call :CtrlC <"%temp%\Kill.Yes" 1>nul 2>&1
:CtrlC
@cmd /c exit -1073741510

:buildYes - Establish a Yes file for the language used by the OS
pushd "%temp%"
set "yes="
copy nul Kill.Yes >nul
for /f "delims=(/ tokens=2" %%Y in (
  '"copy /-y nul Kill.Yes <nul"'
) do if not defined yes set "yes=%%Y"
echo %yes%>Kill.Yes
popd
exit /b


:setDelayed
setLocal disableDelayedExpansion
for %%. in (.) do (
  set "v2=%%2"
  set "v3=%%3"
  set "vS=%%S"
)
(
  endlocal
  set "exception.Msg=%v2:!=^!%"
  set "exception.Loc=%v3:!=^!%"
  set "exception.Stack=%vS:!=^!%"
)
exit /b


:showDelayed -
setLocal disableDelayedExpansion
for %%. in (.) do (
  set "v2=%%2"
  set "v3=%%3"
  set "vS=%%S"
)
for /f "delims=" %%2 in ("%v2:!=^!%") do for /f "delims=" %%3 in ("%v3:!=^!%") do for /f "delims=" %%S in ("%vS:!=^!%") do (
  endlocal
  echo(
  echo Unhandled batch exception:
  echo   Code = %%1
  echo   Msg  = %%2
  echo   Loc  = %%3
  echo   Stack=%%S
)
exit /b


:-?
:help
setlocal disableDelayedExpansion
for /f "delims=:" %%N in ('findstr /rbn ":::DOCUMENTATION:::" "%~f0"') do set "skip=%%N"
for /f "skip=%skip% tokens=1* delims=:" %%A in ('findstr /n "^" "%~f0"') do echo(%%B
exit /b


:-??
:pagedHelp
setlocal disableDelayedExpansion
for /f "delims=:" %%N in ('findstr /rbn ":::DOCUMENTATION:::" "%~f0"') do set "skip=%%N"
((for /f "skip=%skip% tokens=1* delims=:" %%A in ('findstr /n "^" "%~f0"') do @echo(%%B)|more /e) 2>nul
exit /b


:-v
:/v
:version
echo(
for /f "delims=:" %%A in ('findstr "^::EXCEPTION.BAT" "%~f0"') do echo %%A
exit /b


:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::DOCUMENTATION:::

EXCEPTION.BAT is a pure batch script utility that provides robust exception
handling within batch scripts. It enables code to be placed in TRY/CATCH blocks.
If no exception is thrown, then only code within the TRY block is executed.
If an exception is thrown, the batch CALL stack is popped repeatedly until it
reaches an active TRY block, at which point control is passed to the associated
CATCH block and normal processing resumes from that point. Code within a CATCH
block is ignored unless an exception is thrown.

An exception may be caught in a different script from where it was thrown.

If no active TRY is found after throwing an exception, then an unhandled
exception message is printed to stderr, all processing is terminated within the
current CMD shell, and control is returned to the shell command line.

TRY blocks are specified using macros. Obviously the macros must be defined
before they can be used. The TRY macros are defined using the following CALL

    call exception init

Besides defining @Try and @EndTry, the init routine also explicitly clears any
residual exception that may have been left by prior processing.

A TRY/CATCH block is structured as follows:

    %@Try%
      REM any normal code goes here
    %@EndTry%
    :@Catch
      REM exception handling code goes here
    :@EndCatch

- Every TRY must have an associated CATCH.

- TRY/CATCH blocks cannot be nested.

- Any script or :labeled routine that uses TRY/CATCH must have at least one
  SETLOCAL prior to the appearance of the first TRY.

- TRY/CATCH blocks use labels, so they should not be placed within parentheses.
  It can be done, but the parentheses block is broken when control is passed to
  the :@Catch or :@EndCatch label, and the code becomes difficult to interpret
  and maintain.

- Any valid code can be used within a TRY or CATCH block, including CALL, GOTO,
  :labels, and balanced parentheses. However, GOTO cannot be used to leave a
  TRY block. GOTO can only be used within a TRY block if the label appears
  within the same TRY block.

- GOTO must never transfer control from outside TRY/CATCH to within a TRY or
  CATCH block.

- CALL should not be used to call a label within a TRY or CATCH block.

- CALLed routines containing TRY/CATCH must have labels that are unique within
  the script. This is generally good batch programming practice anyway.
  It is OK for different scripts to share :label names.

- If a script or routine recursively CALLs itself and contains TRY/CATCH, then
  it must not throw an exception until after execution of the first %@Try%

Exceptions are thrown by using

    call exception throw  Code  Message  Location

where

    Code = The numeric code value for the exception.

    Message = A description of the exception.

    Location = A string that helps identify where the exception occurred.
               Any value may be used. A good generic value is "%~f0[%~0]",
               which expands to the full path of the currently executing
               script, followed by the currently executing routine name
               within square brackets.

The Message and Location values must be quoted if they contain spaces or poison
characters like & | < >. The values must not contain additional internal quotes,
and they must not contain a caret ^.

The following variables will be defined for use by the CATCH block:

  exception.Code  = the Code value
  exception.Msg   = the Message value
  exception.Loc   = the Location value
  exception.Stack = traces the call stack from the CATCH block (or command line
                    if not caught), all the way to the exception.

If the exception is not caught, then all four values are printed as part of the
"unhandled exception" message, and the exception variables are not defined.

A CATCH block should always do ONE of the following at the end:

- If the exception has been handled and processing can continue, then clear the
  exception definition by using

    call exception clear

  Clear should never be used within a Try block.

- If the exception has not been fully handled, then a new exception should be
  thrown which can be caught by a higher level CATCH. You can throw a new
  exception using the normal THROW, which will clear exception.Stack and any
  higher CATCH will have no awareness of the original exception.

  Alternatively, you may rethrow an exception and preserve the exeption stack
  all the way to the original exception:

    call exception rethrow  Code  Message  Location

  It is your choice as to whether you want to pass the original Code and/or
  Message and/or Location. Either way, the stack will preserve all exceptions
  if rethrow is used.

  Rethrow should only be used within a CATCH block.


One last restriction - the full path to EXCEPTION.BAT must not include ! or ^.


This documentation can be accessed via the following commands

    constant stream:   exception /?   OR  exception help
    paged via MORE:    exception /??  OR  exception pagedHelp

The version of this utility can be accessed via

    exception /v  OR  exception version


EXCEPTION.BAT was designed and written by Dave Benham, with important
contributions from DosTips users jeb and siberia-man.

Development history can be traced at:
  http://www.dostips.com/forum/viewtopic.php?f=3&t=6497
```

Below is script to test the capabilities of EXCEPTION.BAT. The script recursively calls itself 7 times. Each iteration has two CALLs, one to a :label that demonstrates normal exception propagation, and the other to a script that demonstrates exception propagation across script CALLs.

While returning from a recursive call, it throws an exception if the iteration count is a multiple of 3 (iterations 3 and 6).

Each CALL has its own exception handler that normally reports the exception and then rethrows a modified exception. But if the iteration count is 5, then the exception is handled and normal processing resumes.

```batch
@echo off

:: Main
setlocal enableDelayedExpansion
if not defined @Try call exception init

set /a cnt+=1
echo Main Iteration %cnt% - Calling :Sub
%@Try%
(
  call :Sub
  call echo Main Iteration %cnt% - :Sub returned %%errorlevel%%
)
%@EndTry%
:@Catch
  setlocal enableDelayedExpansion
  echo(
  echo Main Iteration %cnt% - Exception detected:
  echo   Code     = !exception.code!
  echo   Message  = !exception.msg!
  echo   Location = !exception.loc!
  echo Rethrowing modified exception
  echo(
  endlocal
  call exception rethrow -%cnt% "Main Exception^!" "%~f0<%~0>"
:@EndCatch
echo Main Iteration %cnt% - Exit
exit /b %cnt%


:Sub
setlocal
echo :Sub Iteration %cnt% - Start
%@Try%
  if %cnt% lss 7 (
    echo :Sub Iteration %cnt% - Calling "%~f0"
    call "%~f0"
    %= Show any non-exception return code (demonstrate ERRORLEVEL is preserved if no exception) =%
    call echo :Sub Iteration %cnt% - testException returned %%errorlevel%%
  )
  %= Throw an exception if the iteration count is a multiple of 3 =%
  set /a "1/(cnt%%3)" 2>nul || (
    echo Throwing exception
    call exception throw -%cnt% "Divide by 0 exception^!" "%~f0<%~0>"
  )
%@EndTry%
:@Catch
  setlocal enableDelayedExpansion
  echo(
  echo :Sub Iteration %cnt% - Exception detected:
  echo   Code     = !exception.code!
  echo   Message  = !exception.msg!
  echo   Location = !exception.loc!
  endlocal
  %= Handle the exception if iteration count is a multiple of 5, else rethrow it with new properties =%
  set /a "1/(cnt%%5)" 2>nul && (
    echo Rethrowing modified exception
    echo(
    call exception rethrow -%cnt% ":Sub Exception^!" "%~f0<%~0>"
  ) || (
    call exception clear
    echo Exception handled
    echo(
  )
:@EndCatch
echo :Sub Iteration %cnt% - Exit
exit /b %cnt%
```batch

-- OUTPUT --

```console
Main Iteration 1 - Calling :Sub
:Sub Iteration 1 - Start
:Sub Iteration 1 - Calling "C:\test\testException.bat"
Main Iteration 2 - Calling :Sub
:Sub Iteration 2 - Start
:Sub Iteration 2 - Calling "C:\test\testException.bat"
Main Iteration 3 - Calling :Sub
:Sub Iteration 3 - Start
:Sub Iteration 3 - Calling "C:\test\testException.bat"
Main Iteration 4 - Calling :Sub
:Sub Iteration 4 - Start
:Sub Iteration 4 - Calling "C:\test\testException.bat"
Main Iteration 5 - Calling :Sub
:Sub Iteration 5 - Start
:Sub Iteration 5 - Calling "C:\test\testException.bat"
Main Iteration 6 - Calling :Sub
:Sub Iteration 6 - Start
:Sub Iteration 6 - Calling "C:\test\testException.bat"
Main Iteration 7 - Calling :Sub
:Sub Iteration 7 - Start
:Sub Iteration 7 - Exit
Main Iteration 7 - :Sub returned 7
Main Iteration 7 - Exit
:Sub Iteration 6 - testException returned 7
Throwing exception

:Sub Iteration 6 - Exception detected:
  Code     = -6
  Message  = Divide by 0 exception!
  Location = C:\test\testException.bat<:Sub>
Rethrowing modified exception


Main Iteration 6 - Exception detected:
  Code     = -6
  Message  = :Sub Exception!
  Location = C:\test\testException.bat<:Sub>
Rethrowing modified exception


:Sub Iteration 5 - Exception detected:
  Code     = -6
  Message  = Main Exception!
  Location = C:\test\testException.bat<C:\test\testException.bat>
Exception handled

:Sub Iteration 5 - Exit
Main Iteration 5 - :Sub returned 5
Main Iteration 5 - Exit
:Sub Iteration 4 - testException returned 5
:Sub Iteration 4 - Exit
Main Iteration 4 - :Sub returned 4
Main Iteration 4 - Exit
:Sub Iteration 3 - testException returned 4
Throwing exception

:Sub Iteration 3 - Exception detected:
  Code     = -3
  Message  = Divide by 0 exception!
  Location = C:\test\testException.bat<:Sub>
Rethrowing modified exception


Main Iteration 3 - Exception detected:
  Code     = -3
  Message  = :Sub Exception!
  Location = C:\test\testException.bat<:Sub>
Rethrowing modified exception


:Sub Iteration 2 - Exception detected:
  Code     = -3
  Message  = Main Exception!
  Location = C:\test\testException.bat<C:\test\testException.bat>
Rethrowing modified exception


Main Iteration 2 - Exception detected:
  Code     = -2
  Message  = :Sub Exception!
  Location = C:\test\testException.bat<:Sub>
Rethrowing modified exception


:Sub Iteration 1 - Exception detected:
  Code     = -2
  Message  = Main Exception!
  Location = C:\test\testException.bat<C:\test\testException.bat>
Rethrowing modified exception


Main Iteration 1 - Exception detected:
  Code     = -1
  Message  = :Sub Exception!
  Location = C:\test\testException.bat<:Sub>
Rethrowing modified exception


Unhandled batch exception:
  Code = -1
  Msg  = Main Exception!
  Loc  = C:\test\testException.bat<testException>
  Stack= testException [-1:Main Exception!]  :Sub [-1::Sub Exception!]  C:\test\testException.bat [-2:Main Exception!]  :Sub [-2::Sub Exception!]  C:\test\testException.bat [-3:Main Exception!]  :Sub [-3::Sub Exception!]  [-3:Divide by 0 exception!]
```

Finally, here are a series of trivial scripts that show how exceptions can be used effectively even when intermediate scripts know nothing about them!

Start off with a simple division script utility that divides two numbers and prints the result:

divide.bat

```batch
:: divide.bat  numerator  divisor
@echo off
setlocal
set /a result=%1 / %2 2>nul || call exception throw -100 "Division exception" "divide.bat"
echo %1 / %2 = %result%
exit /b
Note how the script throws an exception if it detects an error, but it does nothing to catch the exception.

Now I'll write a divide test harness that is totally naive about batch exceptions.

testDivide.bat

@echo off
for /l %%N in (4 -1 0) do call divide 12 %%N
echo Finished successfully!
--OUTPUT--

C:\test>testDivide
12 / 4 = 3
12 / 3 = 4
12 / 2 = 6
12 / 1 = 12

Unhandled batch exception:
  Code = -100
  Msg  = Division exception
  Loc  = divide.bat
  Stack= testDivide divide [-100:Division exception]
Note how the final ECHO never executes because the exception raised by divide.bat was not handled.

Finally I'll write a master script that calls the naive testDivide and properly handles the exception:

master.bat

@echo off
setlocal
call exception init

%@Try%
  call testDivide
%@EndTry%
:@Catch
  echo %exception.Msg% detected and handled
  call exception clear
:@EndCatch
echo Finished Successfully!

```batch

-- OUTPUT --

```console
C:\test>master
12 / 4 = 3
12 / 3 = 4
12 / 2 = 6
12 / 1 = 12
Division exception detected and handled
Finished Successfully!
```

The master script was able to successfully catch an exception raised by divide.bat, even though it had to pass through testDivide.bat, which knows nothing about exceptions. Very cool :-)

Now this is certainly not a panacea for all things related to error handling:

There are a number of syntactical and code layout limitations that are fully described in the built in documentation. But nothing too egregious.

There is no way to automatically treat all errors as an exceptions. All exceptions must be explicitly thrown by code. This is probably a good thing, given that error reporting is handled by convention - there are no strict rules. Some programs do not follow the convention. For example, HELP ValidCommand returns ERRORLEVEL 1, which by convention implies an error, while HELP InvalidCommand returns ERRORLEVEL 0, which implies success.

This batch exception technique cannot catch and handle fatal run-time errors. For example GOTO :NonExistentLabel will still immediately terminate all batch processing, without any opportunity to catch the error.

You can follow the development of EXCEPTION.BAT at http://www.dostips.com/forum/viewtopic.php?f=3&t=6497. Any future developments will be posted there. I likely will not update this StackOverflow post.


