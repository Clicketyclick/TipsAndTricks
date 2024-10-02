<?php
/**
 *  @file       readTextBlock.php
 *  @brief      Read a block of text from file delimited by string
 *  
 *  @details    The delimiter can either be prefixed, suffixed - or removed
 *  
 *  @copyright  http://www.gnu.org/licenses/lgpl.txt LGPL version 3
 *  @author     Erik Bachmann <ErikBachmann@ClicketyClick.dk>
 *  @since      2024-08-28T16:15:20 / erba
 *  @version    2024-10-02T21:20:52
 */

/**
 *  @fn        get_text_block
 *  @brief     Get a test block delimited by string pattern from file
 *  
 *  @param [in] $fp         File pointer
 *  @param [in] $delimiter  Delimiter as sting
 *  @param [in] $direction  1=Prefix, 0=skip, -1=Suffix 
 *  @return    
 *  
 *  @details    
 *  
 *  @example   
 *  $delimiter  = "###";
 *  
 *  
 *      $delimiter  = "###";
 *      $fp = @fopen("readTextBlock.txt", "r");
 *      foreach( [-1, 0, 1] as $direction )
 *      {
 *          rewind( $fp );
 *          printf( " Direction: $direction \n" );
 *          while( $record = get_text_block( $fp, $delimiter, $direction ) )
 *          {
 *              printf( "[%s]\n", str_replace( ["\r","\n"], ['', "\t"], $record ) );
 *          }
 *      }
 *      fclose($fp);
 *  
 *  Given the data:
 *  
 *      ###
 *      01
 *      02
 *      ###
 *      04
 *      05
 *      ###
 *      07
 *      08
 *      ###
 *
 *  Output:
 *      Direction: -1   // Suffix
 *      [###     ]
 *      [01     02      ###     ]
 *      [04     05      ###     ]
 *      [07     08      ###     ]
 *       Direction: 0   // None
 *      [01     02      ]
 *      [04     05      ]
 *      [07     08      ]
 *       Direction: 1   // Prefix
 *      [###    01     02      ]
 *      [###    04      05      ]
 *      [###    07      08      ]
 *      [###    ]
 *  
 *  @todo      
 *  @bug       
 *  @warning   
 *  
 *  @see       https://
 *  @since     2024-08-28T16:30:31 / erba
 *  
 */
function get_text_block( &$fp, $delimiter, $direction = -1 )
{
    static $buffer;

    $dir = sign( $direction );  // Used for determining how to treat delimiter
    $block  = $buffer;

    if ($fp) {
        while ( ( $buffer = fgets( $fp, 4096 ) ) !== false ) {
            if ( str_starts_with( $buffer, $delimiter ) )
            {
                if ( 0 < $dir )     // Prefix
                {
                    if ( ! empty( $block ))
                        return( $block );
                }
                if ( 0 > $dir )     // Suffix
                {
                    $block  .= $buffer;
                    $buffer = '';
                    return( $block );
                }
                if ( 0 == $dir )    // Skip
                {
                    $buffer = '';
                    if ( ! empty( $block ))
                        return( $block );
                }
            }
            $block  .= $buffer;
        }

        if (!feof($fp)) {
            trigger_error( "Error: unexpected fgets() fail\n", E_USER_WARNING );
        }
    }
    return( $block );
}   // get_text_block()

//----------------------------------------------------------------------

/**
 *  @fn        sign
 *  @brief     Checks the sign of a number
 *  
 *  @param [in] $number     Number to check
 *  @return    Returns 1 if num is positive, -1 if num is negative, and 0 if num is zero
 *  
 *  @details   
 *  
 *  @example   
 *  
 *      for ( $x = -3 ; $x < 4 ; $x++ )
 *      {
 *          printf( "%s %s\n", $x, sign( $x ) );
 *      }
 *  
 *  gives:
 *      -3 -1
 *      -2 -1
 *      -1 -1
 *      0 0
 *      1 1
 *      2 1
 *      3 1
 *  @todo      
 *  @bug       
 *  @warning   
 *  
 *  @see       https://www.php.net/manual/en/function.gmp-sign.php#121393
 *  @since     2024-08-28T16:33:46 / erba
 *  
 */
function sign( $number )
{
    return( $number <=> 0 );
}   // sign()

//----------------------------------------------------------------------

?>
