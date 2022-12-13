## 
#  @file      testMore.sh
#  @brief     yet another framework for writing test scripts
#  
#  @details   
#
#
#  @see       https://metacpan.org/pod/Test::More
#  @see       https://stackoverflow.com/a/22617858 #        echo -e "# `caller 0`";
#  @see       https://stackoverflow.com/a/21035146 #    inc: ((testMore_count++));
#  
#  @copyright http://www.gnu.org/licenses/lgpl.txt LGPL version 3
#  @author    Erik Bachmann <ErikBachmann@ClicketyClick.dk>
#  @since     2022-12-13T08:00:12 / erba
#  @version   2022-12-13T20:50:39 / erba
#

#-----------------------------------------------------------------------

testMore_count=0
testMore_tests=0
testMore_success=0
testMore_failures=0
testMore_failing_tests=

#-----------------------------------------------------------------------

# Rather than print STDERR "# here's what went wrong\n"
## 
#  @fn        diag()
#  @brief     Prints a diagnostic message which is guaranteed not to interfere with test output.
#  
#  @param [in] message 	Message to print
#  @return    FALSE
#  
#  @details   $(More details)
#  
#  @example   diag "@diagnostic_message";
#  
#  @todo      
#  @bug       
#  @warning   
#  
#  @see       https://metacpan.org/pod/Test::More#Diagnostics
#  @since     2022-12-13T14:43:44 / erba
#  
diag()
{
    echo -e "# $*" 1>&2
    return 1
}   # diag()

#-----------------------------------------------------------------------

## 
#  @fn        note()
#  @brief     Like diag(), except the message will not be seen when the test is run in a harness.
#  
#  @param [in] message 	Message to print
#  @return    FALSE
#  
#  @details   $(More details)
#  
#  @example   note "Note to print;
#  
#  @todo      
#  @bug       
#  @warning   
#  
#  @see       https://metacpan.org/pod/Test::More#Diagnostics
#  @since     2022-12-13T14:43:44 / erba
#  
note()
{
    echo -e "# $*"
    return 1
}   # note()

#-----------------------------------------------------------------------

## 
#  @fn        done_testing()
#  @brief     Print status after testing
#  
#  @return    VOID
#  
#  @details   $(More details)
#  
#  @example   
#  
#  @todo      
#  @bug       
#  @warning   
#  
#  @see       https://metacpan.org/pod/Test::More#done_testing
#  @since     2022-12-13T14:43:44 / erba
#  
done_testing()
{
    if [[ "${testMore_tests}" == "${testMore_count}" ]]; then
        diag "Ran all ${testMore_tests} tests as planed"
    else
        diag "Ran ${testMore_count} tests. ${testMore_tests} planed"
    fi
    if [[ "${testMore_success}" == "${testMore_count}" ]]; then
        diag "All tests ran successfull"
    else
        diag "ok:    ${testMore_success}"
        diag "fail:  ${testMore_failures}"
        #diag "\ttests:\t${testMore_failing_tests}"
        # https://stackoverflow.com/a/13210909 replace the first occurrence of a pattern with a given string, use ${parameter/pattern/string}
        testMore_failing_tests=${testMore_failing_tests/ /}
        # https://stackoverflow.com/a/13210909 replace all occurrences, use ${parameter//pattern/string}
        diag "tests: ${testMore_failing_tests// /, }" 
    fi
}   # done_testing()

#-----------------------------------------------------------------------

## 
#  @fn        ok()
#  @brief     Check if expression is true
#  
#  @param [in] got      Expression to validate
#  @param [in] comment 	Comment to print
#  @return    $(Return description)
#  
#  @details   This simply evaluates any expression ($got eq $expected is just a simple example)
#   and uses that to determine if the test succeeded or failed. 
#   A true expression passes, a false one fails. Very simple.
#  
#  @example   
#  
#  @todo      
#  @bug       
#  @warning   
#  
#  @see       https://metacpan.org/pod/Test::More#ok
#  @since     2022-12-13T14:43:44 / erba
#  
ok()
{
    ((testMore_count++));   #https://stackoverflow.com/a/21035146

    local got="$1"
    local comment="$2"
    local dummy=${3:-___}
    
    if [[ "___" != ${dummy} ]]; then
        ((testMore_failures++))
        testMore_failing_tests="${testMore_failing_tests} ${testMore_count}"
        echo -e "not ok  [${testMore_count}] - *** TOO MANY ARGUMENTS ***";
        diag `caller 0`
        diag
        return 1
    else
        #if [[ 0 != ${got} ]]; then
        if [[ 0 != "${got}" ]] ; then
            ((testMore_success++))
            echo -e "ok      [${testMore_count}] - ${comment}";
            return 0
        else
            ((testMore_failures++))
            testMore_failing_tests="${testMore_failing_tests} ${testMore_count}"
            echo -e "not ok  [${testMore_count}] - ${comment}";
            diag "`caller 0`";
            diag "Got      [${got}]";
            #echo -e "# Expected [${expected}]";
            return 1
        fi
        return 1
    fi
    return 1
}   # ok()

