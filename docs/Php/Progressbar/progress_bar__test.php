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
 *  @version    2024-08-29T17:16:25
 */
include_once( 'progress_bar.php' );

$expectations   = json_decode( file_get_contents( 'progress_bar__test.json' ), TRUE );

for($x=-1;$x<=101;$x++){    // Test both under and over run
    ob_start();     // Buffer output
    $buffer = show_status($x,100);
    ob_end_clean(); // Stumm

    $buffer = str_replace( "\r", '\r', "$buffer" );
    $exp    = ( isset($expectations[$x]) ) ? str_replace( "\r", '\r', "$expectations[$x]" ) : "UNDEF";

    fprintf( STDERR, "\n%s: %03.3s: ", 0 == strcmp( "$exp", "$buffer" ) ? "OK" : "Fail" , $x);
    
    if ( 0 != strcmp( "$exp", "$buffer" ) )
    {
        fprintf( STDERR, "\nexp:[%s]\ngot:[%s]\n"
        ,   $exp
        ,   $buffer
        );
    } else
        fputs( STDERR, "GOT: [{$buffer}]" );
}

?>
