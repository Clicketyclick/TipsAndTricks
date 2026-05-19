
/**
 * @file       initRuntime.sql
 * @brief      Creating a TEMP table for runtime
 * @details    
 * 
 * Functions|Brief
 * ---|---
 * .|.
 * 
 * @copyright  http://www.gnu.org/licenses/lgpl.txt LGPL version 3
 * @author     Erik Bachmann <Erik@ClicketyClick.dk>
 * @since      2026-05-19T08:49:31 / erba
 * @version    2026-05-19T08:49:31
 */

DROP TABLE IF EXISTS time_stamp;

CREATE TEMPORARY TABLE IF NOT EXISTS time_stamp(
    key     TEXT        DEFAULT('starttime'),
    utc     DATETIME    DEFAULT(datetime('subsec')),
    local   DATETIME    DEFAULT(datetime('subsec', 'localtime')),
    PRIMARY KEY ( key )
);

-- Initiate start:
INSERT INTO time_stamp DEFAULT VALUES;

------------------------------------------------------------------------
