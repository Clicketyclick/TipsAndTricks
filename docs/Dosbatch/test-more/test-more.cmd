::@ECHO OFF&SetLocal EnableDelayedExpansion
SetLocal disableDelayedExpansion
::**
:: *   @file       test-more.cmd
:: *   @brief      $(Brief description)
:: *   @details    $(More details)
:: *   @examples   call test-more.cmd ok 0 "Hello"
:: *   
:: *   @copyright  http://www.gnu.org/licenses/lgpl.txt LGPL version 3
:: *   @author     User Name <SomeOne@ClicketyClick.dk>
:: *   @since      2024-10-14T21:19:06 / Bruger
:: *   @version    2024-10-14T21:19:06
::**

:init
	::ECHO 0[%0] 1[%1] 2[%2]
	CALL :%*


GOTO :EOF


::**
:: *   @fn         ok 
:: *   @brief      I'm ok, you're not ok.
:: *   
:: *   @param [in]	ERRORLEVEL
:: *   @param [in]	test_name	description
:: *   @return     $(Return description)
:: *   
:: *   @details    The basic purpose of this module is to print out either "ok #" 
:: *       or "not ok #" depending on if a given test succeeded or failed. 
:: *       Everything else is just gravy.
:: *       All of the following print "ok" or "not ok" depending on if the 
:: *       test succeeded or failed. 
:: *       They all also return true or false, respectively.
:: *   
:: *   @example    call test-more.cmd ok 0 "Hello"
:: *           OK      Hello  [:ok]
:: *   
:: *   @todo       
:: *   @bug        
:: *   @warning    
:: *   
:: *   @see        https://
:: *   @since      2024-10-14T21:25:03
::**
:ok ($got eq $expected, $test_name);
SETLOCAL
    IF DEFINED DEBUG SET _=[%0]
    IF (!%~1)==(!0) (
        ECHO OK	%~2 %~3 %_%
    ) ELSE (
        ECHO Fail	%~2 %~3 %_%
    )
GOTO :EOF

::----------------------------------------------------------------------


::**
:: *   @fn         is  
:: *   @brief      Compare GOT to EXPECTED
:: *   
:: *   @param [in]	$got	$(description)
:: *   @param [in]	$expected	$(description)
:: *   @param [in]	$test_name	$(description)
:: *   @return     $(Return description)
:: *   
:: *   @details    Similar to ok(), is() and isnt() compare their two arguments with eq and ne respectively and use the result of that to determine if the test succeeded or failed.
:: *   
:: *   @example    
:: *   
:: *   @todo       
:: *   @bug        
:: *   @warning    
:: *   
:: *   @see        https://
:: *   @since      2024-10-14T21:28:36
::**
:is  ($got, $expected, $test_name);
SETLOCAL
    IF DEFINED DEBUG SET _=[%0]
    IF /i (!%~1)==(!%~2) (
        ECHO OK	%~3 %_%
    ) ELSE (
        ECHO Fail	%~3 %_%
    )
GOTO :EOF

::----------------------------------------------------------------------


::**
:: *   @fn         isnt 
:: *   @brief      Compare GOT != EXPECTED
:: *   
:: *   @param [in]	$got	$(description)
:: *   @param [in]	$expected	$(description)
:: *   @param [in]	$test_name	$(description)
:: *   @return     $(Return description)
:: *   
:: *   @details    Similar to ok(), is() and isnt() compare their two arguments 
:: *       with eq and ne respectively and use the result of that to determine 
:: *       if the test succeeded or failed.
:: *   
:: *   @example    
:: *   
:: *   @todo       
:: *   @bug        
:: *   @warning    
:: *   
:: *   @see        https://
:: *   @since      2024-10-14T21:29:22
::**
:isnt ($got, $expected, $test_name);
SETLOCAL
    IF DEFINED DEBUG SET _=[%0]
    IF /i NOT (!%~1)==(!%~2) (
        ECHO OK	%~3 %_%
    ) ELSE (
        ECHO Fail	%~3 %_%
    )
GOTO :EOF

::----------------------------------------------------------------------


