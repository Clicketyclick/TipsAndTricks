## Associative array
### Create, reference and loop through

```javascript
<script>
/**
 *  @file      associative.html
 *  @brief     $(Brief description)
 *  
 *  @details   $(More details)
 *  
 *  @see   		https://stackoverflow.com/a/1208272 - How to do associative array/hashing in JavaScript
 *  @see   		https://stackoverflow.com/a/922357 - How to loop through a plain JavaScript object with the objects as members
 *
 *  @copyright http://www.gnu.org/licenses/lgpl.txt LGPL version 3
 *  @author    Erik Bachmann <ErikBachmann@ClicketyClick.dk>
 *  @since     2024-01-26T15:38:03 / erba
 *  @version   2024-01-26T15:38:03
 *  
 */

// Simple JSON like object
// var point = { x:3, y:2, name: { first:"Donald", surname:"Duck" } };

// Formated JSON object
var point = { 
	x:3
,	y:2
,	name: { 
		first:"Donald"
	,	surname:"Duck" 
	}
};

// Exact values
console.log( "Expected (3): " + point["x"] ); 	// returns 3
console.log( "Expected (2): " + point.y );		// returns 2

// Loop
for ( var key of Object.keys(point) ) {
	console.log( key + ": ["+point[key]+"]" );
}

// Exact reference
console.log( "firstname: ["+point.name.first  + "]" );
console.log( "surname:   ["+point["name"]["surname"] + "]" );

</script>
```
