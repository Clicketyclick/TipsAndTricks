# DoxyIT - Script for insert Doxygen headers

A Python Script for inserting commenting blocks for file header, 
function header and delimiter using Python Script 2.0 for Notepad++.

It's inspired by [dail8859](https://github.com/dail8859)'s [DoxyIt @@Doxyit_logo@@](https://github.com/dail8859/DoxyIt)
which had the simple ablillity to insert file and function headers by hotkey formatted by file extention.

> "This also provides helpful features for creating and editing comment blocks, even if Doxygen isn't desired."

The setup has the following elements:

File| Function
--|--
[doxyit.py](doxyit.py) 		| The script it self
[doxyit.json](doxyit.json)	| Configuration
[doxyit_lib.py](doxyit_lib.py)	| A function library for the script

Test files:

File| Function
---|---
[test.cmd](test.cmd)	| DOS batch
[test.php](test.php)	| PHP
[test.py](test.py)	| Python

## A Word of Advice

> ⚠️ WARNING
> 
> This IS my first Python 2 script and I'm not familiar with Python scripting.
>
> I did NOT read the documentation (who does??!) but build this script entirely out of my head and using intense searches on the web. 
> So suggestions are wellcome!
>
> Many thanks to [Stackoverflow @@Stackoverflow_icon@@](https://stackoverflow.com)


## Installing DoxyIT

0. Install **Notepad++** and fire up ;-)
1. Install **Python Script** for NotePad++
2. Download the scripts and configuration JSON - and place them in the script directory
3. Restart NotePad++
4. Add a hotkey for DoxyIt.

And you're good to go.

### Details of installations

#### Install **Notepad++**

1. Select a package from [Notepad++ Downloads](https://notepad-plus-plus.org/downloads/)
2. Install the package
3. And fire up ;-)

> 🚨 CAUTION
> 
> IF you're dazed and confused at this point - don't go any further!

#### Install **Python Script** for NotePad++

In Notpad++ select in menu:

1. `Plugins` / `Plugins Admin...`
2. Search for "PythonScript" and you'll find:
    > Python Script plugin.
    > 
    > Author: Dave Brotherstone + Jocelyn Legault
    > 
    > Homepage: https://github.com/bruderstein/PythonScript
3. Select the pachage and press <kbd>Install</kbd>
4. Answer <kbd>Yes</kbd> the the question on restarting Notepad++
5. Notepad Plugin Admin will now download and install the plugin.

Ready to Rock'n'Roll!

#### Download the script and configuration

Run as Admin!

1. Select in menu:
    1. `Plugins` / `Python Script` / `Show console` (You'll like this for debugging)
    2. `Plugins` / `Python Script` / `New script` - to create your first script 
2. Go to https://clicketyclick.github.io/TipsAndTricks/Notepad++/Doxyit/
    1. Copy the content of [doxyit.json](https://clicketyclick.github.io/TipsAndTricks/Notepad++/Doxyit/doxyit.json)

Download the scripts and configuration JSON and place them in the script directory

1. Go to `Plugins` / `Python Script` / `Configuration`
2. The script `doxyit.py` will be visible in the top window
3. Select the script and press <kbd>Add</kbd> at the left window named "Menu Items"
4. Finish by pressing <kbd>OK</kbd>
5. Restart NotePad++

The script Doxyit now appearce directly in the Python Script menu (`Plugins` / `Python Script`)

#### Add a hotkey for DoxyIt.

In general: [How do I run specific script with a keyboard shortcut?](https://community.notepad-plus-plus.org/post/28150) / Scott Sumner


> Go to Plugins (menu) -> Python Script -> Configuration. The Python Script Shortcut Configuration window will appear.
>
> In the Scripts area at the top of the Python Script Shortcut Configuration window, locate and select the script you want to bind to a shortcut (and/or toolbar button).
>
> Between the Scripts box and the Menu items (or Toolbar icons) caption there is an Add button. To get your script added as a menu item (necessary to bind a keycombo to it via the “Shortcut Mapper”), press the Add button (the one above the Menu items caption). Very similar but hopefully obvious what to do for a toolbar button.
>
> Once you click OK to dismiss the Python Script Shortcut Configuration window, you should be able to go into Plugins (menu) -> Python Script (just point to that and let the menu cascade open) and then see your script at this level of the menu (between the Scripts-> and Configuration entries). Seeing your script appear here is key to being able to tie it to a shortcut keycombo.
>
> Restart Notepad++.
> This allows the “Shortcut Mapper” to see that you’ve changed the Plugins (menu) -> Python Script menu contents.
>
> Now go to Settings (menu) -> Shortcut Mapper… and select the Plugin commands tab. Scrolling down somewhat you should see your script in the Name column (along with “Pythonscript” in the Plugin column). Go ahead and select your script and assign a keycombo to it just like you would for any other command.

1. In "Filter": type "doxyit" and the matching entries will be presented
2. Select "doxyit" and press <kbd>Modify</kbd>
3. Personally I select <kbd>⇧ Shift</kbd><kbd>⌃ Control</kbd><kbd>D</kbd>
4. Make sure that there are no conflicting sequenses

<!--

### Paths and files

- 64bit version:
`"%ProgramFiles%\Notepad++\plugins\PythonScript\scripts"

- 32bit version:
"%ProgramFiles(x86)%\Notepad++\plugins\PythonScript\scripts"`

Script and configuration
- `"%APPDATA%\Notepad++\plugins\Config\PythonScript\scripts\doxyit.json"`
- `"%APPDATA%\Notepad++\plugins\Config\PythonScript\scripts\doxyit.py"`

-->


## Using DoxyIT

1. Open a new file in NotePad++ and save it with the prefix, that tell DoxyIT which format to use:
    - `.c`      C
    - `.php`    PHP
    - `.cmd`    WinDo$ Batch
    - `.py`     Python
2. Press the hotkey at the top of the file and DoxyIT inserts a file header template.
3. Start your happy scripting - and when you create a subfunction 
4. place the cursor at the end of the line ABOVE the function definition - and press the hotkey again and a function header template is inserted.
5. As code pile up you can insert a separator line anywhere in you code (Except from the line above a function definition - and the first 5 lines of the script). Pres the hotkey and a separator line is inserted.

### Or in more detail

A php script could look like this:

```php
<?php

function test( $one, $two ){
	
}

```

Place the cursor at the top of the file and press the hotkey:

```php
<?php
/**
 *   @file       test.php
 *   @brief      $(Brief description)
 *   @details    $(More details)
 *   
 *   @copyright  http://www.gnu.org/licenses/lgpl.txt LGPL version 3
 *   @author     Erik Bachmann <Erik@ClicketyClick.dk>
 *   @since      2024-09-26T15:23:32 / erba
 *   @version    2024-09-26T15:23:32
 */
//<?php

function test( $one, $two ){
	
}

```

A file header is inserted at the top of the file. 
Note that the original `<?php` is now trailing the header.

You may now update the header (especially the tokens `$(Brief description)` and `$(More details)`

Move your cursor to the line just above the function `test`. 

Press hotkey again:
```php
//<?php

/**
 *   @fn         test
 *   @brief      $(Brief description)
 *   
 *   @param [in]	$one	$(description)
 *   @param [in]	$two	$(description)
 *   @return     $(Return description)
 *   
 *   @details    $(More details)
 *   
 *   @example    
 *   
 *   @todo       
 *   @bug        
 *   @warning    
 *   
 *   @see        https://
 *   @since      2024-09-26T15:25:08
 */

function test( $one, $two ){
```

And a function header for test() is inserted with parameters.

You may want to update the header ( `$(description)`, `$(Return description)` and `$(More details)`)

Move your cursor to the end of file and pres hotkey again:


```php
function test( $one, $two ){
	
}
//----------------------------------------------------------------------
```

And a delimiter line is inserted.

## Configuration

The entire configuration is stored in `doxyit.json`.

You can modify the templates to your own purpuses - and add new file extensions.

```json
	"title": "Data for Doxyit formatting",
	"date": "2024-09-24T18:17:43",
	"author": "Erik Bachmann <Erik@ClicketyClick.dk>",
```
Header description 

```json
	"templates": {
		"file": "${START}\n${LINE} ${PREFIX}....\n",
		"delimiter": "${START}-----------------....\n",
		"function": "${START}\n${LINE} ${PREFIX}fn         ${FUNCTION}\n.....\n${END}"
	},
```

The three templates used for building file header, function header and delimiter.

```json
	"users": {
:
		"Bruger": {
			"name": "Bruger",
			"fullname": "User Name",
			"email": "SomeOne@ClicketyClick.dk",
			"phone": "+45",
			"address": "Thierd Stone from the Sun"
		}
	},
```

Expaded user information. You can add your personal setup by dublicating one of the existing user blocks and insert your own data.


```json
	"types": {
:
		"php": {
			"name": "PHP",
			"function": "function",
			"start": "/**",
			"line": " *  ",
			"prefix": "@",
			"param_outer": "${LINE} ${PREFIX}param [in]\t%s\t$(description)",
			"param_inner": "\t$(description)\n${LINE} ${PREFIX}param [in]\t",
			"end": " */"
		},
```

Extension specific data:

Key|Descripion
---|---
name        | Descriptive name = programming language 
function    | Patterne used for identifying function definition
start       | Start comment
line        | New line START
end         | End comment
delimiter   | Delimiter line
header_zone | The zone at the top of file where file header is located (Defaule: 0-5)
prefix      | Prefix for Doxygen terms
param_outer | Outer parameter[^1]:
param_inner | Inner parameter[^1]:

[^1]: `param_outer` is the basic line and `param_inner` is the delimiter inserted between multiple values

The parameter block is build by inserting the argument to the function as entries in the function header:
```php
*   @param [in]	$abc	$(description)
*   @param [in]	$defg	$(description)
*   @return     $(Return description)
```

Given:
```php
function f( X, Y )
```
the arguments `X` and `Y` separated by `param_inner` are inserted into `param_outer` 

```
${LINE} ${PREFIX}param [in]\t%s\t$(description)
     ┌───────────────────────┘└────────────────────────┐ 
      X\t$(description)\n${LINE} ${PREFIX}param [in]\tY
```

and inserting in the function template at `${PARAM}`
