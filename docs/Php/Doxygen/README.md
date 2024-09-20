## PHP Doxygen header

Dumping the Doxygen file header in current file:

```php
<?php
/**
 *  @file       blabla.php
 *  @brief      Some file
 *  
 *  @details    More details
 *  
 *  @example    php blabla.php
 *  
 *  @requires   blobla.php   Module to test
 *  
 *  @copyright  http://www.gnu.org/licenses/lgpl.txt LGPL version 3
 *  @author     Erik Bachmann <ErikBachmann@ClicketyClick.dk>
 *  @since      2024-08-28T16:15:20 / erba
 *  @version    2024-08-29T13:54:32
 */
// Get DoxyIT header
fputs( STDERR, "\n".preg_replace( '/^\s+\*\s*@(.)/m', ':: \1', implode( '', preg_grep( '/^\s+\*\s*@/', file( __FILE__ ) ) ) ) ."\n" );
```

Gives the header:

```console

 :: file       blabla.php
 :: brief      Some file
 :: details    More details
 :: example    php blabla.php
 :: requires   blobla.php   Module to test
 :: copyright  http://www.gnu.org/licenses/lgpl.txt LGPL version 3
 :: author     Erik Bachmann <ErikBachmann@ClicketyClick.dk>
 :: since      2024-08-28T16:15:20 / erba
 :: version    2024-08-29T13:54:32

```

<!--
```php
fwrite( STDERR, getDoxygenFileHeader( __FILE__ ) );
```
Output

```console
 * [file]      file.php
 * [brief]     Brief description
 *
 * [details]   Detailed description
 *
 * [copyright] http://www.gnu.org/licenses/lgpl.txt LGPL version 3
 * [author]    Erik Bachmann <e_bachmann@hotmail.com>
 * [since]     2024-01-04T11:05:06 / ErBa
 * [version]   2024-05-28 08:36:24
```

Requires these functions (Source: `handleStrings.php`):

```php
/** 
 * @subpackage  getBetween()
 *
 * Extract substring between start pattern and end pattern
 *
 * Extract only first substring
 *
 * @param content   String to analyse
 * @param start     Start pattern
 * @param end       End patterne
 * @return string   Pattern found - or an empty string.
 * 
 * @tutorial        doc/manual.md
 * @see             https://tonyspiro.com/using-php-to-get-a-string-between-two-strings/
 * @since           2018-12-17T07:47:19
 */
function getBetween($content,$start,$end){
    $r = explode($start, $content);
    if (isset($r[1])){
        $r = explode($end, $r[1]);
        return $r[0];
    }
    return('');
}   // getBetween()

/**
 *  @fn        getDoxygenFileHeader
 *  @brief     Extract Doxygen file header from file
 *  
 *  @param [in] $file	File to extract header from
 *  @return    Description header as string
 *  
 *  @details   More details
 *  
 *  
 *  @example   fputs( STDERR, getDoxygenFileHeader( __FILE__ ) );
 *  
 *	* [file]      filename.php
 *	* [brief]     Brief description
 *  *
 *	* [details]   More details
 *  *
 *	* [copyright] http://www.gnu.org/licenses/lgpl.txt LGPL version 3
 *	* [author]    Author Name <email>
 *	* [since]     2022-05-26T17:45:18 / Author Name
 *	* [version]   2022-11-30T10:15:55 / Author Name
 *
 *  @todo      
 *  @bug       
 *  @warning   
 *  
 *  @see       https://
 *  @since     2022-12-01T08:56:27 / Erik Bachmann
 */
function getDoxygenFileHeader( $file )
{
    $source = file_get_contents( $file );
    $header = getBetween($source, "/**", "*/");
    return( var_export( preg_replace( "/\n \*\s*\@(\w*)/", "\n * [$1]", $header ), true ) );
}	// getDoxygenFileHeader()
```
--> 
