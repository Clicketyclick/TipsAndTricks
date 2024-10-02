<?php
/**
 *  @file       readTextBlock__test.php
 *  @brief      Testing: Read a block of text from file delimited by string
 *  
 *  @details    Testing each function in module
 *  
 *  @example    php readTextBlock__test.php
 *  
 *  @requires   readTextBlock.php   Module to test
 *  @requires   readTextBlock.txt   Test data
 *  
 *  @copyright  http://www.gnu.org/licenses/lgpl.txt LGPL version 3
 *  @author     Erik Bachmann <ErikBachmann@ClicketyClick.dk>
 *  @since      2024-08-28T16:15:20 / erba
 *  @version    2024-10-02T21:18:32
 */

// Get DoxyIT header
fputs( STDERR, "\n".preg_replace( '/^\s+\*\s*@(.)/m', ':: \1', implode( '', preg_grep( '/^\s+\*\s*@/', file( __FILE__ ) ) ) ) ."\n" );


// Not included - at all!
if ( 1 == count( get_included_files() ) &&  __FILE__ == get_included_files()[0] )
{
    test_bed();
}

function test_bed()
{
    include_once( __DIR__.'/readTextBlock.php' );

    $GLOBALS['testbed']['tests']    = 0;
    $GLOBALS['testbed']['ok']       = 0;
    $GLOBALS['testbed']['fail']     = 0;
    fprintf( STDERR, '# Testing '.__FILE__.PHP_EOL );

    // Loop through each user function to find tests
    foreach( get_defined_functions()['user'] as $def_user_func )
    {
        if ( str_ends_with( $def_user_func, '__test' ) )
            call_user_func( $def_user_func );
    }

    //$GLOBALS['testbed']['fail'] = 1;
    //$GLOBALS['testbed']['fail']++;
    status();
}   // test_bed()

//----------------------------------------------------------------------

function get_text_block__test( )
{
    //fprintf( STDERR, __FUNCTION__ . PHP_EOL );

    $exp = [
        -1  => "[###\t]\n[01\t02\t###\t]\n[04\t05\t###\t]\n[07\t08\t###]\n"
    ,   0   => "[01\t02\t]\n[04\t05\t]\n[07\t08\t]\n"
    ,   1   => "[###\t01\t02\t]\n[###\t04\t05\t]\n[###\t07\t08\t]\n[###]\n"
    ];
    $got        = "";

    $delimiter  = "###";

    $fp = @fopen( __DIR__.'/readTextBlock.txt', 'r');

    foreach( [-1, 0, 1] as $direction )
    {
        rewind( $fp );
        $got    = "";
        //fprintf( STDERR, " Direction: $direction \n" );
        while( $record = get_text_block( $fp, $delimiter, $direction ) )
        {
            $got    .= sprintf( "[%s]\n", str_replace( ["\r","\n"], ['', "\t"], $record ) );
        }
        ok( $got, $exp["$direction"], "Get a test block delimited by string pattern from file [$direction]" );
    }

    fclose($fp);
    
    //ok( $got, $exp, "Get a test block delimited by string pattern from file" );
}   // get_text_block__test()

//----------------------------------------------------------------------

function sign__test( )
{
    $exp    = "-3\t-1\n-2\t-1\n-1\t-1\n0\t0\n1\t1\n2\t1\n3\t1\n";
    $got    = "";
    
    for ( $x = -3 ; $x < 4 ; $x++ )
    {
        $got    .= sprintf( "%s\t%s\n", $x, sign( $x ) );
    }
    
    ok( $got, $exp, "Checks the sign of a number" );
}   // sign__test()

//----------------------------------------------------------------------

// SUCCESS: If tests run == no of OK and 0 == no of fail
// FAILURE: Else
function status()
{
    fprintf(
        STDERR
    ,   "\nTests:\t%s\nOK:\t%s\nFailed:\t%s\nStatus:\t%s\n"
    ,   $GLOBALS['testbed']['tests']
    ,   $GLOBALS['testbed']['ok']
    ,   $GLOBALS['testbed']['fail']   //$GLOBALS['testbed']['tests'] - $GLOBALS['testbed']['ok']
    ,   (( $GLOBALS['testbed']['tests'] == $GLOBALS['testbed']['ok'] && 0 == $GLOBALS['testbed']['fail'] ) ? 'SUCCESS' : 'FAILURE' ) 
    );

}
//----------------------------------------------------------------------

function ok( $got, $exp, $note = "")
{
    $GLOBALS['testbed']['tests']    += 1;
    
    fprintf( STDERR, "%s - %s\t%s\n"
    ,   $exp == $got ? "ok" : 'fail'
    ,   debug_backtrace()[1]['function']
    ,   $exp == $got 
        ?  $note
        :   "$note\nexp<[" . str_replace( ["\t","\n"], ['\t','\n'], $exp) . "]\ngot>[".str_replace( ["\t","\n"], ['\t','\n'], $got)."]\n"
    );
    $GLOBALS['testbed']['ok']    += $exp == $got ? 1 : 0;
    $GLOBALS['testbed']['fail']  += $exp == $got ? 0 : 1;
    
    return( $exp == $got );
}

//----------------------------------------------------------------------

?>
