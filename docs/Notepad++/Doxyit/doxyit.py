

# Call a Scintilla function

# Save the file
#newFilename = notepad.getCurrentFilename() + ".php"
newFilename = notepad.getCurrentFilename() + ".py"
#editor.appendText(newFilename);

import os
filename, file_extension = os.path.splitext(newFilename);
#editor.appendText(file_extension);

print( file_extension )


# json_file
json_file   = notepad.getCurrentFilename()
json_file, file_extension = os.path.splitext(json_file);
json_file   = json_file + '.json'
print( "json_file: " + json_file )

import json
# load JSON
json_data   = open (json_file).read()
# Parse JSON
config      = json.loads( json_data )
print( config['title'] )


type_list = ['.py','php']

#if file_extension in type_list:
#    print( "Found: "+item
#else:
#    print( "NOT Found: "+item


#[f(file_extension) if print( "Found: "+item else  print( "NOT Found: "+item for file_extension in type_list]


#[f(file_extension) if file_extension is not None else 'OK' for file_extension in type_list]

#print ( [if file_extension is not None else 'OK' for file_extension in type_list] )

result = [ ff if file_extension  == ff else False for ff in type_list]
#result = [ ff if file_extension  == ff for ff in type_list]
result = [ ff for ff in type_list if ff == file_extension]

print( repr(result) )
#print("Result:" +result)

if file_extension == ".php":
  print("A php script")
  doxy = {"start":"/**", "line":" *  ", "prefix":"@", "end":" */"}
elif file_extension == ".cmd":
  print("A DOS batch")
  doxy = {"start":"::**", "line":":: *  ", "prefix":"@", "end":" ::**"}
elif file_extension == ".py":
  print("Python")
  doxy = {"start":"#::**", "line":"#:: *  ", "prefix":"@", "end":"#:: **"}
else:
  print("I dont know")


template = {"file":"""${START}
${LINE} ${PREFIX}file       $(FILE)
${LINE} ${PREFIX}brief      $(Brief description)
${LINE} ${PREFIX}details    $(More details)
${LINE} 
${LINE} ${PREFIX}copyright  http://www.gnu.org/licenses/lgpl.txt LGPL version 3
${LINE} ${PREFIX}author     $(author) $(email)
${LINE} ${PREFIX}since      $(ISO8601) / $(user)
${LINE} ${PREFIX}version    $(ISO8601)
${END}
"""
, "function":"""${START}
${LINE} ${PREFIX}fn         $(FILE) template"
${LINE} ${PREFIX}brief      $(Brief description)
${LINE}
${LINE} ${PREFIX}since      $(ISO8601) / $(USER)
${LINE} ${PREFIX}version    $(ISO8601)
${END}"""
}

#print( json_data )


# Dump
#print( repr(config) )



#import datetime
#iso = datetime.datetime.now().isoformat()
##user = os. getlogin()
#print os.environ.get('USER', os.environ.get('USERNAME'))
#import getpass
#user = getpass.getuser()
#print template['file'].replace("${START}", doxy['start']).replace("${END}", doxy['end']).replace("${LINE}", doxy['line']).replace("${PREFIX}", doxy['prefix']).replace("$(ISO)", iso).replace("$(USER)", user).replace("$(FILE)", os.path.basename(newFilename))

