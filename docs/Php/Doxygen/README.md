## PHP Doxygen header

Dumping the Doxygen file header in current file:

```php
<?php
/**
 *  @file       DoxyitFileHeader.php
 *  @brief      Get DoxyIT file header and function headers
 */

function demo()
{
    getDoxyFileHeader();
    echo "\n---\n";
    getDoxyFunctionHeaders();
}

/**
 *   @fn         getDoxyFileHeader()
 *   @brief      Get DoxyIT file header
 */
function getDoxyFileHeader()
{
    //var_export( debug_backtrace(DEBUG_BACKTRACE_IGNORE_ARGS, 1)[0]['file'] );
    $file   = debug_backtrace(DEBUG_BACKTRACE_IGNORE_ARGS, 1)[0]['file'];
    //preg_match('/\/\*\*(.*?)\*\//s', implode( '', file( __FILE__ )), $match); fputs( STDERR, $match[0] . PHP_EOL );
    preg_match('/\/\*\*(.*?)\*\//s', implode( '', file( $file )), $match);
    fputs( STDERR, $match[0] . PHP_EOL );
}

/**
 *   @fn         getDoxyFunctionHeaders
 *   @brief      Function headers only
 */
function getDoxyFunctionHeaders()
{
    $file   = debug_backtrace(DEBUG_BACKTRACE_IGNORE_ARGS, 1)[0]['file'];
    //preg_match_all('/\/\*\*(.*?)\*\//s', implode( '', file( __FILE__ )), $match);
    preg_match_all('/\/\*\*(.*?)\*\//s', implode( '', file( $file )), $match);
    var_export( implode( "\n\n", array_slice($match[0], 1) ) );
}
?>
```

Gives the output:

```console
/**
 *  @file       DoxyiitFileHeader.php
 *  @brief      Get DoxyIT file header and function headers
 */

---
'/**
 *   @fn         getDoxyFileHeader()
 *   @brief      Get DoxyIT file header
 */

/**
 *   @fn         getDoxyFunctionHeaders
 *   @brief      Function headers only
 */'
```

> [!NOTE]
> - `match[0]` has the patterns `/**` and ` */` included
> - `match[1]` has **not** the patterns `/**` and ` */` included
