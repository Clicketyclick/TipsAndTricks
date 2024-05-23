/**
 *  @file      profiler_init.sql
 *  @brief     Initiating profiler by creating tables 
 *  
 *  @details   Create tables (if not exists)
 *      variables   Temporary variables (like 'profiler_id')
 *      profiler    Log data for profiling
 *  @copyright http://www.gnu.org/licenses/lgpl.txt LGPL version 3
 *  @author    Erik Bachmann <ErikBachmann@ClicketyClick.dk>
 *  @since     2024-05-23T08:16:36 / erba
 *  @version   2024-05-23T08:16:36
 */

.print -- Initiating profiler by creating tables
.header on

-- Create tables
-- DROP TABLE profiler;
CREATE TABLE IF NOT EXISTS variables (key TEXT PRIMARY KEY, value TEXT);
CREATE TABLE IF NOT EXISTS profiler(
    id          TEXT PRIMARY KEY,
    start       TEXT DEFAULT (STRFTIME('%Y-%m-%d %H:%M:%f', 'NOW')),
    end         TEXT DEFAULT NULL,
    diff        TEXT DEFAULT NULL
);

-- Clear data
DELETE FROM profiler;

.schema profiler

-- EOF -----------------------------------------------------------------