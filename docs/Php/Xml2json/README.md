## XML to JSON 

Converting a XML structure to JSON is not uncomplicated - but possible:

```php

/**
 *   @fn         xml2json
 *   @brief      Convert XML structure to JSON
 *   
 *   @param [in]	$xml	XML structure
 *   @param [in]	$struct	Return JSON string or PHP data structure
 *   @return     TRUE:	PHP data structure
 *               FALSE:	JSON string
 *   
 *   @details    
 *   
 *   @example    
 *   
 *   @todo       
 *   @bug        
 *   @warning    
 *   
 *   @see        https://sergheipogor.medium.com/convert-xml-to-json-like-a-pro-in-php-603d0a3351f1
 *   @since      2024-11-04T13:03:56
 */
function xml2json( $xml, $struct = FALSE )
{
	$xml 	= simplexml_load_string($xmlString);
	$json	= json_encode($xml, JSON_PRETTY_PRINT);
	if ( $struct )
	{
		$data	= json_decode($json, true);
		return( $data );
	}
	return( $json );
}

//---------------------------------------------------------------------
```
