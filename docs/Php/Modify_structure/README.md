
#### Modify structure
Source: [@@Stackoverflow_icon@@ Using a string path to set nested array data [duplicate]](https://stackoverflow.com/a/44189105)

See also: How to access and [manipulate multi-dimensional array by key names / path?](https://stackoverflow.com/q/27929875)

- array_get_value - Get value from array at a given path
- array_set_value - Set value in array at a given path
- array_unset_value - Unset value in array at a given path


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
