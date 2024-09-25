#::**
#:: *   @file       doxyit.py
#:: *   @brief      Insert Doxygen headers
#:: *   @details    Inserting file header or function header
#:: *   
#:: *   @copyright  http://www.gnu.org/licenses/lgpl.txt LGPL version 3
#:: *   @author     User Name <SomeOne@ClicketyClick.dk>
#:: *   @since      2024-09-24T01:16:27 / Bruger
#:: *   @version    2024-09-25T08:17:40
#:: **

import os   # https://docs.python.org/3/library/os.html#os.environ
import re

debug = os.environ.get('DEBUG', False )
verbose = os.environ.get('VERBOSE', False )
#verbose = True
#debug = True
if verbose: print "Verbose ON"
if debug: print "Debugging ON"
#if not debug: print "debugging OFF"

# Gettin cursor line no
current_line_number = editor.lineFromPosition(editor.getCurrentPos()) + 1
if debug: print( "Cursors current_line_number:" + str(current_line_number ) )

# Get name of current file
currentFilename = notepad.getCurrentFilename()

#import os
file_name, file_extension = os.path.splitext(currentFilename);
if debug: print( "currentFilename:"+currentFilename )
if debug: print( "file_name:"+file_name )
if debug: print( "file_extension:"+file_extension )

#----------------------------------------------------------------------
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
    users = os.environ.get('USER', os.environ.get('USERNAME'))
    userdata = config['users'][user]
    # Users email
    return userdata

#----------------------------------------------------------------------

def expandVars( template ):
    template     = template.replace("${START}", config['types'][file_type]['start'])
    template     = template.replace("${END}", config['types'][file_type]['end'])
    template     = template.replace("${LINE}", config['types'][file_type]['line'])
    template     = template.replace("${PREFIX}", config['types'][file_type]['prefix'])
    template     = template.replace("$(ISO8601)", iso)
    template     = template.replace("$(USER)", user)
    template     = template.replace("$(AUTHOR)", userdata['fullname'])
    template     = template.replace("$(EMAIL)", useremail)
    template     = template.replace("$(FILE)", os.path.basename(currentFilename))
    return template

#----------------------------------------------------------------------

# json_file
json_file   = os.path.dirname(__file__) + '/doxyit.json'
config      = getConfig(json_file)

#type_list = ['.py','php']
#result = [ ff for ff in type_list if ff == file_extension]
#if debug: print( "Result:" +repr(result) )

file_type = file_extension[1:]
if debug: print("file_type:"+file_type)

# if file_type == "php":
  # if debug: print("A php script")
  # #doxy = {"start":"/**", "line":" *  ", "prefix":"@", "end":" */"}
# elif file_type == "cmd":
  # if debug: print("A DOS batch")
  # #doxy = {"start":"::**", "line":":: *  ", "prefix":"@", "end":" ::**"}
# elif file_type == "py":
  # if debug: print("Python")
  # #doxy = {"start":"#::**", "line":"#:: *  ", "prefix":"@", "end":"#:: **"}
# else:
  # print("I dont know the file type: ["+file_type+"] from file extention ["+file_extension+"]")



# Get now in ISO 8601 format: YYYY-MM-DDThh:mm:ss
import datetime 
iso = datetime.datetime.now().isoformat()[:19]

userdata = getUserInfo()


if debug: print( "USER:" + userdata['user'] + " email:" + userdata['email']);
if debug: print( "user_full_name:["+userdata['fullname']+"]" )

file_header = expandVars( config['templates']['file'] )
function_header = expandVars( config['templates']['function'] )


if 5 > current_line_number:
    editor.gotoLine(0)
    if debug: print( "Current line number: %d\n%s\n" % (current_line_number, file_header) )
    editor.addText( file_header )
else:
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

    next_line   = editor.getLine( current_line_number )
    
    #import re
    g = re.findall(r'{0}\s*(.*)\((.*)\)'.format(config['types'][file_type]['function']), next_line)

    if g: 
        if debug: print "has function: func name( a, b ) "
    
    if not g:
        if debug: print "has NO function: :name"
        g = re.findall(r'{0}\s*(.*)\s+(.*)'.format(config['types'][file_type]['function']), next_line)

    if not g:
        if debug: "DELIMITER"
        editor.addText( config['types'][file_type]['delimiter'].replace("${LINE}", config['types'][file_type]['line']) )

    else:
        if debug: print( repr(g))

        function    = g[0][0]
        if verbose: print "function: " + function
        elements = g[0][1].replace(' ','').split(',')
        #if verbose: print elements
        #  *  @param [in] $abc    $(Description for $abc)
        config['types'][file_type]['line']

        param           = config['types'][file_type]['param_outer'] % config['types'][file_type]['param_inner'].join(elements)
        param           = param.replace("${LINE}", config['types'][file_type]['line'])
        param           = param.replace("${PREFIX}", config['types'][file_type]['prefix'])
        function_header = function_header.replace('$(FUNCTION)',function)
        function_header = function_header.replace('$(param)',param)
        if debug: print( function_header )

        editor.addText( function_header )

#*** End of File ***
