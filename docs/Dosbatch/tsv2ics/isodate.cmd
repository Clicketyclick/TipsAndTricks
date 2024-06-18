@ECHO OFF
setlocal
::::
 ::  @file      isodate.cmd
 ::  @brief     Print current date and time in ISO 86001 (YYYY-MM-MM@hh:mm:ss)
 ::  
 ::  @details   Alternate format string can be given as argument
 ::
 ::  @example   isodate %Y-%m-%d
 ::  @example   isodate %Y-%m-%dT%H:%M:%S.000Z
 ::  @example   isodate %Y%m%dT%H%M%SZ
 ::  
 ::  @copyright http://www.gnu.org/licenses/lgpl.txt LGPL version 3
 ::  @author    Erik Bachmann <ErikBachmann@ClicketyClick.dk>
 ::  @since     2024-06-17T15:00:31 / erba
 ::  @version   2024-06-17T15:00:31
 ::


SET datemask=%~1
IF NOT DEFINED datemask SET datemask=%%Y-%%m-%%dT%%H:%%M:%%S.000Z

powershell.exe -noprofile -command "Get-Date (Get-Date).ToUniversalTime() -UFormat '+%datemask%';"

::*** EOF ***