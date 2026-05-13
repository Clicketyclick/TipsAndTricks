<?php
/**
 * @file       debug.php
 * @brief      Debug, verbose and logging
 * @details    
 * 
 * Functions|Brief
 * ---|---
 * debug            | Writing debug info to logfile
 * logging          | Write loggin to logfile w. timestamp
 * verbose          | Write to console - Unless $GLOBALS['verbose'] = 0
 * ob_file_start    | Turn on output buffering to file
 * ob_file_end      | Flush (send) the return value of the active output handler and return buffer content
 * ob_file_callback | Writing buffer to file
 * .|.
 * 
 * @copyright  http://www.gnu.org/licenses/lgpl.txt LGPL version 3
 * @author     Erik Bachmann <Erik@ClicketyClick.dk>
 * @since      2026-02-24T14:10:57 / erba
 * @version    2026-03-11T17:13:35
 */

// Set default __ROOT__
defined( '__ROOT__' )   or define( '__ROOT__', strtr(dirname(__DIR__) .'/', '\\', '/' ) );

// bootstrap.php
/*
function resolveFlag(string $key, bool $default = false): bool {
    return (bool) (
        //$_SESSION[$key] 
    //?? 
        $GLOBALS['config'][$key] 
    ?? 
        $default);
}

$DEBUG_ENABLED    = resolveFlag('debug', false);
$LOGGING_ENABLED  = resolveFlag('logging', false);
$VERBOSE_ENABLED  = resolveFlag('verbose', true);

echo "DEBUG_ENABLED:$DEBUG_ENABLED, LOGGING_ENABLED:$LOGGING_ENABLED, VERBOSE_ENABLED:$VERBOSE_ENABLED\n";
*/
//----------------------------------------------------------------------

/**
 * @fn         debug
 * @brief      Writing debug info to logfile
 * 
 * @param [in]	$msg        Message
 * @param [in]	$ref=FALSE	Testing structure
 * @return      void
 * 
 * @details     Write an entry like: "2026-02-24 13:07:27.272052: DEBUG debug.php::Global scope[137]: debugging."
 * With the key elements:
 * - Datestamp       (YYYY-MM-DD hh:mm:ss.uuuuu)
 * - Filename (base)
 * - Function
 * - Class
 * - Object
 * - Line number
 * - Message
 * 
 * debug() is active if one of the following conditions are true:
 *  $_GLOBALS['debug'] are set and holds a value not FALSE
 * 
 * Log file is either `$GLOBALS['logfile']` or `logfile.log`
 * 
 * @code
 *     $GLOBALS['debug']  = 0;
 *     
 *     //require_once( '../Test-More/Test-More.php');
 *     require_once 'debug.php';
 *     
 *     class MyClass {
 *         public function processData() {
 *             // Calling debug inside a class method
 *             debug("Data processing started.");
 *         }
 *     }
 *     
 *     function testFunction() {
 *         // Calling debug inside a standard function
 *         debug("Executing test function.");
 *     }
 *     
 *     // Global call
 *     debug("Just a global message.");
 *     
 *     $obj = new MyClass();
 *     $obj->processData();
 *     
 *     testFunction();
 * @endcode
 * 
 * If called with either: `-d=1`, ´--debug=1´ or `-!`
 * @verbatim
 * 2026-02-24 13:21:21.470884: DEBUG debug.php::Global scope[184]: debugging.
 * @endverbatim
 * 
 * @see        https://
 * @since      2026-02-24T14:11:08
 */