#-----------------------------------------------------------------------

## 
#  @fn       is()
#  @brief    Compare their two arguments
#  
#  @param [in] got      Result to test
#  @param [in] expected Reference value
#  @param [in] comment  Comment to add to result
#  @return      0 on success else 1
#  
#  @details   Similar to ok(), is() and isnt() compare their two arguments 
#       with `eq` and `ne` respectively and use the result of that to determine 
#       if the test succeeded or failed
#  
#  @example   is the_ultimate_answer() "42" "Meaning of Life";
#  
#  @todo      
#  @bug       
#  @warning   
#  
#  @see       https://metacpan.org/pod/Test::More#is
#  @since     2022-12-13T14:43:44 / erba
#  
is()
{
    ((testMore_count++));

    local got="$1"
    local expected="$2"
    local comment="$3"
    local dummy=${4:-___}
    
    if [[ "___" != ${dummy} ]]; then
        ((testMore_failures++))
        testMore_failing_tests="${testMore_failing_tests} ${testMore_count}"
        echo -e "not ok  [${testMore_count}] - *** TOO MANY ARGUMENTS ***";
        diag `caller 0`
        diag;
        return 1
    else
        if [[ "${got}" == "${expected}" ]]; then
            ((testMore_success++))
            echo -e "ok      [${testMore_count}] - ${comment}";
        else
            ((testMore_failures++))
            testMore_failing_tests="${testMore_failing_tests} ${testMore_count}"
            echo -e "not ok  [${testMore_count}] - ${comment}";
            diag `caller 0`;
            diag "Got      [${got}]";
            diag "Expected [${expected}]";
        fi
    fi
}   # is()

#-----------------------------------------------------------------------

## 
#  @fn       isnt()
#  @brief    Compare their two arguments with negative result
#  
#  @param [in] got      Result to test
#  @param [in] expected Reference value
#  @param [in] comment  Comment to add to result
#  @return      0 on success else 1
#  
#  @details   Similar to ok(), is() and isnt() compare their two arguments 
#       with `eq` and `ne` respectively and use the result of that to determine 
#       if the test succeeded or failed
#  
#  @example   is the_ultimate_answer() "42" "Meaning of Life";
#  
#  @todo      
#  @bug       
#  @warning   
#  
#  @see       https://metacpan.org/pod/Test::More#is
#  @since     2022-12-13T14:43:44 / erba
#  
isnt()
{
    ((testMore_count++));

    local got="$1"
    local expected="$2"
    local comment="$3"
    local dummy=${4:-___}
    
    if [[ "___" != ${dummy} ]]; then
        ((testMore_failures++))
        testMore_failing_tests="${testMore_failing_tests} ${testMore_count}"
        echo -e "not ok  [${testMore_count}] - *** TOO MANY ARGUMENTS ***";
        diag `caller 0`
        diag;
        return 1
    else
        if [[ "${got}" != "${expected}" ]]; then
            ((testMore_success++))
            echo -e "ok      [${testMore_count}] - ${comment}";
        else
            ((testMore_failures++))
            testMore_failing_tests="${testMore_failing_tests} ${testMore_count}"
            echo -e "not ok  [${testMore_count}] - ${comment}";
            diag `caller 0`;
            diag "Got      [${got}]";
            diag "Expected [${expected}]";
        fi
    fi
}   # isnt()

#-----------------------------------------------------------------------

