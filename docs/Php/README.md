@@Php_logo@@

## PHP 

- [CORS on PHP (Of CORse)](of-course.html)
- [Start local webserver (DOS)](local_server.html)
- [INI config](ini_config)

### PHP scripts

- [CPR](/cpr) Checking danish CPR-numbers (Personal identification number in Denmark)
- [Country Codes](/country.io/) - Country code lists bases on ISO2 and ISO3 combined into JSON structures.
- [JsonDb](/jsondb/) - Rutines to read / write JSON and mixed data to SQL database


### Tips

#### Recursive functions
Do not use "call to self" by name inside recursive functions. Use variable functions instead:

```php
function test($i) {
   static $__this = __FUNCTION__;
   if($i > 5) {
       echo $i. "\n";
       $__this($i-1);
   }
}
```
Source: [@@Stackoverflow_logo@@ Can you make a PHP function recursive without repeating its name?](https://stackoverflow.com/a/2719016)

#### Duration

```php
$starttime  = microtime( TRUE );  // Initiate star
:
list($sec, $usec) = explode('.', microtime( TRUE ) - $starttime ); //split the microtime on .
print date('H:i:s.', $sec) . $usec;       //appends the decimal portion of seconds
```
Source: [@@Stackoverflow_icon@@ How to convert microtime() to HH:MM:SS:UU](https://stackoverflow.com/questions/16825240/how-to-convert-microtime-to-hhmmssuu)


#### Modify structure
Source: [@@Stackoverflow_icon@@ Using a string path to set nested array data [duplicate]](https://stackoverflow.com/a/44189105)

```php

/**
 *  @fn        array_get_value
 *  @brief     Get value from array
 *  
 *  @param [in] $array   Reference ot array
 *  @param [in] $parents Path to value
 *  @param [in] $glue    Separator in string
 *  @return     mixed
 *  
 *  @details   
 *  
 *  @example   
 *  
 *  @todo      
 *  @bug       
 *  @warning   
 *  
 *  @author     ymakux  https://stackoverflow.com/users/388563/ymakux
 *  @see        https://stackoverflow.com/a/44189105
 *  @since      2017-05-17T20:14:00 / ymakux
 */
function array_get_value(array &$array, $parents, $glue = '.')
{
    if (!is_array($parents)) {
        $parents = explode($glue, $parents);
    }

    $ref = &$array;

    foreach ((array) $parents as $parent) {
        if (is_array($ref) && array_key_exists($parent, $ref)) {
            $ref = &$ref[$parent];
        } else {
            return null;
        }
    }
    return $ref;
}  // array_get_value()
//----------------------------------------------------------------------
/**
 *  @fn        array_set_value
 *  @brief     Set value in array
 *  
 *  @param [in] $array   Reference ot array
 *  @param [in] $parents Path to value
 *  @param [in] $value   Value to insert
 *  @param [in] $glue    Separator in string
 *  @return     mixed
 *  
 *  @details   
 *  
 *  @example   
 *  
 *  @todo      
 *  @bug       
 *  @warning   
 *  
 *  @author     ymakux  https://stackoverflow.com/users/388563/ymakux
 *  @see        https://stackoverflow.com/a/44189105
 *  @since      2017-05-17T20:14:00 / ymakux
 */
function array_set_value(array &$array, $parents, $value, $glue = '.')
{
    if (!is_array($parents)) {
        $parents = explode($glue, (string) $parents);
    }

    $ref = &$array;

    foreach ($parents as $parent) {
        if (isset($ref) && !is_array($ref)) {
            $ref = array();
        }

        $ref = &$ref[$parent];
    }

    $ref = $value;
}  // array_set_value()
//----------------------------------------------------------------------
/**
 *  @fn        array_unset_value
 *  @brief     Unset value in array
 *  
 *  @param [in] $array   Reference ot array
 *  @param [in] $parents Path to value
 *  @param [in] $glue    Separator in string
 *  @return     mixed
 *  
 *  @details   
 *  
 *  @example   
 *  
 *  @todo      
 *  @bug       
 *  @warning    Uses self-referencing
 *  
 *  @author     ymakux  https://stackoverflow.com/users/388563/ymakux
 *  @see        https://stackoverflow.com/a/44189105
 *  @since      2017-05-17T20:14:00 / ymakux
 */
function array_unset_value(&$array, $parents, $glue = '.')
{
    static $__this = __FUNCTION__;  // [Variable function](#recursive-functions)
    
    if (!is_array($parents)) {
        $parents = explode($glue, $parents);
    }

    $key = array_shift($parents);

    if (empty($parents)) {
        unset($array[$key]);
    } else {
        // Self reference: https://stackoverflow.com/a/2719016
        // array_unset_value($array[$key], $parents);
        $__this($array[$key], $parents);
    }
}   // array_unset_value()
```

### Modules

PHP 8. which gives error with  `imagettfbbox`. it has to be replaced with `imageftbbox`

```ini
extension=gd
;2024-03-13 19:11:05/ErBa ImageMagick
extension=php_imagick.dll
```