function debug( string $msg, string $prefix = '', mixed $ref = FALSE ) : string
{
    // Skip if no debugging
    if ( empty( $GLOBALS['debug'] ) && empty( $_SESSION['debug'] ) )// && '!' != $prefix )
        return( '' );

    $trace  = debug_backtrace(DEBUG_BACKTRACE_IGNORE_ARGS);

    // Set indent level
    if ( '' != $prefix )//&& '!' != $prefix)
    {
        $msg    = str_repeat( $prefix, count($trace) ) . " $msg";
    }

    // Limit the backtrace to 2 frames to save memory
    //$trace = debug_backtrace(DEBUG_BACKTRACE_IGNORE_ARGS, 2);

    // $trace[0] contains the file and line where debug() was called
    $file = isset($trace[0]['file']) ? $trace[0]['file'] : 'Unknown file';
    $line = isset($trace[0]['line']) ? $trace[0]['line'] : 'Unknown line';

    // Grab the calling function/class
    $function   = isset($trace[1]['function'])  ? $trace[1]['function']     : 'Global scope';
    $class      = isset($trace[1]['class'])     ? $trace[1]['class'] . '::' : '';
    $obj        = isset($trace[1]['object'])    ? "{{$trace[1]['class']}}"  : '';
    
    // Override if the "function" is actually a file inclusion construct
    $inclusion_constructs = ['include', 'include_once', 'require', 'require_once'];
    if (in_array($function, $inclusion_constructs)) {
        $function = 'Global scope';
        $class = ''; // Ensure class is empty
    }

    $caller = $class . $function;

    //$msg    = sprintf( '%s: DEBUG %s::%s[%s]: %s.'.PHP_EOL
    $msg    = sprintf( "%s:! %s::%s[%s]:\t%s"       // Debug = !
        // Source - https://stackoverflow.com/a/46058305
        // Posted by bamossza
        // output: 2017-09-05 17:04:57.555036
        // Retrieved 2026-02-24, License - CC BY-SA 3.0
        ,   date("Y-m-d H:i:s.").gettimeofday()["usec"]
        ,   basename($file)
        ,   $caller . $obj     //function/class
        ,   $line
        ,   $msg 
    );
    file_put_contents( __ROOT__ . ($GLOBALS['tracefile'] ?? $_SESSION['tracefile'] ?? '/default_trace_file.log')
    ,   "$msg\n"
    ,   FILE_APPEND
    );
    
    if (!empty($ref))
    {
        //echo "\n$msg";
        if (function_exists('is'))
        {
            // , ['file' => __FILE__, 'line' => __LINE__, 'function' => __FUNCTION__ ]);
            $file                   = basename($file);
            $ref['file']            = basename($ref['file']);
            $ref['function']        = empty($ref['function']) ? 'Global scope' : $ref['function'];
            if (in_array($ref['function'], $inclusion_constructs)) {
                $ref['function'] = 'Global scope';
                $ref['class']   = ''; // Ensure class is empty
            }

            is( $ref['file'],       $file,      "File match: {$ref['file']}=={$file }");
            is( $ref['function'],   $caller,    "func match: {$ref['function']}=={$caller }");
            is( $ref['line'],       $line,      "line match: {$ref['line']}=={$line }");
        }
    }
    echo "$msg\n";
    return( $msg );
}   //*** debug() ***

//----------------------------------------------------------------------

/**
 * @fn         logging
 * @brief      Write loggin to logfile w. timestamp
 * 
 * @param [in]	string $msg     Message
 * @return     void
 * 
 * @details    Write a string to logfile w. datastamp and message
 * 
 * Log file is either `$GLOBALS['logfile']` or `logfile.log`
 * 
 * 
 * @code
 *     require_once 'debug.php';
 *      logging( 'Some string' );
 * @endcode
@verbatim
 * 2026-02-24 13:21:21.470884: LOG__ Some string.
@endverbatim
 * <!--
 * @todo       
 * @bug        
 * @warning    
 * @note    
 * -->
 * @see        https://
 * @since      2026-02-24T14:27:56
 */
function logging( string $msg ) : string
{
    //if ( empty( $GLOBALS['logging']  ) ) { return( 'no log'); }
    if ( empty( $GLOBALS['debug'] ?? $_SESSION['debug'] ) ) return( '' );

    $msg    = sprintf( "%s: LOG__\t%s".PHP_EOL
        // Source - https://stackoverflow.com/a/46058305
        // Posted by bamossza
        // output: 2017-09-05 17:04:57.555036
        // Retrieved 2026-02-24, License - CC BY-SA 3.0
        ,   date("Y-m-d H:i:s.").gettimeofday()["usec"]
        ,   $msg 
    );

    file_put_contents( $GLOBALS['logfile'] ?? $_SESSION['logfile'] ?? __ROOT__ .'/default_log_file.log'
    ,   $msg
    ,   FILE_APPEND
    );
    return "$msg";
}   //*** logging() ***