## 
#  @fn        like()
#  @brief     matches $got against the regex /expected/
#  
#  @param [in] got      Result to test
#  @param [in] regex    Reference value
#  @param [in] comment  Comment to add to result
#  @return      0 on success else 1
#  
#  @details   $(More details)
#  
#  @example   like  $got "regex" $test_name;
#  
#  @todo      
#  @bug       
#  @warning   
#  
#  @see       https://metacpan.org/pod/Test::More#like
#  @since     2022-12-13T14:43:44 / erba
#  
like()
{
    ((testMore_count++));

    local got="$1"
    local regex="$2"
    local comment="$3"
    local dummy=${4:-___}
    
    if [[ "___" != ${dummy} ]]; then
        ((testMore_failures++))
            testMore_failing_tests="${testMore_failing_tests} ${testMore_count}"
        echo -e "not ok  [${testMore_count}] - *** TOO MANY ARGUMENTS ***";
        diag `caller 0`
        diag;
    else
        if [[ `echo "${got}" | grep -E -i "${regex}"` ]]; then
            ((testMore_success++))
            echo -e "ok      [${testMore_count}] - ${comment}";
        else
            ((testMore_failures++))
            testMore_failing_tests="${testMore_failing_tests} ${testMore_count}"
            echo -e "not ok  [${testMore_count}] - ${comment}";
            diag `caller 0`;
            diag "Got      [${got}]";
            diag "Expected [${expected}]";
            diag `caller 0`
            diag;
        fi
    fi
}   # like()

#-----------------------------------------------------------------------

## 
#  @fn        unlike()
#  @brief     negative matche $got against the regex /expected/
#  
#  @param [in] got      Result to test
#  @param [in] regex    Reference value
#  @param [in] comment  Comment to add to result
#  @return      0 on success else 1
#  
#  @details   Backtrace stack 
#  
#  @example   unlike $got "regex" $test_name;
#  
#  @todo      
#  @bug       
#  @warning   
#  
#  @see       https://metacpan.org/pod/Test::More#unlike
#  @since     2022-12-13T14:43:44 / erba
# 
unlike()
{
    ((testMore_count++));

    local got="$1"
    local regex="$2"
    local comment="$3"
    local dummy=${4:-___}
    
    if [[ "___" != ${dummy} ]]; then
        ((testMore_failures++))
            testMore_failing_tests="${testMore_failing_tests} ${testMore_count}"
        echo "not ok   *** TOO MANY ARGUMENTS ***"
        diag `caller 0`
        diag;
        return 1
    else 
        if [[ ! `echo "${got}" | grep -E -i "${regex}"` ]]; then
            ((testMore_success++))
            echo -e "ok      [${testMore_count}] - ${comment}";
        else
            ((testMore_failures++))
            testMore_failing_tests="${testMore_failing_tests} ${testMore_count}"
            echo -e "not ok  [${testMore_count}] - ${comment}";
            diag `caller 0`;
            diag "Got      [${got}]";
            diag "Expected [${expected}]";
            diag `caller 0`
            diag;
        fi
    fi
}   # like()

#-----------------------------------------------------------------------

## 
#  @fn        dump_stack
#  @brief     Dump stack trace
#  
#  @return    VOID
#  
#  @details   Backtrace stack 
#  
#  @example   dump_stack;
#  
#  @todo      
#  @bug       
#  @warning   
#  
#  @see       https://stackoverflow.com/a/22617858
#  @since     2022-12-13T14:43:44 / erba
# 
dump_stack()
{
    diag "\n*** dumping stack >>>"
    local i=0
    local line_no
    local function_name
    local file_name
    local stack="start"
    while caller $i ;do ((i++)) ;done | while read line_no function_name file_name;do echo -e "\t$file_name:$line_no\t$function_name" ;done >&2
    diag "*** stack dumped stack <<<\n"
}   # dump_stack()

#-----------------------------------------------------------------------

## 
#  @fn        dump_header()
#  @brief     Extract file DoxyIt header from file
#  
#  @return    VOID
#  
#  @details   
#  
#  @example   
#  
#  @todo      
#  @bug       
#  @warning   
#  
#  @see       https://stackoverflow.com/a/22617858
#  @since     2022-12-13T14:43:44 / erba
# 
dump_header()
{
    local i=0
    local line_no
    local function_name
    local file_name
    local stack="start"
    while caller $i ;do ((i++)) ;done | while read line_no function_name file_name;do grep -E "^#\s{2}" "$file_name";done >&2
}   # dump_header()

#*** End of File ***
