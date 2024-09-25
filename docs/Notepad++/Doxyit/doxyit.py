#::**
#:: *   @file       doxyit.py
#:: *   @brief      Insert Doxygen headers
#:: *   @details    Inserting file header or function header
#:: *   
#:: *   @copyright  http://www.gnu.org/licenses/lgpl.txt LGPL version 3
#:: *   @author     User Name <SomeOne@ClicketyClick.dk>
#:: *   @since      2024-09-24T01:16:27 / Bruger
#:: *   @version    2024-09-25T10:39:39
#:: **

import os   # https://docs.python.org/3/library/os.html#os.environ
import re

# Debugging and verbose
debug = os.environ.get('DEBUG', False )
verbose = os.environ.get('VERBOSE', False )
verbose = True
debug = True
if verbose: print "Verbose ON"
if debug: print "Debugging ON"

# Gettin cursor line no
current_line_number = editor.lineFromPosition(editor.getCurrentPos()) + 1
if debug: print( "Cursors current_line_number:" + str(current_line_number ) )

# Get name of current file
currentFilename = notepad.getCurrentFilename()

#import os
script_file_name, script_file_extension = os.path.splitext(__file__);
file_name, file_extension = os.path.splitext(currentFilename);
file_type = file_extension[1:]

if debug: print( "currentFilename:"+currentFilename )
if debug: print( "file_name:"+file_name )
if debug: print( "file_extension:"+file_extension )

#>>> Functions --------------------------------------------------------

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
    if debug: print( config['title'] )
    return( config )

#----------------------------------------------------------------------
def getUserInfo():
    # Get user info
    
    #user = os. getlogin()
    # Get USER or USERNAME from env
    user = os.environ.get('USER', os.environ.get('USERNAME'))
    userdata = config['users'][user]
    # Users email
    return userdata

#----------------------------------------------------------------------

def expandVars( template ):
    template     = template.replace("${START}",     config['types'][file_type]['start'] or "" )
    template     = template.replace("${END}",       config['types'][file_type]['end'] or "" )
    template     = template.replace("${LINE}",      config['types'][file_type]['line'] or "" )
    template     = template.replace("${PREFIX}",    config['types'][file_type]['prefix'] or "" )

    template     = template.replace("${FILE_PREFIX}", (config['types'][file_type]['file_prefix'] or "" ) )
    template     = template.replace("${FILE_SUFFIX}", config['types'][file_type]['file_suffix'] or "" )
    
    template     = template.replace("${FUNCTION_PREFIX}", config['types'][file_type]['function_prefix'] or "" )
    template     = template.replace("${FUNCTION_SUFFIX}", config['types'][file_type]['function_suffix'] or "" )
    template     = template.replace("${COMMENT_PREFIX}", config['types'][file_type]['comment_prefix'] or "" )

    template     = template.replace("${ISO8601}",   iso)

    template     = template.replace("${USER}",      userdata['name'] or "unknown" or "" )
    template     = template.replace("${AUTHOR}",    userdata['fullname'] or "unknown" or "" )
    template     = template.replace("${EMAIL}",     userdata['email'] or "unknown" or "" )

    template     = template.replace("${FILE}",  os.path.basename(currentFilename))
    return template

#----------------------------------------------------------------------

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
#<<< Functions --------------------------------------------------------

config  = getConfig( script_file_name + ".json" )

print "File_type: "+file_type
print "file.config: "
print config['types'][file_type]
print "----"
header_zone = config['types'][file_type]['header_zone'] or 3
print "header_zone: " + str(header_zone)

userdata    = getUserInfo()
if debug: print( userdata );
if debug: print( "USER:" + userdata['name'] + " email:" + userdata['email']);
if debug: print( "user_full_name:["+userdata['fullname']+"]" )

# Expand headers
file_header     = expandVars( config['templates']['file'] )
function_header = expandVars( config['templates']['function'] )

if header_zone > current_line_number:
    # At top of file insert header
    editor.gotoLine(0)
    if debug: print( "Current line number: %d\n%s\n" % (current_line_number, file_header) )
    editor.addText( file_header )
else:
    next_line = getNextLine()
    
    #import re
    g = re.findall(r'{0}\s*(.*)\((.*)\)'.format(config['types'][file_type]['function']), next_line)

    
    if not g:
        if debug: print "has NO function: :name"
        g = re.findall(r'{0}\s*(.*)\s+(.*)'.format(config['types'][file_type]['function']), next_line)

    if not g:   # Insert delimiter
        if debug: "DELIMITER"
        editor.addText( expandVars( config['types'][file_type]['delimiter'] ) )
    else:       # Insert function header
        if debug: print "has function: func name( a, b ) "
        if debug: print( repr(g))

        function    = g[0][0]
        if verbose: print "function: " + function
        elements = g[0][1].replace(' ','').split(',')

        #  *  @param [in] $abc    $(Description for $abc)
        config['types'][file_type]['line']

        param           = config['types'][file_type]['param_outer'] % config['types'][file_type]['param_inner'].join(elements)
        param           = param.replace("${LINE}", config['types'][file_type]['line'])
        param           = param.replace("${PREFIX}", config['types'][file_type]['prefix'])
        function_header = function_header.replace('${FUNCTION}',function)
        function_header = function_header.replace('${PARAM}',param)
        if debug: print( function_header )

        editor.addText( function_header )

#*** End of File ***
