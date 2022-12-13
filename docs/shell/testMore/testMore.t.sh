## 
#  @file      testMore.t.sh
#  @brief     Test suite for testMore.sh
#  
#  @details   
#  
#  @copyright http://www.gnu.org/licenses/lgpl.txt LGPL version 3
#  @author    Erik Bachmann <ErikBachmann@ClicketyClick.dk>
#  @since     2022-12-13T08:00:12 / erba
#  @version   2022-12-13T10:44:15
#  

#-----------------------------------------------------------------------

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

#*** End of File ***