function logging_level( string $msg, string $prefix = '-') : void
{
    $trace = debug_backtrace(DEBUG_BACKTRACE_IGNORE_ARGS);
    $count  = count($trace);
    $msg    = str_repeat( $prefix, $count ) . " $msg";
    logging( $msg );
}   //*** logging_level() ***

//----------------------------------------------------------------------


/**
 * @fn         verbose
 * @brief      Echo intermediate steps and additional information
 * 
 * @param [in]		string	$msg		intermediate steps and additional information
 * @return     String as send to console
 * 
 * @details    Verbose is echoing additional info to console
 * 
 * <!--
 * @code
 * @endcode
@verbatim
@endverbatim
 * 
 * @todo       
 * @bug        
 * @warning    
 * @note    
 * -->
 * @see        https://
 * @since      2026-02-27T12:53:34
 */
function verbose( string $msg ) : string
{
    
    //if ( empty( $GLOBALS['verbose']  ) ) {         return( '');    }
    if ( empty( $GLOBALS['debug'] ?? $_SESSION['debug'] ) ) return( '' );
    
    $msg    .= PHP_EOL;
    echo "{$msg}";
    return("{$msg}");
}   //*** verbose() ***

//----------------------------------------------------------------------

/**
 * @fn         ob_file_start
 * @brief      Turn on output buffering to file
 * 
 * @param [in]	$filename	Logfile
 * @return     File pointer to logfile
 * 
 * @details    
 * 
 * @code
 * @endcode
@verbatim
@endverbatim
 * <!--
 * @todo       
 * @bug        
 * @warning    
 * @note    
 * -->
 * @see        https://
 * @since      2026-02-27T12:53:41
 */
function ob_file_start($filename)
{
    global $ob_file;
    $ob_file = fopen($filename,'w');
    ob_start('ob_file_callback');
    return($ob_file);
}   //*** ob_file_start() ***

//----------------------------------------------------------------------

/**
 * @fn         ob_file_end
 * @brief      Flush (send) the return value of the active output handler and return buffer content
 * 
 * @param [in]		Void
 * @return     Buffer contents
 * 
 * <!--
 * @details    
 * 
 * @code
 * @endcode
@verbatim
@endverbatim
 * 
 * @todo       
 * @bug        
 * @warning    
 * @note    
 * -->
 * @see        https://
 * @since      2026-02-27T12:53:46
 */
function ob_file_end()
{
    $result     = ob_get_contents();
    ob_end_flush();
    return($result);
}   //*** ob_file_end() ***

//----------------------------------------------------------------------

/**
 * @fn         ob_file_callback
 * @brief      Writing buffer to file
 * 
 * @param [in]	$buffer	$(description)
 * @return     $(Return description)
 * 
 * @details    $(More details)
 * 
 * @code
 * @endcode
@verbatim
@endverbatim
 * <!--
 * @todo       
 * @bug        
 * @warning    
 * @note    
 * -->
 * @see        https://
 * @since      2026-02-27T12:53:51
 */
function ob_file_callback($buffer)
{
  global $ob_file;
  fwrite($ob_file,$buffer);
}   //*** ob_file_callback ***

//----------------------------------------------------------------------


