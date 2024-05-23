/**
 *  @file      profiler_list.sql
 *  @brief     Listing profiling
 *  
 *  @details   
 *
 *  @copyright http://www.gnu.org/licenses/lgpl.txt LGPL version 3
 *  @author    Erik Bachmann <ErikBachmann@ClicketyClick.dk>
 *  @since     2024-05-23 08:59:11 / erba
 *  @version   2024-05-23 08:59:11
 */

.print -- Listing profiling
.header on
--.header off
.mode box

SELECT * FROM profiler ORDER BY start;

-- EOF -----------------------------------------------------------------