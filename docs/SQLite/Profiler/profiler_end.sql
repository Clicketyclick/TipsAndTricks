/**
 *  @file      profiler_end.sql
 *  @brief     Setting end value for session in profiler
 *  
 *  @details   Set timestamp for end and calculate diff
 *  
 *  @copyright http://www.gnu.org/licenses/lgpl.txt LGPL version 3
 *  @author    Erik Bachmann <ErikBachmann@ClicketyClick.dk>
 *  @since     2024-05-23T08:39:46 / erba
 *  @version   2024-05-23T08:39:46
 */

.print -- Setting end value for session in profiler

-- Set end
UPDATE profiler
SET 
	end = (STRFTIME('%Y-%m-%d %H:%M:%f', 'NOW'))
WHERE
    id = COALESCE((SELECT value FROM variables WHERE key = 'profiler_id' ), 'init' ) ;

-- Set diff
UPDATE profiler
SET 
	diff = (
		SELECT strftime('%s.%f',end) - strftime('%s.%f',start) as Diff FROM profiler
		WHERE
			id = COALESCE((SELECT value FROM variables WHERE key = 'profiler_id' ), 'init' ) 
	)
WHERE
    id = COALESCE((SELECT value FROM variables WHERE key = 'profiler_id' ), 'init' ) ;

-- Remove profiler_id
DELETE FROM variables WHERE key = 'profiler_id';

SELECT * FROM profiler;

-- EOF -----------------------------------------------------------------