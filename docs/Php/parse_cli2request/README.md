## parse_cli2request
Parse cli arguments and insert into $_REQUEST

```php
/**
 *  @fn        parse_cli2request
 *  @brief     Parse cli arguments and insert into $_REQUEST
 *  
 *  @return    Void
 *  
 *  @details   Store arguments in global variable
 *        `--debug=1` sets `$_REQUEST['debug'] = 1;`
 *        `--debug=0` sets `$_REQUEST['debug'] = 1;`
 *    If $default is FALSE
 *        `--debug` sets `$_REQUEST['debug'] = ''; // Empty`
 *    otherwise
 *        `--debug` sets `$_REQUEST['debug'] = 1; // TRUE`
 *
 *  @example  parse_cli2request(); var_export( $_REQUEST );
 *  
 *  @todo      
 *  @bug       
 *  @warning   
 *  
 *  @see       https://stackoverflow.com/a/37600661
 *  @since     2024-06-25T09:09:12 / erba
 */
function parse_cli2request( $default = TRUE )
{
    global $argv;
    
    // CLI or HTTP
    // https://stackoverflow.com/a/37600661
    if (php_sapi_name() === 'cli') {
        // Remove '-' and '/' from keys
        for ( $x = 0 ; $x < count($argv) ; $x++ )
        {
            $argv[$x]   = ltrim($argv[$x], '-/');
            // Add default --x=1
            if ( $default && ! strpos($argv[$x], '='))
                $argv[$x]   .= '=1';
        }
        // Concatenate and parse string into $_REQUEST
        parse_str(implode('&', array_slice($argv, 1)), $_REQUEST);
    }
}   // parse_cli2request()
```
