# test-more framework

https://perldoc.perl.org/Test::More

## Name
Test-More - yet another framework for writing test scripts

## Synopsis
```
call test-more DIAG OK - I'm ok, you're not ok
call test-more ok 0 "{ok}	0=0"
call test-more ok 1 "{fail}	0=1"

call test-more DIAG is - Compare GOT == EXPECTED
call test-more IS "a" "a" "{ok}	A=A"
call test-more IS "a" "b" "{fail}	A=B"

call test-more DIAG isnt - Compare GOT != EXPECTED
call test-more ISNT "a" "a" "{fail}	A/=A"
call test-more ISNT "a" "b" "{ok}	A/=B"

call test-more DIAG LIKE - Pattern matching
call test-more like "A Rolling Stone" "rolling"			"	{ok}	match"
call test-more like "A Rolling Stone" "rollingx"		"	{fail}	no match x"
call test-more like "A Rolling Stone" "a .*stone"		"	{ok}	match any"
call test-more like "A Rolling Stone" "A Rol*ing Stone"		"{ok}	Repeating 'l'"
call test-more like "A Rolling Stone" "^A Rol*ing Stone"	"{ok}	From beginning {ok}"
call test-more like "A Rolling Stone" "^Rol*ing Stone"		"{fail}	Failing beginning"

call test-more DIAG UNLIKE - Pattern NOT matching
call test-more unlike "A Rolling Stone" "^A Rol*ing Stone"	"{fail}	Actual match"
call test-more unlike "A Rolling Stone" "^Rol*ing Stone"	"{ok}	Failing match"
```
