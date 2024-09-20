<?php
/**
 *  @file       progress_bar__test.php
 *  @brief      Testing progress_bar.php
 *  
 *  @details    Loops with both under- and overrun
 *  
 *  @copyright  http://www.gnu.org/licenses/lgpl.txt LGPL version 3
 *  @author     Erik Bachmann <ErikBachmann@ClicketyClick.dk>
 *  @since      2024-08-29T17:16:25 / erba
 *  @version    2024-09-20T19:13:02
 */
// Get DoxyIT header
fputs( STDERR, "\n".preg_replace( '/^\s+\*\s*@(.)/m', ':: \1', implode( '', preg_grep( '/^\s+\*\s*@/', file( __FILE__ ) ) ) ) ."\n" );

include_once( __DIR__.'/progress_bar.php' );

$expectations   = json_decode( file_get_contents( __DIR__.'/progress_bar__test.json' ), TRUE );

$debug  = getenv('DEBUG');;

$low    = -1;
$high   = 101;
$tests  = $high - $low + 1;
$ok     = $err  = 0;

$GLOBALS['testbed']['tests']    = 0;
$GLOBALS['testbed']['ok']       = 0;
$GLOBALS['testbed']['fail']     = 0;


for($x=$low;$x<=$high;$x++){    // Test both under and over run

    ob_start();     // Buffer output
    $buffer = show_status($x,100);
    ob_end_clean(); // Stumm

    $buffer = str_replace( "\r", '\r', "$buffer" );
    $exp    = ( isset($expectations[$x]) ) ? str_replace( "\r", '\r', "$expectations[$x]" ) : "UNDEF";

    if ( $debug ) fprintf( STDERR, "\n%s: %03.3s: ", 0 == strcmp( "$exp", "$buffer" ) ? "OK" : "Fail" , $x);
    
    if ( 0 != strcmp( "$exp", "$buffer" ) )
    {
        $GLOBALS['testbed']['fail']++;
        fprintf( STDERR, "\nexp:[%s]\ngot:[%s]\n"
        ,   $exp
        ,   $buffer
        );
    } 
    else 
    {
        $GLOBALS['testbed']['ok']++;
        fputs( STDERR, "GOT: [{$buffer}]\r" );
    }
    $GLOBALS['testbed']['tests']++;
}

status();

//----------------------------------------------------------------------

// SUCCESS: If tests run == no of OK and 0 == no of fail
// FAILURE: Else
function status()
{
    fprintf(
        STDERR
    ,   "\n\nTests:\t%s\nOK:\t%s\nFailed:\t%s\nStatus:\t%s\n"
    ,   $GLOBALS['testbed']['tests']
    ,   $GLOBALS['testbed']['ok']
    ,   $GLOBALS['testbed']['fail']   //$GLOBALS['testbed']['tests'] - $GLOBALS['testbed']['ok']
    ,   (( $GLOBALS['testbed']['tests'] == $GLOBALS['testbed']['ok'] && 0 == $GLOBALS['testbed']['fail'] ) ? 'SUCCESS' : 'FAILURE' ) 
    );
}   // status() 
//----------------------------------------------------------------------

?>
