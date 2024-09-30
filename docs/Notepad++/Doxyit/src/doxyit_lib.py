#::**
#:: *   @file       doxyit_lib.py
#:: *   @brief      Subfunction for doxyit
#:: *   @details    
#:: *   
#:: *   @copyright  http://www.gnu.org/licenses/lgpl.txt LGPL version 3
#:: *   @author     Erik Bachmann <Erik@ClicketyClick.dk>
#:: *   @since      2024-09-24T22:00:00 / ErBa
#:: *   @version    2024-09-27T20:33:23
#:: **

import os   # https://docs.python.org/3/library/os.html#os.environ
import re

debug=False
verbose=False

#::**
#:: *   @fn         getConfig
#:: *   @brief      Read configuration from JSON
#:: *   
#:: *   @param [in]	json_file	File name
#:: *   @return     Configuration as struct
#:: *   
#:: *   @details    
#:: *   
#:: *   @example    
#:: *   
#:: *   @todo       
#:: *   @bug        
#:: *   @warning    
#:: *   
#:: *   @see        https://
#:: *   @since      2024-09-25T07:57:44
#:: **
def getConfig(json_file):
    if debug: print( "json_file: " + json_file )

    import json
    # load JSON
    json_data   = open (json_file).read()
    # Parse JSON
    config      = json.loads( json_data )
    if debug: print( "debug Title from config" + config['title'] )
    
    return( config )

#----------------------------------------------------------------------

#::**
#:: *   @fn         getUserInfo
#:: *   @brief      Get logged in user name
#:: *   
#:: *   @return     User ID
#:: *   
#:: *   @details    
#:: *   
#:: *   @example    
#:: *   
#:: *   @todo       
#:: *   @bug        
#:: *   @warning    
#:: *   
#:: *   @see        https://
#:: *   @since      2024-09-26T13:58:22
#:: **
def getUserInfo():
    # Get user info
    
    #user = os. getlogin()
    # Get USER or USERNAME from env
    user = os.environ.get('USER', os.environ.get('USERNAME'))
    # Users 
    return user

#----------------------------------------------------------------------

#::**
#:: *   @fn         expandVars
#:: *   @brief      Expand variables in string
#:: *   
#:: *   @param [in]	template	The template string to expand
#:: *   @param [in]	config	The configuration structure
#:: *   @return     Expanded template
#:: *   
#:: *   @details    
#:: *   
#:: *   @example    
#:: *   
#:: *   @todo       
#:: *   @bug        
#:: *   @warning    
#:: *   
#:: *   @see        https://
#:: *   @since      2024-09-26T13:58:50
#:: **
def expandVars( template, config ):
    file_type       = config['globals']['file_type']
    user            = config['globals']['user']
    userdata        = config['users'][user]

    template        = template.replace("${START}",     config['types'][file_type]['start'] or "" )
    template        = template.replace("${END}",       config['types'][file_type]['end'] or "" )
    template        = template.replace("${LINE}",      config['types'][file_type]['line'] or "" )
    template        = template.replace("${PREFIX}",    config['types'][file_type]['prefix'] or "" )

    template        = template.replace("${FILE_PREFIX}", (config['types'][file_type]['file_prefix'] or "" ) )
    template        = template.replace("${FILE_SUFFIX}", config['types'][file_type]['file_suffix'] or "" )
    
    template        = template.replace("${FUNCTION_PREFIX}", config['types'][file_type]['function_prefix'] or "" )
    template        = template.replace("${FUNCTION_SUFFIX}", config['types'][file_type]['function_suffix'] or "" )
    template        = template.replace("${COMMENT_PREFIX}", config['types'][file_type]['comment_prefix'] or "" )

    template        = template.replace("${ISO8601}",   config['globals']['iso'] or "No date")

    template        = template.replace("${USER}",      userdata['name'] or "unknown" or "" )
    template        = template.replace("${AUTHOR}",    userdata['fullname'] or "unknown" or "" )
    template        = template.replace("${EMAIL}",     userdata['email'] or "unknown" or "" )

    path, file_name = os.path.split( config['globals']['currentFilename'] );
    template        = template.replace("${FILE}", file_name )  #os.path.basename(currentFilename))
                                                                                           
    return template

#----------------------------------------------------------------------

