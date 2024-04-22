@ECHO OFF
/**
 *  @file      tail.bat
 *  @brief     Print the last 30 lines of each FILE to standard output.
 *  
 *  @details   output appended data as the file grows
 *  
 *  @copyright http://www.gnu.org/licenses/lgpl.txt LGPL version 3
 *  @author    Erik Bachmann <ErikBachmann@ClicketyClick.dk>
 *  @since     2024-04-22T09:21:01 / erba
 *  @version   2024-04-22T09:21:01
 */
SET _FILE=%1
SET _LINENO=%2

IF NOT DEFINED _LINE SET _LINE=%~f0
IF NOT DEFINED _LINENO SET _LINENO=30

call powershell -command Get-Content %_FILE% -Wait -Tail %_LINENO%
