#::**
#:: *   @file       doxyit.py
#:: *   @brief      Insert Doxygen headers
#:: *   @details    Inserting file header or function header
#:: *   
#:: *   @copyright  http://www.gnu.org/licenses/lgpl.txt LGPL version 3
#:: *   @author     User Name <SomeOne@ClicketyClick.dk>
#:: *   @since      2024-09-24T01:16:27 / Bruger
#:: *   @version    2024-09-26T15:08:20
#:: **

import os   # https://docs.python.org/3/library/os.html#os.environ
import re
import datetime # Get now in ISO 8601 format: YYYY-MM-DDThh:mm:ss
import doxyit_lib

debug   = doxyit_lib.setDebug( 0 )
verbose = doxyit_lib.setVerbose( 0 )

# Get name of current file
currentFilename = notepad.getCurrentFilename()
# Gettin cursor line no
current_line_number = editor.lineFromPosition(editor.getCurrentPos()) + 1
if debug: print( "Cursors current_line_number:" + str(current_line_number ) )

script_file_name, script_file_extension = os.path.splitext(__file__);
file_name, file_extension = os.path.splitext(currentFilename);
file_type = file_extension[1:]

if debug: print( "currentFilename:"+currentFilename )
if debug: print( "file_name:"+file_name )
if debug: print( "file_extension:"+file_extension )

# Read configuration
config  = doxyit_lib.getConfig( script_file_name + ".json" )

# Set global variables
config['globals']   = {}
config['globals']['iso'] = doxyit_lib.getIsoDate()
config['globals']['currentFilename'] = currentFilename
config['globals']['file_type'] = file_type
user        = doxyit_lib.getUserInfo()
userdata    = config['users'][user]
config['globals']['user'] = doxyit_lib.getUserInfo()

if debug: print "isodate: "+config['globals']['iso']

if debug: print "File_type: "+file_type
if debug: print "file.config: "
if debug: print config['types'][file_type]
if debug: print "----"
header_zone = config['types'][file_type]['header_zone'] or 3
if debug: print "header_zone: " + str(header_zone)

if debug: print( userdata );
if debug: print( "USER:" + userdata['name'] + " email:" + userdata['email']);
if debug: print( "user_full_name:["+userdata['fullname']+"]" )

# Expand headers
if 'file_template' in config['types'][file_type]:    # Hack for JSON
    config['templates']['file'] = config['types'][file_type]['file_template']
if 'function_template' in config['types'][file_type]:    # Hack for JSON
    config['templates']['function'] = config['types'][file_type]['function_template']

file_header     = doxyit_lib.expandVars( config['templates']['file'], config )
function_header = doxyit_lib.expandVars( config['templates']['function'], config )

#>>> Functions --------------------------------------------------------

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

#<<< Functions --------------------------------------------------------


if header_zone > current_line_number:
    # At top of file insert header
    editor.gotoLine(0)
    if debug: print( "Current line number: %d\n%s\n" % (current_line_number, file_header) )
    editor.addText( file_header )
else:
    #next_line = doxyit_lib.getNextLine()
    next_line = getNextLine()
    
    #import re
    g = re.findall(r'{0}\s*(.*)\((.*)\)'.format(config['types'][file_type]['function']), next_line)

    
    if not g:
        if debug: print "has NO function: :name"
        g = re.findall(r'{0}\s*(.*)\s+(.*)'.format(config['types'][file_type]['function']), next_line)

    if not g:   # Insert delimiter
        if debug: "DELIMITER"
        editor.addText( doxyit_lib.expandVars( config['types'][file_type]['delimiter'], config ) )
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
