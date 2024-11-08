<?php
/**
 *   @file       puml2sql.php
 *   @brief      Transforming a UML Class schema to SQLite database schema
 *   @details    
 *   
 *   
 *   Input:		A PUML Class diagram
 *   Output:	SQLite table shema
 *
 *   @example	php puml2sql.php
 *   @example	php puml2sql.php test.puml
 *   
 *   @copyright  http://www.gnu.org/licenses/lgpl.txt LGPL version 3
 *   @author     Erik Bachmann <ErikBachmann@ClicketyClick.dk>
 *   @since      2024-11-08T12:16:24 / ErBa
 *   @version    2024-11-08T18:00:21
 */

$cfg	= [
	'database_name'	=> 'test',
	'puml_test'	=> '
@startuml

class dummy {
  Sample table.
  ==
  #id : int(10) -- A comment
  field1 : int(10)
  .. Comment line, ignored ..
  +field2 : varchar(128)
}

@enduml
',
	'puml_ref'	=> "
CREATE TABLE IF NOT EXISTS 'dummy' (
  id               INT(10), -- 'A comment'
  field1           INT(10),
  field2           VARCHAR(128),
  PRIMARY KEY (id));
",
];


if ( empty($argv[1]) )
	$puml	= $cfg['puml_test'];
else
	$puml	= file_get_contents( $argv[1] );

echo puml2sql( $puml);

//----------------------------------------------------------------------

/**
 *   @fn         puml2sql
 *   @brief      $(Brief description)
 *   
 *   @param [in]	$puml	$(description)
 *   @param [in]	$database='default'	$(description)
 *   @return     $(Return description)
 *   
 *   @details    $(More details)
 *   
 *   @example    
 *   
 *   @todo       
 *   @bug        
 *   @warning    
 *   
 *   @see        https://
 *   @since      2024-11-08T17:18:14
 */
function puml2sql( $puml, $database = 'default' )
{
	$output	=	sprintf( "-- # Database created on %s from %s\n", date("c"), $database );
	$output	.= 	sprintf( "-- # Created by: %s.\n", netUser() );

	$lines		= explode( "\n", $puml );
	$uml		= FALSE;
	$tabledef	= '';
	$tablehead	= '';

	foreach ( $lines as $line )
	{
		$token	= trim( $line );
		// Ignore empty lines
		if ( empty($token) )
			continue;

		$tokens	= explode( " ", $token );
		// Start of UML
		if ( '@startuml' == $token )
		{
			$uml	= TRUE;
			debug( "is UML" );
			continue;
		}
		// End of UML
		if ( '@enduml' == $token )
		{
			$uml	= FALSE;
			debug( "End of UML" );
			continue;
		}
		// No UML??
		if ( ! $uml )
		{
			$output	.= 	"--! $token\n";
			continue;
		}
			
		// Separator
		if ( '--' == $token )
			continue;
		// Comment
		if ( '..' == $tokens[0] )
		{
			//fprintf( STDOUT, "-- $token\n" );
			$tabledef	.= "-- $token\n";
			continue;
		}
		// Start table def
		if ( str_starts_with( $token, 'class') )
		{
			$table = $tokens[1]; $field = False;
			$primary = []; $index = [];
			// Table names are quoted and lower cased to avoid conflict with a mySQL reserved word
				//fprintf( STDOUT, "CREATE TABLE IF NOT EXISTS '". $tokens[1] . "' (\n");
				$tabledef	.= sprintf( "CREATE TABLE IF NOT EXISTS '". $tokens[1] . "'\n(\n");
				$tablename	= $tokens[1];
				continue;
		}

		if ( $table && ! $field && $token == "==" ) //# Separator after table description
		{
				$field = True;
				continue;
		}

		if ( str_starts_with( $token, '}') )
		{
			//fprintf( STDOUT, "  PRIMARY KEY (%s)\n);\n", implode(", ", $primary));
			$tabledef	.= sprintf( "  PRIMARY KEY (%s)\n);\n", implode(", ", $primary));
			if ( $index )
			{
				// Combined index if multiple fields
				if ( 1 < count($index) )
					$tabledef	.= sprintf( "CREATE UNIQUE INDEX 'index_%s' ON '%s' (%s);\n"
					,	implode("_", $index)
					,	$table
					,	implode(", ", $index)
					);
				// Individual indexes
				foreach( $index as $key )
					$tabledef	.= sprintf( "CREATE UNIQUE INDEX 'index_%s' ON '%s' ( %s );\n"
					,	$key
					,	$table
					,	$key
					//,	implode(", ", $index)
					);
			}

			$output	.= 	"\n/" . str_repeat( '*', 50 ) . "\n"
			.	$tablehead
			.	str_repeat( '*', 50 ) . "/\n" 
			.	"$tabledef\n";
			
			$tablehead	= '';
			$tabledef	= '';

			$table = False; $field = False;
			continue;
		}

		// Field definition
		if ( $field )
		{
			// # Primary key
			if ( '#' == $token[0] )
			{
				$tokens[0]	= substr( $tokens[0], 1 );
				array_push($primary, $tokens[0]);
				debug( "prim ".$tokens[0] );
			}
			// + Index key
			if ( '+' == $token[0] )
			{
				$tokens[0]	= substr( $tokens[0], 1 );
				array_push($index, $tokens[0]);
				debug( "ind: %s", $tokens[0] );
			}
			// Field def
			$tokens	= str_replace( [ '--' ], [ ', --' ], $tokens );
			//fprintf( STDOUT, "   %-20.20s %s, \n", array_shift( $tokens ), implode( " ", $tokens ));

			$tabledef	.= sprintf( "   %-20.20s %s, \n"
			,	array_shift( $tokens )
			,	str_replace( 
					[' unsigned']
				,	['']
				,	implode( 
						" "
					,	array_slice($tokens, 1 ) 
					)
				)
			);
			
			
			continue;
		}

		if ( $table && ! $field )
		{
			$tablehead	.= sprintf( "* Table: %s\n* Desc:  %s\n", $tablename, $token );
			continue;
		}

		$output	.= 	"--? $token\n";
		//user "1" -- "0..*" docs

		debug( "-- Token: [%s]", $token );
	}
	return( $output );
}	// puml2sql()

//----------------------------------------------------------------------

/**
 *   @fn         debug
 *   @brief      Print debug info to STDERR if env DEBUG set
 *   
 *   @param [in]	$str	$(description)
 *   @return     VOID
 *   
 *   @details    
 *   
 *   @example    
 *   
 *   @todo       
 *   @bug        
 *   @warning    
 *   
 *   @see        https://
 *   @since      2024-11-08T17:19:08
 */
function debug( $str )
{
	if ( getenv('DEBUG') )
		fprintf( STDERR, "! %s\n", var_export( $str, TRUE ) );
}	// debug()

//----------------------------------------------------------------------

/**
 *   @fn         netUser
 *   @brief      Get curren users full name from Windows
 *   
 *   @param [in]	$pos=1	Default line [1: User full name]
 *   @return     User Full name
 *   
 *   @details    
 *   
 *   @example    
 *   
 *   @todo       
 *   @bug        
 *   @warning    
 *   
 *   @see        https://
 *   @since      2024-11-08T15:25:01
 */

function netUser( $pos = 1, $username = '' )
{
	if ( empty( $username ) )
		$username = getenv( 'USERNAME');
	exec("NET USER %username%", $output);
	return( substr($output[$pos], 36 ) );
}	// netUser()

//----------------------------------------------------------------------

?>
