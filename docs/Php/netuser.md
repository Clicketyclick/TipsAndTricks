## Get user info from Windows


```
/**
 *   @fn         netUser
 *   @brief      Get user info from Windows
 *   
 *   @param [in]	$arguments=[]	Default: Full user name [[ 'user' => '%USERNAME%', 'pos' => 1 ]
 *   @return     Value from NET USER
 *   
 *   @details    
 *   
 *   @example    
 *       $user	= 'admin';
 *       fprintf( STDOUT, "%-20.20s: [%s]\n", "User",        netUser( [ 'user' => $user, 'pos' => 0 ]) );
 *       fprintf( STDOUT, "%-20.20s: [%s]\n", "Full name",   netUser( [ 'user' => $user ] ) );
 *       fprintf( STDOUT, "%-20.20s: [%s]\n", "Comment",     netUser( [ 'user' => $user, 'pos' => 2 ] ) );
 *       fprintf( STDOUT, "%-20.20s: [%s]\n", "UserComment", netUser( [ 'user' => $user, 'pos' => 3 ] ) );
 *   
 *   @todo       
 *   @bug        
 *   @warning    
 *   
 *   @see        https://
 *   @since      2024-11-08T15:37:01
 */

function netUser( $arguments = [] )
{
	$pos	= $arguments['pos'] ?? 1;
	$user	= $arguments['user'] ?? getenv( 'USERNAME');

	exec("NET USER $user", $output);
	return( substr($output[$pos], 36 ) );
}	// netUser()
```