/*>>> Selftest >>> */
/*
if ( realpath(__FILE__) === realpath($_SERVER['SCRIPT_FILENAME'] ?? FALSE ) )
{
    // Get file header
    preg_match('/\/\*\*(.*?)\*\//s', implode( '', file( __FILE__ )), $match); fputs( STDERR, $match[0] . PHP_EOL );

    $GLOBALS['config'] = [
        'debug'     => TRUE,
        'logging'   => TRUE,
        //'verbose'   => FALSE,

        'logfile'   => 'log.txt',
        'tracefile' => 'trace.txt'
    ];

    debug('debugging', '-', ['file' => __FILE__, 'line' => __LINE__, 'function' => __FUNCTION__ ]);
    
    $load = function (string $lib): bool {
       if (!is_file($lib)) {
            throw new RuntimeException("Lib not found: {$lib}");
        }
        if (!is_readable($lib)) {
            throw new RuntimeException("Lib not readable: {$lib}");
        }
        require_once $lib;
        return true;
    };
    
    
    $load( dirname( __DIR__ ).'/../TestMore/src/TestMore.php' );

    
    plan(13);
    diag( 'Selftest: '.__FILE__ );
    diag( 'Functions exists: ');

    ok(function_exists('verbose'), "verbose() is available");
    ok(function_exists('debug'), "debug() is available");
    ok(function_exists('logging'), "logging() is available");
    ok(function_exists('ob_file_start'), "ob_file_start() is available");
    ok(function_exists('ob_file_end'), "ob_file_end() is available");
    ok(function_exists('ob_file_callback'), "ob_file_callback() is available");

    diag( 'Functions responds: ');

    // verbose
    $log    = "debug.txt";
        ob_file_start($log);
        unset($GLOBALS['verbose']);
        $exp    = "verbose=: Not to be found\n";
        verbose($exp);
        $got    = trim( ob_file_end() );
        ok( (0 == strcmp( "", $got )), "verbose: exp[…{$got}]");

        ob_file_start($log);
        $GLOBALS['verbose']    = 0;
        $exp    = "verbose=0: Not to be found\n";
        verbose($exp);
        $got    = trim( ob_file_end() );
        ok( (0 == strcmp( "", $got )), "verbose: exp[…{$got}]");

        ob_file_start($log);
        $GLOBALS['verbose']    = 1;
        $exp    = "verbose=1: Must be found";
        verbose($exp);
        $got    = trim( ob_file_end() );
        ok( (0 == strcmp( $exp, $got )), "verbose: exp[…{$got}]");
    unlink($log);


    // logging();
    $GLOBALS['config']['logfile']    = "logging.txt";
    $GLOBALS['config']['logging']    = TRUE;
    
    $exp    = "logging: Must be found";
    logging($exp);
    $got    = trim(file_get_contents( $GLOBALS['config']['logfile'] ));
    ok( ( str_ends_with( $got, ": LOG__ $exp." )), "logging: exp[…{$exp}]");
    unlink( $GLOBALS['config']['logfile'] );

    // debug();
    unset($GLOBALS['debug']);
    debug("debug=: Not to be found\n");
    $got    = file_exists( $GLOBALS['config']['logfile'] );
    ok( ! $got, "debug: exp[…{$exp}]");

    $GLOBALS['debug']    = 0;
    debug("debug=0: Not to be found\n");
    $got    = file_exists( $GLOBALS['config']['logfile'] );
    ok( ! $got, "debug: exp[…{$exp}]");

    $GLOBALS['debug']    = 1;
    $exp    = "debug=1: Must be found";
    debug($exp);
    $got    = trim(file_get_contents( $GLOBALS['config']['logfile'] ));
    ok( ( str_ends_with( $got, "]: {$exp}." )), "debug: exp[…{$exp}]");

    diag( 'ob_file_start(), ob_file_end() and ob_file_callback() are tested implicit');

    return( done_testing() );
} else return(NULL);
/*<<< Selftest <<< */

//>>> Selftest >>> 

