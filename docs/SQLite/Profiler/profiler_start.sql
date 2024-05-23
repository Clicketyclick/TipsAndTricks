/**
 *  @file      profiler_start.sql
 *  @brief     Setting profiler start
 *  
 *  @details   Setting start value in profiler 
 *  
 *  @copyright http://www.gnu.org/licenses/lgpl.txt LGPL version 3
 *  @author    Erik Bachmann <ErikBachmann@ClicketyClick.dk>
 *  @since     2024-05-23T08:20:04 / erba
 *  @version   2024-05-23T08:20:04
 */
 
.print -- Setting profiler start

-- DELETE FROM variables WHERE key = 'profiler_id';

SELECT COALESCE((SELECT value FROM variables WHERE key = 'profiler_id')
,   'Set "profiler_id" in variables like: '
||char(10)
||char(10)||    'REPLACE INTO variables (key, value )'
||char(10)||    'VALUES( ''profiler_id'',''testing'' );') as profiler_id
;
-- REPLACE INTO variables (key, value ) VALUES( 'profiler_id','testing' );

-- Update start
REPLACE INTO profiler (id ) VALUES( COALESCE((SELECT value FROM variables WHERE key = 'profiler_id' ), 'init' ) );
SELECT * FROM profiler;

-- EOF -----------------------------------------------------------------