<?php

//---------------------------------------------------------------------
/**
 *  @fn        microtime2human
 *  @brief     Return a human readable version of microtime (float)
 *  
 *  @param [in] $microtime 	Description for $microtime
 *  @return    Return description
 *  
 *  @details   Uses ISO-86001 for periode: P[n]Y[n]M[n]DT[n]H[n]M[n]S
 *  
 *  @example   
 *      echo microtime2human( "86399.0" ) .PHP_EOL;
 *      echo microtime2human( "87000.0" ) .PHP_EOL;
 *      echo microtime2human( "870000.0" ) .PHP_EOL;
 *      echo microtime2human( "8700000.0" ) .PHP_EOL;
 *      echo microtime2human( "87000000.0" ) .PHP_EOL;
 *  
 *      23:59:59.0
 *      P1DT00:10:00.0
 *      P10DT01:40:00.0
 *      P3M10DT16:40:00.0
 *      P2Y9M6DT22:40:00.0
 *  
 *  @see       https://stackoverflow.com/a/16825451/7485823 - How to convert microtime() to HH:MM:SS:UU
 *  @see       https://en.wikipedia.org/wiki/ISO_8601#Durations
 *  @since     2023-01-27T12:35:18 / erba
 */
function microtime2human( $microtime )
{
    if ( ! isset($microtime)) return( "?");
    if (   empty($microtime)) return( "?");
    
    list($sec, $usec) = explode('.', $microtime);   //split the microtime on .
    
    $usec   = str_replace("0.", ".", $usec);          //remove the leading '0.' from usec
    
    $date   = "";
    if ( $sec > (365*24*60*60) )    // Years
    {
        $date   .= intval( $sec / (365*24*60*60) )
        .   "Y";
        $sec %= (365*24*60*60);
    }
    if ( $sec > (30*24*60*60) )    // Months
    {
        $date   .= intval( $sec / (30*24*60*60) )
        .   "M";
        $sec %= (30*24*60*60);
    }
    if ( $sec > (24*60*60) )        // Days
    {
        $date   .= intval( $sec / (24*60*60) )
        .   "D";
        $sec %= (24*60*60);
    }
    return (
        ( $date ? "P{$date}T" : "" )
        .   date('H:i:s', $sec) 
        .   '.' 
        . $usec
        );       //appends the decimal portion of seconds
}   // microtime2human()

//----------------------------------------------------------------------

/**
 *   @fn         microtime_diff( $time_end, $time_start, $precision = 10 )
 *   @brief      Calculate the difference between to microtimes
 *   
 *   @param [in]	$time_end	End of session
 *   @param [in]	$time_start	Start of sesstion
 *   @param [in]	$precision=10	Precission used in calculation
 *   @retval     The difference as float w. precision
 *   
 *   @details    Due to Floating point precision problems you cannot simply 
 *  subtract one floating point value from another.
 *   
 *   To get a sensible value you have to round both end and start time - and the result
 *   
 *   @code
 *   $precision  = 10;
 *   $time_start = microtime(true);
 *   // wait a sec (as close as)
 *   usleep(1000000);
 *   $time_end   = microtime(true);
 *   echo "Diff: ".microtime_diff($time_end, $time_start). PHP_EOL;
 *   echo "Time: ".microtime2human( microtime_diff($time_end, $time_start, 5) ). PHP_EOL;
 *   
 *   @endcode
@verbatim
Diff: 0.9979860783
Time: 00:00:00.99798
@endverbatim
 *   
 *   @see        https://www.php.net/float
 *   @see        https://floating-point-gui.de/
 *   @since      2025-02-15T18:38:19
 */
function microtime_diff( $time_end, $time_start, $precision = 10 )
{
    return( sprintf( "%.*f", $precision, round($time_end, $precision) - round($time_start, $precision) ) );
}   // microtime_diff()

//---------------------------------------------------------------------

?>