if ( realpath(__FILE__) === realpath($_SERVER['SCRIPT_FILENAME'] ?? FALSE ) )
{
    // Get file header
    preg_match('/\/\*\*(.*?)\*\//s', implode( '', file( __FILE__ )), $match); fputs( STDERR, $match[0] . PHP_EOL );

    $GLOBALS['debug']     = TRUE;
    $GLOBALS['logging']   = TRUE;
        //'verbose'   => FALSE,

    $GLOBALS['logfile']   = 'logging.txt';
    $GLOBALS['tracefile'] = 'trace.txt';


    $load_once = function (string $lib, bool $once = TRUE ): bool {
       if (!is_file($lib)) {
            throw new RuntimeException("Lib not found: {$lib}");
        }
        if (!is_readable($lib)) {
            throw new RuntimeException("Lib not readable: {$lib}");
        }
        $once ? require_once $lib : require $lib ;
        return true;
    };
    
    
    $load_once( dirname( __DIR__ ).'/src/debug.php' );
    $load_once( dirname( __DIR__ ).'/../TestMore/src/TestMore.php' );

    //ob_start('ob_file_callback');
    //debug('debugging', '-', ['file' => __FILE__, 'line' => __LINE__, 'function' => __FUNCTION__ ]);
    //ob_end_flush();

    plan(13);
    diag( 'Selftest: '.__FILE__ );
    diag( 'Functions exists: ');
    $tests_done = 1;
    ok(function_exists('verbose'), "1: verbose() is available");
    ok(function_exists('debug'), "2: debug() is available");
    ok(function_exists('logging'), "3: logging() is available");
    ok(function_exists('ob_file_start'), "4: ob_file_start() is available");
    ok(function_exists('ob_file_end'), "5: ob_file_end() is available");
    ok(function_exists('ob_file_callback'), "6: ob_file_callback() is available");

    diag( 'Functions responds: ');


    // verbose
    $log    = "debug.txt";
        ob_file_start($log);
        unset($GLOBALS['verbose']);
        $exp    = "verbose=NULL: Not to be found";
        verbose($exp);
        $got    = trim( ob_file_end() );
        ok( ( 0 == strcmp( $exp, $got )), "7: verbose: exp[…{$got}]")
        || (
            diag( 'exp:'.var_export( $exp, TRUE ) ) 
        .   diag( 'got:'.var_export( $got, TRUE ) )
        )
        ;


        ob_file_start($log);
        $GLOBALS['verbose']    = 0;
        $exp    = "verbose=0: Not to be found";
        $exp    = "";
        verbose($exp);
        $got    = trim( ob_file_end() );
        ok( (0 == strcmp( $exp, $got )), "8: verbose: exp[…{$got}]")
        || (
            diag( 'exp:'.var_export( $exp, TRUE ) ) 
        .   diag( 'got:'.var_export( $got, TRUE ) )
        )
        ;


        ob_file_start($log);
        $GLOBALS['verbose']    = 1;
        $exp    = "verbose=1: Must be found";
        verbose($exp);
        $got    = trim( ob_file_end() );
        ok( (0 == strcmp( $exp, $got )), "9: verbose: exp[…{$got}]");
    unlink($log);

/**/
    // logging();
    $GLOBALS['logging']    = TRUE;
    
    $exp    = "logging: Must be found";
    logging($exp);
    $got    = trim(file_get_contents( $GLOBALS['logfile'] ));
    ok( ( str_ends_with( $got, ": LOG__\t$exp" )), "10: logging: exp[…{$exp}]");
    //echo "[$got]";
    //exit;
    unlink( $GLOBALS['logfile'] );

    // debug();
    unset($GLOBALS['debug']);
    unset($_SESSION['debug']);
    $exp    = "debug=: Not to be found";
    $exp    = FALSE; // Testing that tracefile exists
    diag( "Deleting: {$GLOBALS['tracefile']}");
    @unlink( $GLOBALS['tracefile'] );
    //diag( file_exists($GLOBALS['tracefile']) . $GLOBALS['tracefile']);
//exit;
    debug($exp);
//  diag( file_exists($GLOBALS['tracefile']) . $GLOBALS['tracefile']);
//exit;
    $got    = file_exists( $GLOBALS['tracefile'] );
    
    //ok( ! $got, "debug not set: got:$got, exp[…{$exp}]")
    ok( ! $got, "11: debug not set: got:$got")
    //ok( ! $got, $exp )
    || (
        diag( 'exp:'.var_export( $exp, TRUE ) ) 
    .   diag( 'got:'.var_export( $got, TRUE ) )
    );

    $GLOBALS['debug']    = 0;
    debug("debug=0: Not to be found\n");
    $got    = file_exists( $GLOBALS['tracefile'] );
    ok( ! $got, "debug: exp[…{$exp}]");

    $GLOBALS['debug']    = 1;
    $exp    = "debug=1: Must be found";
    
    // catch output
    ob_start('ob_file_callback');
    @debug($exp);
    ob_end_flush();
    $got    = trim(file_get_contents( $GLOBALS['tracefile'] ));
    ok( ( str_ends_with( $got, "{$exp}" )), "104 debug: exp[…{$exp}]");

    diag( 'ob_file_start(), ob_file_end() and ob_file_callback() are tested implicit');
    return( done_testing() );
} else return(NULL);
//<<< Selftest <<<
