## 
#  @file      trim.t.sh
#  @brief     Testing trimming strings for whitespace
#  
#  @details   
#  
#  @copyright http://www.gnu.org/licenses/lgpl.txt LGPL version 3
#  @author    Erik Bachmann <ErikBachmann@ClicketyClick.dk>
#  @since     2022-12-13T08:00:12 / erba
#  @version   2022-12-13T10:44:15
#  
. "./testMore.sh"
. "./trim.sh"

#-----------------------------------------------------------------------

# Print header
diag `grep -E "^#\s*\@file" trim.t.sh | cut -d' ' -f4-`
diag `grep -E "^#\s*\@brief" trim.t.sh | cut -d' ' -f4-`

#echo -e `grep  -E "^#  " $0`
grep  -E "^#\s{2}" $0

diag

testMore_tests=4

mix="  123 456  "
got=`trim "$mix"`
is "${got}" "123 456" "Trim l+r\t[${got}]"


note "And the same again"
got=`trim "$mix"`
is "${got}" "123 456" "Trim l+r\t[${got}]"

diag "Special cases"
mix="  123 456  "
got=`ltrim "$mix"`
is "${got}" "123 456  " "Trim l\t[${got}]"

mix="  123 456  "
got=`rtrim "$mix"`
is "${got}" "  123 456" "Trim r\t[${got}]"

done_testing

#*** End of File ***