::**
:: *   @fn         diag	msg
:: *   @brief      Print comment
:: *   
:: *   @param [in]	msg	$(description)
:: *   @return     $(Return description)
:: *   
:: *   @details    Rather than print STDERR "# here's what went wrong\n"
:: *   
:: *   @example    
:: *   
:: *   @todo       
:: *   @bug        
:: *   @warning    
:: *   
:: *   @see        https://
:: *   @since      2024-10-14T21:30:17
::**
:diag	msg
    ECHO::: %*
GOTO :EOF

::like  ($got, qr/expected/, $test_name);
::  .         Wildcard: any character.
::  *         Repeat: zero or more occurances of previous character or class.
::  ^         Line position: beginning of line.
::  $         Line position: end of line.
::  [class]   Character class: any one character in the set. [aB4] will match a or B or 4.
::  [^class]  Inverse class: any one character NOT in the set.
::  [x-y]     Range: any characters within the specified range.
::  \x        Escape: literal use of metacharacter x.
::  \<xyz     Word position: beginning of word.
::  xyz\>     Word position: end of word.
::  .*        Match any string of characters.


::**
:: *   @fn         like  
:: *   @brief      Pattern matching
:: *   
:: *   @param [in]	$got	$(description)
:: *   @param [in]	qr/expected/	$(description)
:: *   @param [in]	$test_name	$(description)
:: *   @return     $(Return description)
:: *   
:: *   @details    Similar to ok(), like() matches $got against the regex qr/expected/.
:: *   
:: *   @example    
:: *   
:: *   @todo       
:: *   @bug        
:: *   @warning    
:: *   
:: *   @see        https://
:: *   @since      2024-10-14T21:50:55
::**
:like  ($got, qr/expected/, $test_name);
SETLOCAL EnableDelayedExpansion
    :: Start of line flag
    SET "___="
    SET _=%~2
    
    IF DEFINED DEBUG SET __=[%0]
    :: Trim start of line
    IF "!^^"=="!%_:~0,2%" SET _=%_:~1%& SET "___=/\"
    
    IF DEFINED ___ ( :: If start of line
        ECHO:%~1|findstr /irc:"^%_%" > NUL
    ) ELSE ( :: Not start of line
        ECHO:%~1|findstr /irc:"%_%" > NUL
    )

    IF (!%ERRORLEVEL%)==(!0) (
        ECHO OK	[%~1] [%___%%_%]	%~3 %__%
    ) ELSE (
        ECHO Fail	[%~1] [%___%%_%]	%~3 %__%
    )
GOTO :EOF

::----------------------------------------------------------------------


::**
:: *   @fn         unlike 
:: *   @brief      Pattern NOT matching
:: *   
:: *   @param [in]	$got	$(description)
:: *   @param [in]	qr/expected/	$(description)
:: *   @param [in]	$test_name	$(description)
:: *   @return     $(Return description)
:: *   
:: *   @details    Works exactly as like(), only it checks if $got does not match the given pattern.
:: *   
:: *   @example    
:: *   
:: *   @todo       
:: *   @bug        
:: *   @warning    
:: *   
:: *   @see        https://
:: *   @since      2024-10-14T21:31:11
::**
:unlike ($got, qr/expected/, $test_name);
SETLOCAL EnableDelayedExpansion
    :: Start of line flag
    SET "___="
    SET _=%~2
    
    IF DEFINED DEBUG SET __=[%0]
    :: Trim start of line
    IF "!^^"=="!%_:~0,2%" SET _=%_:~1%& SET "___=/\"
    
    IF DEFINED ___ ( :: If start of line
        ECHO:%~1|findstr /virc:"^%_%" > NUL
    ) ELSE ( :: Not start of line
        ECHO:%~1|findstr /virc:"%_%" > NUL
    )
    ::ECHO %~1| findstr /virc:"%~2" > NUL
    
    ::CALL :OK %ERRORLEVEL% "[%~1] [%_%]"
    IF (!%ERRORLEVEL%)==(!0) (
        ECHO OK	[%~1] [%_%]	%~3 %__%
    ) ELSE (
        ECHO Fail	[%~1] [%_%]	%~3 %__%
    )

GOTO :EOF

::*** EOF **************************************************************
