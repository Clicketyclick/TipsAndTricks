::** 
:: * @file      _debug.cmd
:: * @brief     Setup Verbose, Debug and Logging
:: * 
:: * @details   Envionment variables: verbose=[0/1], debug=[0/1], logging=[filename]
:: * @  __VERBOSE__     Verbose msg to STDERR
:: * @  __DEBUG__       Debug info to STDERR
:: * @  __LOGGING__     Log to file
:: * @copyright http://www.gnu.org/licenses/lgpl.txt LGPL version 3
:: * @author    Erik Bachmann <ErikBachmann@ClicketyClick.dk>
:: * @since     2024-09-20T22:52:29 / erba
:: * @version   2024-09-20T22:52:29
:: **

::>>> _Debug -----------------------------------------------------------
:: Default: No debug or verbose
@SET __DEBUG__=::&SET __VERBOSE__=::&SET __LOGGING__=::&:: Default: No debug or verbose
:: Verbose
@IF DEFINED verbose  IF NOT [0]==[%verbose%]     SET __VERBOSE__=1^>^&2 ECHO:-
:: Logging: Clear and append
@IF DEFINED logging  IF NOT [0]==[%logging%] (   SET __LOGGING__=1^>^>"%logging%" ECHO:LOG:&IF EXIST "%logging%" DEL "%logging%" )
:: Debug - and Verbose
@IF DEFINED debug    IF NOT [0]==[%debug%]   (   SET __VERBOSE__=1^>^&2 ECHO:-&SET __DEBUG__=1^>^&2 ECHO:DEBUG:)
::<<< _Debug -----------------------------------------------------------

:: *** End of File ***
