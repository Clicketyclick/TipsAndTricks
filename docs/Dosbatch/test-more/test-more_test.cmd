@ECHO OFF&SetLocal EnableDelayedExpansion
::**
:: *   @file       test-more_test.cmd
:: *   @brief      Tests for test-more library
:: *   @details    Testing: OK,IS, ISNT, LIKE and UNLIKE
:: *   
:: *   @copyright  http://www.gnu.org/licenses/lgpl.txt LGPL version 3
:: *   @author     Erik Bachmann <Erik@ClicketyClick.dk>
:: *   @since      2024-10-14T22:23:13 / Erik Bachmann
:: *   @version    2024-10-14T22:57:10
::**
:: 

call test-more DIAG OK - I'm ok, you're not ok
	call test-more ok 	0				"{ok}	0=0"
	call test-more ok 	1				"{fail}	0=1"

call test-more DIAG is - Compare GOT == EXPECTED
	call test-more IS	"a" "a"				"{ok}	A=A"
	call test-more IS	"a" "b"				"{fail}	A=B"

call test-more DIAG isnt - Compare GOT != EXPECTED
	call test-more ISNT	"a" "a" 			"{fail}	A/=A"
	call test-more ISNT	"a" "b" 			"{ok}	A/=B"

SET "_STRING=A Rolling Stone"
call test-more DIAG LIKE - Pattern matching
	call test-more like	"%_STRING%" "rolling"	"	{ok}	match"
	call test-more like	"%_STRING%" "rollingx"	"	{fail}	no match x"
	call test-more like	"%_STRING%" "a .*stone"	"	{ok}	match any"
	call test-more like	"%_STRING%" "A Rol*ing Stone"	"{ok}	Repeating 'l'"
	call test-more like	"%_STRING%" "^A Rol*ing Stone"	"{ok}	From beginning {ok}"
	call test-more like	"%_STRING%" "^Rol*ing Stone"	"{fail}	Failing beginning"

call test-more DIAG UNLIKE - Pattern NOT matching
	call test-more unlike	"%_STRING%" "^A Rol*ing Stone"	"{fail}	Actual match"
	call test-more unlike	"%_STRING%" "^Rol*ing Stone"	"{ok}	Failing match"

GOTO :EOF