#::**
#:: *   @fn         getNextLine
#:: *   @brief      Get the next line from current window
#:: *   
#:: *   @return     The next line
#:: *   
#:: *   @details    $(More details)
#:: *   
#:: *   @example    
#:: *   
#:: *   @todo       
#:: *   @bug        
#:: *   @warning    
#:: *   
#:: *   @see        https://
#:: *   @since      2024-09-26T13:58:58
#:: **
def getNextLine():
    ## At end of file?
    # Gettin cursor line no
    current_line_number = editor.lineFromPosition(editor.getCurrentPos()) + 1
    # save current position
    currentPos  = editor.getCurrentPos() 
    # Go to document end
    editor.documentEnd()
    last_line_number = editor.lineFromPosition(editor.getCurrentPos()) + 1
    editor.gotoPos( currentPos )
    #max_line = editor.getMaxLineState() 
    #editor.documentEnd()
    if debug: print "next: %d of %d " % (current_line_number, last_line_number)
    if current_line_number == last_line_number:
        current_line_number -= 2
    ## At end of file?

    next_line   = editor.getLine( current_line_number )
    return next_line

#----------------------------------------------------------------------

#::**
#:: *   @fn         getIsoDate
#:: *   @brief      Get current date and time in ISO-8601
#:: *   
#:: *   @return     Date string
#:: *   
#:: *   @details    
#:: *   
#:: *   @example    
#:: *   
#:: *   @todo       
#:: *   @bug        
#:: *   @warning    
#:: *   
#:: *   @see        https://
#:: *   @since      2024-09-26T13:59:03
#:: **
def getIsoDate():
    import datetime 
    return datetime.datetime.now().isoformat()[:19]

#----------------------------------------------------------------------


#::**
#:: *   @fn         setDebug
#:: *   @brief      Set debug flag
#:: *   
#:: *   @param [in]	flag	False = no info / True Show debug info
#:: *   @return     Debug level
#:: *   
#:: *   @details    Used for debugging
#:: *   
#:: *   @example    
#:: *   
#:: *   @todo       
#:: *   @bug        
#:: *   @warning    
#:: *   
#:: *   @see        https://
#:: *   @since      2024-09-26T13:59:06
#:: **
def setDebug( flag ):
    global debug
    #if not flag: flag = False
    debug = os.environ.get('DEBUG', False )
    if not debug: debug = flag
    if debug: print "Debugging ON"
    return debug

#----------------------------------------------------------------------

#::**
#:: *   @fn         setVerbose
#:: *   @brief      Set verbose flag
#:: *   
#:: *   @param [in]	flag	False = no info / True Show verbose info
#:: *   @return     Verbose flag
#:: *   
#:: *   @details    Use for getting more bla-bla from script
#:: *   
#:: *   @example    
#:: *   
#:: *   @todo       
#:: *   @bug        
#:: *   @warning    
#:: *   
#:: *   @see        https://
#:: *   @since      2024-09-26T13:59:13
#:: **
def setVerbose( flag ):
    global verbose
    #if not flag: flag = True
    verbose = os.environ.get('VERBOSE', False )
    if not verbose: verbose = flag
    if verbose: print "Verbose ON"
    return verbose

#----------------------------------------------------------------------

#::**
#:: *   @fn         in_array
#:: *   @brief      Checks if a value exists in an array
#:: *   
#:: *   in_array(mixed $needle, array $haystack, bool $strict = false): bool
#:: *   
#:: *   @param [in]	needle	$(description)
#:: *   @param [in]	haystack	$(description)
#:: *   @return     $(Return description)
#:: *   
#:: *   @details    Mimicks the PHP function
#:: *   
#:: *   @example    
#:: *       lst = ['123hello123', 'aasdasdasd123hello123', '123123hello']
#:: *       type = '123123hello'
#:: *       print "OK\t" + type + ":\t" 
#:: *       print checkFunctionType( lst, type )
#:: *       
#:: *       type = 'world'
#:: *       print "FAIL\t" + type + ":\t" 
#:: *       print checkFunctionType( lst, type )
#:: *       
#:: *   
#:: *   @todo       
#:: *   @bug        
#:: *   @warning    
#:: *   
#:: *   @see        https://
#:: *   @since      2024-09-30T16:43:25
#:: **
def in_array( needle, haystack ):
    status = False

    if any( needle in x for x in haystack):
        status = True

    return( status )

#----------------------------------------------------------------------


# https://stackoverflow.com/a/18853493

# Getting parameters for functions in current library

#def getConfig(json_file):
if __name__ == '__getConfig__':
    getConfig(sys.argv[0])

#def expandVars( template ):
if __name__ == '__expandVars__':
    expandVars(sys.argv[0], sys.argv[1])

if __name__ == '__setDebug__':
    expandVars(sys.argv[0])

if __name__ == '__setVerbose__':
    expandVars(sys.argv[0])
    
if __name__ == '__in_array__':
    in_array( sys.argv[0], sys.argv[1] )
