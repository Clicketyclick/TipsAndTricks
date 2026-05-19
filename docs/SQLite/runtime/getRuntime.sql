/**
 * @file       getRuntime.sql
 * @brief      Calculate runtime
 * @details    
 * 
 * Functions|Brief
 * ---|---
 * .|.
 * 
 * @copyright  http://www.gnu.org/licenses/lgpl.txt LGPL version 3
 * @author     Erik Bachmann <Erik@ClicketyClick.dk>
 * @since      2026-05-19T08:51:01 / erba
 * @version    2026-05-19T08:51:01
 */

REPLACE INTO time_stamp(key)  VALUES( 'endtime' );
WITH diff(seconds) AS (
    SELECT (julianday(e.utc) - julianday(s.utc)) * 86400.0
    FROM time_stamp s
    JOIN time_stamp e
      ON s.key = 'starttime'
     AND e.key = 'endtime'
)
SELECT printf(
    '0000-00-00T%02d:%02d:%06.3f',
    CAST(seconds / 3600 AS INT),
    CAST((seconds % 3600) / 60 AS INT),
    (seconds % 60)
) AS runtime
FROM diff;

------------------------------------------------------------------------