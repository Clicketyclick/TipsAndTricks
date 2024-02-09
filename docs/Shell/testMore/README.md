# testMore

## Name

testMore - yet another framework for writing test scripts

Yep - but for Linux shell scripts

## Synopsis

```shell
# Include module
. "./testMore.sh"

# Plan number of tests
testMore_tests=8

# Various ways to say "ok"
ok ($got eq $expected) $test_name;
 
is $got $expected $test_name;
isnt $got $expected $test_name;
 
# Rather than print STDERR "# here's what went wrong\n"
diag "here's what went wrong";
 
like $got "expected" $test_name;
unlike($got "expected $test_name;
```

<!-- 
cmp_ok($got, '==', $expected, $test_name);
 
is_deeply($got_complex_structure, $expected_complex_structure, $test_name);
 
SKIP: {
    skip $why, $how_many unless $have_some_feature;
 
    ok( foo(),       $test_name );
    is( foo(42), 23, $test_name );
};
 
TODO: {
    local $TODO = $why;
 
    ok( foo(),       $test_name );
    is( foo(42), 23, $test_name );
};
 
can_ok($module, @methods);
isa_ok($object, $class);
 
pass($test_name);
fail($test_name);
 
BAIL_OUT($why);
 
# UNIMPLEMENTED!!!
my @status = Test::More::status;
-->



## Description

Using simple test like:
- ok - expression is true
- is - two strings a equal
- isnt - two strings a NOT equal
- like - string matches a regex pattern
- unlike - string does NOT match regex pattern

This module is simply included 
and ready to use

The process is:
1. Include the module using `. "./testMore.sh"`
2. `dump_header`
3. Plan a number of tests - `testMore_tests=`
4. Run the tests: `ok`. `is`, `isnt`, `like`, `unlike`
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
