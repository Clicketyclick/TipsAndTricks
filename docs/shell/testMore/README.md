> yet another framework for writing test scripts

Yep - but for Linux shell scripts

Using simple test like:
- ok - expression is true
- is - two strings a equal
- isnt - two strings a NOT equal
- like - string matches a regex pattern
- unlike - string does NOT match regex pattern

This module is simply included

```shell
. "./testMore.sh"
```
And ready to use

The process is:
1. Include the module using `. "./testMore.sh"`
2. `dump_header`
3. Set plan - `testMore_tests=`
4. Run the tests
5. Terminate with `done_testing`


### Example: testMore.t.sh
```shell
. "./testMore.sh"
. "./trim.sh"

dump_header

diag "NOTE! Test 1 + 5 are supposed to fail"
testMore_tests=8
note
note "Testing OK"
ok  0 "This is NOT OK"
ok  1 "This is OK"

diag
diag "Testing IS"
mix="  123 456  "
got=`trim "$mix"`
is "${got}" "123 456" "Trim l+r\t[${got}]"

diag
diag "This should fail:"
#mix="  123 456  "
got=`trim "$mix"`
isnt "${got}" "  123 456  " "Trim l+r\t[${got}]"

diag
note "Special cases"
#mix="  123 456  "
got=`ltrim "$mix"`
is "${got}" "123 456  " "Trim l\t[${got}]"

#mix="  123 456  "
got=`rtrim "$mix"`

diag "Got to fail: Wrong number of arguments"
ok "${got}" "  123 456" "Got to fail: Wrong number of arguments"

diag "Like it - or not"
like "abcdefg" "bcd" "bcd in abcdefg"
unlike "abcdefg" "bfd" "bfd NOT in abcdefg"

#dump_stack

done_testing
```
