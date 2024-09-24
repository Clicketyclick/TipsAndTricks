#::**
#:: *   @file       doxyit.py
#:: *   @brief      Insert Doxygen headers
#:: *   @details    Inserting file header or function header
#:: *   
#:: *   @copyright  http://www.gnu.org/licenses/lgpl.txt LGPL version 3
#:: *   @author     User Name <SomeOne@ClicketyClick.dk>
#:: *   @since      2024-09-24T01:16:27 / Bruger
#:: *   @version    2024-09-24T08:50:35
#:: **

import os   # https://docs.python.org/3/library/os.html#os.environ
import re


#debug = os.environ.get('DEBUG', False )
verbose = False
debug = False
#verbose = True
#debug = True
if verbose: print "Verbose ON"
if debug: print "debugging ON"
if not debug: print "debugging OFF"

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

# json_file
#os.path.basename(__file__)
json_file   = os.path.dirname(__file__) + '/doxyit.json'
if debug: print( "json_file: " + json_file )

import json
# load JSON
json_data   = open (json_file).read()
# Parse JSON
config      = json.loads( json_data )
if debug: print( config['title'] )


type_list = ['.py','php']

result = [ ff for ff in type_list if ff == file_extension]

if debug: print( "Result:" +repr(result) )

file_type = file_extension[1:]
if debug: print("file_type:"+file_type)
if file_type == "php":
  if debug: print("A php script")
  #doxy = {"start":"/**", "line":" *  ", "prefix":"@", "end":" */"}
elif file_type == "cmd":
  if debug: print("A DOS batch")
  #doxy = {"start":"::**", "line":":: *  ", "prefix":"@", "end":" ::**"}
elif file_type == "py":
  if debug: print("Python")
  #doxy = {"start":"#::**", "line":"#:: *  ", "prefix":"@", "end":"#:: **"}
else:
  print("I dont know the file type: ["+file_type+"] from file extention ["+file_extension+"]")


# template = {"file":"""${START}
# ${LINE} ${PREFIX}file       $(FILE)
# ${LINE} ${PREFIX}brief      $(Brief description)
# ${LINE} ${PREFIX}details    $(More details)
# ${LINE} 
# ${LINE} ${PREFIX}copyright  http://www.gnu.org/licenses/lgpl.txt LGPL version 3
# ${LINE} ${PREFIX}author     $(author) $(email)
# ${LINE} ${PREFIX}since      $(ISO8601) / $(user)
# ${LINE} ${PREFIX}version    $(ISO8601)
# ${END}
# """
# , "function":"""${START}
# ${LINE} ${PREFIX}fn         $(FILE) template"
# ${LINE} ${PREFIX}brief      $(Brief description)
# ${LINE}
# ${LINE} ${PREFIX}since      $(ISO8601) / $(USER)
# ${LINE} ${PREFIX}version    $(ISO8601)
# ${END}"""
# }

#print( json_data )


# Dump
#print( "config"+repr(config) )


# Get now in ISO 8601 format: YYYY-MM-DDThh:mm:ss
import datetime
iso = datetime.datetime.now().isoformat()[:19]
#user = os. getlogin()
# Get USER or USERNAME from env
user = os.environ.get('USER', os.environ.get('USERNAME'))
userdata = config['users'][user]

user = config['users'][user]['name']
# Users email
#useremail   = os.environ.get('USEREMAIL', 'someone@somewhere.com')
#useremail   = config['users'][user]['email']
useremail   = userdata['email']


if debug: print( "USER:" + user + " email:" + useremail);

# Get user name
#import getpass
#user = getpass.getuser()
#print( "user:"+user )

# Get user full name 
#import subprocess
#net_user= subprocess.check_output(['net', 'user', 'bruger'])
#user_full_name = net_user.splitlines()[1]
#user_full_name = user_full_name[30:].strip()
user_full_name = config['users'][user]['fullname']
if debug: print( "user_full_name:["+user_full_name+"]" )

file_header     = config['templates']['file']
file_header     = file_header.replace("${START}", config['types'][file_type]['start'])
file_header     = file_header.replace("${END}", config['types'][file_type]['end'])
file_header     = file_header.replace("${LINE}", config['types'][file_type]['line'])
file_header     = file_header.replace("${PREFIX}", config['types'][file_type]['prefix'])
file_header     = file_header.replace("$(ISO8601)", iso)
file_header     = file_header.replace("$(USER)", user)
file_header     = file_header.replace("$(AUTHOR)", user_full_name)
file_header     = file_header.replace("$(EMAIL)", useremail)
file_header     = file_header.replace("$(FILE)", os.path.basename(currentFilename))

function_header = config['templates']['function']
function_header = function_header.replace("${START}", config['types'][file_type]['start'])
function_header = function_header.replace("${END}", config['types'][file_type]['end'])
function_header = function_header.replace("${LINE}", config['types'][file_type]['line'])
function_header = function_header.replace("${PREFIX}", config['types'][file_type]['prefix'])
function_header = function_header.replace("$(ISO8601)", iso)
function_header = function_header.replace("$(USER)", user)
function_header = function_header.replace("$(AUTHOR)", user_full_name)
function_header = function_header.replace("$(FILE)", os.path.basename(currentFilename))

if 5 > current_line_number:
    editor.gotoLine(0)
    if debug: print( "Current line number: %d\n%s\n" % (current_line_number, file_header) )
    editor.addText( file_header )
else:
    #editor.lineFromPosition(pos) 
    #SCI_LINEFROMPOSITION(scn.position+scn.length-1)
    #next_line   = editor.getLine( current_line_number )
    # Catch if last line of file!
    #
    # save current position
    currentPos  = editor.getCurrentPos() 
    # Go to document end
    editor.documentEnd()
    last_line_number = editor.lineFromPosition(editor.getCurrentPos()) + 1
    editor.gotoPos( currentPos )
    #max_line = editor.getMaxLineState() 
    #editor.documentEnd()
    print "next: %d of %d " % (current_line_number, last_line_number)
    if current_line_number == last_line_number:
        current_line_number -= 2

    next_line   = editor.getLine( current_line_number )
    
    #import re
    #g = re.findall(r'def\s+(.*)\((.*)\)', next_line)
    g = re.findall(r'{0}\s*(.*)\((.*)\)'.format(config['types'][file_type]['function']), next_line)

    if g: 
        if debug: print "has function: func name( a, b ) "
    
    if not g:
        if debug: print "has NO function: :name"
        g = re.findall(r'{0}\s*(.*)\s+(.*)'.format(config['types'][file_type]['function']), next_line)

    if not g:
        print "DELIMITER"
        editor.addText( config['types'][file_type]['delimiter'] )

    else:
        if debug: print( repr(g))

        function    = g[0][0]
        if verbose: print "function: " + function
        elements = g[0][1].replace(' ','').split(',')
        #if verbose: print elements
        #  *  @param [in] $abc    $(Description for $abc)
        config['types'][file_type]['line']

        #param = "${LINE} ${PREFIX}param [in]\t%s\t$(description)" % "\t$(description)\n${LINE} ${PREFIX}param [in]\t".join(elements)
        param           = config['types'][file_type]['param_outer'] % config['types'][file_type]['param_inner'].join(elements)
        param           = param.replace("${LINE}", config['types'][file_type]['line'])
        param           = param.replace("${PREFIX}", config['types'][file_type]['prefix'])
        function_header = function_header.replace('$(FUNCTION)',function)
        function_header = function_header.replace('$(param)',param)
        if debug: print( function_header )

        editor.addText( function_header )

#*** End of File ***
