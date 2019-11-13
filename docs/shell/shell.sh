#!/usr/bin/sh

#Check all ¤¤¤
#**********************************************************************
#@(#)NAME
#@(#)	shell.txt - a tips & tricks list for UNIX shell scripting
#
#@(#)SYNOPSIS
#@(#)	more shell.txt
#
#	 #####
#	#     #  #    #  ######  #       #
#	#        #    #  #       #       #
#	 #####   ######  #####   #       #
#	      #  #    #  #       #       #
#	#     #  #    #  #       #       #
#	 #####   #    #  ######  ######  ######
#	
#	 #####
#	#     #   ####   #####      #    #####    #####   ####
#	#        #    #  #    #     #    #    #     #    #
#	 #####   #       #    #     #    #    #     #     ####
#	      #  #       #####      #    #####      #         #
#	#     #  #    #  #   #      #    #          #    #    #
#	 #####    ####   #    #     #    #          #     ####
#
#	This is a tips & tricks list for UNIX shell scripting
#
#
#- DISCLAMER
#
#	The information is public domaine and delivered "as is"
#	Any error/malfunction/disaster caused by this file 
#	- or any related file - is YOUR problem
#
#	
#----------------------------------------------------------------------
# UPDATES:
#
#
#**********************************************************************
#@(#)2001-05-30/Erik Bachmann	Mailto:e_bachmann@hotmail.com
#**********************************************************************
#@(#)
#@(#) IN GENERAL ...
#
# Some claime that all well written code is selfdocumenting
# - and their code is mostly UNreadable to other human beings.
#
# Do yourself and other programmers a favour:
# 	Write what you intent to do!
#
# We can't read your mind - not yet
# Comments are a great interface to your thourghts
#
# Any line (except the very first line) starting with a # is a comment
# or a description.
#
# Examples of code or output from scripts are indented using a TAB (09h)
# Longer examples are marked with single line borders (starting and
# ending):
#
#	#-v- Example >-v-------------------------------------------
#
#		#This is an example
#
#	#-^- Example -^-------------------------------------------
#
# Paragraphs are separated by double line borders:
#
#	#==========================================================
#
# Paragraph headings are in UPPERCASE and marked with "#>":
#
#	#> PARAGRAPH HEADING
#
#======================================================================
#
#@(#) STARTING A SCRIPT
#
#@(#)	HEADER
#
# Any script should start of by telling:
# -	WHO am I
# -	WHERE am I
# -	WHAT am I doing
# -	HOW do I run
# -	WHO's to blame ;-)
# -	WHEN were I made/modifyed
#
# By all means: 
# 	DO tell the computer before telling the user 
# 	- but warn the user before letting the computer do it
#
# All UNIX scripts MUST (MUST!!!) tell the operating system how to be
# interpreted!
#
# A standalone script must tell which shell to use for this script in the
# very first line of the script using the she-bang command. She-bang is a
# number sign followd by exclamation mark (#!) and name of interpreter:
#
# 	#!/usr/bin/sh
# 
# Means: Run this script using /usr/bin/sh (Bourne Shell). 
# Any other shell could be used (csh, ksh ...).
#
# An include script is marked with a warning:
# 
# 	#!/usr/bin/echo This_Script_should_be_sourced:
#
# If the script is executable and you run the script from command line all
# you get is a warning followed by the name of the script:
#
# 	This_Script_should_be_sourced: ./my_script.sh
#
#
#@(#)	TEXTUAL HEADER
#
# Include the basic textual information for the human reader.
#
#@(#)		Example of a header >-v--------------------------------------------
#
#	#**************************************************************
#	#@ (#)NAME
#	#@ (#) shell.txt - a tips & tricks list for shell scripting
#	#
#	#@ (#)SYNOPSIS
#	#@ (#) more shell.txt
#	:
#	#--------------------------------------------------------------
#	# UPDATES:
#	#2001-05-30/Erik Bachman: Brief update
#	#
#	#**************************************************************
#	#@ (#)2001-05-30/Erik Bachmann	Mailto:e_bachmann@hotmail.com
#	#**************************************************************
#
#-^- Example of a header -^--------------------------------------------
#
# This example gives the basic information:
# -	WHO am I		shell.txt
# -	WHERE am I		(current directory or in command path ;-)
# -	WHAT am I doing		a tips & tricks list for shell scripting
# -	HOW do I run		more shell.txt
# -	WHO's to blame ;-)	Erik Bachmann	Mailto:e_bachmann@hotmail.com
# -	WHEN were I made/modifyed
#				2001-05-30/Erik Bachmann
#				2001-05-30/Erik Bachman: Brief update
#
# That's really all you need to write - plus a comment at the end of the
# script telling that this is the ententional end of the file.
#
#	#*** End of file ***
#
# The tags "@(#)" are used by the what command on extracting SCCS
# identification information.
#
# The Source Code Control System (SCCS) (AKA "Some Clown Changed
# Something") or the Revision Control System (RCS) :
#
#	"automates the storing, retrieval, logging, identification, 
#	and merging of revisions of ASCII text files. RCS is useful 
#	for managing files that are revised frequently."
# 
# what is a nice feature that can be used along with file to determine
# "what it is and what it does"
#
#@(#)	File identification >-v--------------------------------------------
#
#	$ file shell.txt
#	shell.txt:	ascii text
#	$ what shell.txt
#	shell.txt:
#	        NAME
#	             shell.txt - a tips & tricks list for shell scripting
#	        SYNOPSIS
#	             more shell.txt
#	        2001-05-30/Erik Bachmann  Mailto:e_bachmann@hotmail.com
#
#-^- File identification -^--------------------------------------------

#======================================================================
#@(#) HANDLING OPTIONS (ARGUMENTS)
#======================================================================
#
#	Options handling (getopts) >-v-------------------------------------

#@(#)	Options handling (getopts)
#Option	syntax:
#	abc	#Flags alone: -a -b -c
#	ab:c	#Option b requires an argument: -a -b 123 -c
while getopts 'a:bov?!' c
do
	case $c in
	a | b)	FLAG=${OPTARG}	; echo "(${c}=${OPTARG})" ;;
	o)	OARG=1		; echo "(${c}=${OPTARG})" ;;
	#--------------------------------------------------------------
	v)	VERBOSE=1 ; set -x ;;		#
	\c)	DEBUG=1	; set -nv ;;		#Just parsing script!
	\!)	DEBUG=1	; VERBOSE=1 ; set -ev ;;#Exit on error
	\?)	usage; exit 2 ;;		#Info about script
	*)	echo "No flag!"	; exit 1 ;;
	esac
	echo "($c)"
done
shift `expr $OPTIND - 1` 

#-^- Options handling (getopts) -^-------------------------------------

#>-v- Options handling, alternate >-v------------------------------------

#@(#)	Options handling, alternate. Process command line arguments
while test $# != 0
do
	case "$1" in
		#--- Specific parameters ------------------------------
		#-u)	shift; begyndt=$1;;
		#-d)	shift; DEVICE=$1;;

		#--- Standard parameters ------------------------------
		-\!)	#Compile/Debug mode
			shift; set -x ; VERBOSE=1 ; 
			DEBUG=1 ; DEBUGLEVEL=$1 ; echo "Debug mode on" ;;
		-\!)	#Debug mode
			shift; set -x ; VERBOSE=1 ; 
			DEBUG=1 ; DEBUGLEVEL=$1 ; echo "Debug mode on" ;;
		-\?)	#Help/info
			what $0 ; exit 0;;
		-v)	#Verbose mode on
			VERBOSE=1 ;;
		--)	shift; break;;
		*)	#Undefined
			echo "Parameter [$1] undefined - ignoring!"
			shift;;
     	esac
done

#-^- Alternate options handling -^-------------------------------------



#=== Main ===============

echo "*** $0 started on: `date +%Y-%m-%d/%H:%M:%S` "
echo " by: `whoami | cut -f1 -d' '` on server: `uname` "

#	Basic check for users without password >-v-------------------------------

#@(#)	find_user_without_passwd() - Basic check for users without password
find_user_without_passwd()´
{
	OUTPUTFILE="/tmp/users_wo_passwd"
	if [ grep '^[^:]*::' /etc/passwd >> $OUTPUTFILE ] ; then
		echo "\n\tWARNING!!!\n\tUsers without password found\07"
		echo "\tPlease contact your system administrator\n"
		echo "\tSee the reportfile $OUTPUTFILE for more details\n\n"
	else
		echo "\tOK - No users without password found\n\n"
	fi
}	#*** find_user_without_passwd() ***

#@(#)	Find latest access to .profile >-v---------------------------------------

#@(#) Find latest access to .profile
TmpDate=`ls -lu $HOME/.profile`
echo "Your latest logon was: $(TmpDate)"

#@(#)	Variables set by shell ($x) >-v------------------------------------------

	echo	"$0	Name of current script"
	echo	"$*	All arguments for current shell. Like: $1 $2 $3"
	echo	"$@"	'All arguments for current shell. Like: "$1" "$2" "$3" '
			All arg separatet (ie.ignoring \"\")"
	echo	"$#	Number of arguments for current shell"
	echo	"$?	Exit code from previous command. (Return code)"
	echo	"$$	Process id for current shell"
	echo	"$!	Process id for latest background job"
	echo	"$-	Options to shell or set"

	VAR="l 2 3"
	echo ( $WAR }		#Ordinary variable
	echo ( ${VAR:+string} )	#If variable is set, use string
	echo ( ${VAR:-string} )	#If variable is NOT set, use string
	echo ( ${VAR:=string} )	#Set variable to string, if variable is NOT

	echo ( ${VAR:?string} )	#Test if is set

#-^- Variables set by shell -^-----------------------------------------------

#@(#)	Variables used by shell >-v----------------------------------------------


	echo $HOME	#User's home directory
	echo $PATH	#Search path for commands
	echo $PS1	#Primary prompt (# for root, $ for others)
	echo $PS2	#Secondary prompt (> for others)

#-^- Variables used by shell -^----------------------------------------------

#@(#)	Basic check for users without password >-v-------------------------------

	if	grep '^[^:]*::' /etc/passwd >> ${OUTPUTFILE} ; then
		echo "\n\tWARNING!!!\n\tUsers without password found\07"
		echo "\tPlease contact your system administrator\n"
		echo "\tSee the reportfile ${OUTPUTFILE} for more details\n\n"
	else
		echo "\tOK - No users without password found\n\n"
	fi

#@(#)	Find file >-v------------------------------------------------------

find . -name "pre*" -print	# Find pre* in current or sub directory
find / -name "pre*" -print	# Find pre* anywhere i filsystem
find / -name "pre*" -exec ls -l {} \;
				# Find pre* anywhere an list long
				# Note {} equals filemask and \; 
				# terminates expression

#@(#)	xargs: Multiple arguments >-v--------------------------------------

xargs - Constructs argument lists and runs commands

find / -name "core" -print | -xargs rm	#*** NEVER EVER ***
find . -name "pre*" -exec rm {} \;	#*** NEVER EVER ***

If find fails these commands may be catastrophic!!!

Use:
	find / -name "core" -print > /tmp/core.lst
	more /tmp/core.lst
	cat /tmp/core.lst | xargs rm
but NOT in a script. 

	Do the manual check in more BEFORE removing!!!!!!!!!!!


#@(#)	Wildcards and masking >-v------------------------------------------

	*	Any sequence of characters incl "" Null-string
	?	Exactly one character
	[a-z]	One character from this set
	\	Escape (\? means the character '?')

	" "	Wildcards are not expanded
	' '	No expantion at all (not even $)
	` `	Replace with command output

	rm -- -p	#Deleting a file named "-p". -- means no more args.

#@(#)	Separators >-v-----------------------------------------------------

	;	Separating commands (like newline)
		X=4 ; echo $x
	#	Comment prefix
	|	Piping out from left side as input to right side command
		ls -l | wc -l
	&	Sends process to the background. Called forward with fg.

#======================================================================
#@(#) CONTROL STRUCTURES
#======================================================================

#@(#)	for .. in .. do .. done >-v-------------------------------

	for name in wordlist ; do
		list
	done

	for i in 1 2 3; do echo $i ; done


	for name ; do		# $* assumed as wordlist
		list
	done

#@(#)	case in .. esac >-v---------------------------------------

	case word in
	pattern1 | pattern2)
		list ;;
	*)
		default
	esac

	#--- case  ----------------------------------------------------
	case string in

	pattern)	command ;;
	pat1|pat2)	command ;;
	*)		#Default
			command ;;
	esac

#@(#)	if .. then .. else .. fi >-v--------------------------------------

	if list ; then
		list	# If true
	else
		list	# If false
	fi


	if list1 || list2
	then
		:	# NULL command (= do nothing)
	else
		list	# if both false
	fi


Link "if"-statement using elsif:

	if [ ex1 ] ; then
		echo "ex1 ok"
	elsif [ ex2 ] ; then
		echo "ex2 ok"
	else
		echo "Neither ex1 nor ex2"
	fi


If statements are test on an expression:

	if test xxxx ; then
		list
	fi

Can also be like:

	if [ xxxx ] ; then
		list
	fi


#@(#)	NULL command >-v---------------------------------------------------

Avoid the NULL command. Use:

	if ! (list && list2) ; then
		list	#both false
	fi


#@(#)	if - one-liner >-v-------------------------------------------------

An "if" construction can be written as a one-liner:

	if [ expression ] ; then do_something ; else alternative ; fi
	while [ expression ] ; do do_something ; done

Semicolon is expression separator - like newline.
Note! No Semicololon after "then", "else", "do"


#@(#)	Checking return values >-v-----------------------------------------

Don't use test on return values from functions:

	func1()
	{
		return 1
	}

	if func1 ; then
		echo "Func1 returned false"
	fi


#@(#)	while do done >-v--------------------------------------------------

	#--- while ----------------------------------------------------
	while list do
		list
	done

#@(#)	Breaking while loop (continue or break) >-v-----------------------

	while true ; do		# Could be written: while : ; do
		...
		if [ -z "$x" ] ; then
			break		#Breaking the loop
		fi
		fi [ -z "$y" ] ; then
			continue	#Go to start of loop
		fi
		...
	done

#@(#)	Infinite loop for checking files >-v------------------------------

	loop()
	{
		while true ; do
			$1
			sleep 5
		done
	}


#-^- Control structures -^---------------------------------------------

#@(#)	Boolean operation 

	#--- && (AND) -----------------------------------------
	ls file && cat file	#cat file only if it exists

	#--- || (OR) ------------------------------------------
	rm file && echo "Cannot delete"
				#echo only if file NOT deleted


	(list)		Execute list in a sub-shell.
	{list;}		list is executed in the current (that is, parent) shell.
	. list		list is executed in the current shell.

	name()
	{
		list;
	}


list='*Non* interpreted list'
list="Expanding *"


parameter=${parameter}	#Used instead of: parameter=$parameter

${parameter:-word}
	If parameter is set and is non-null, substitute its
	value; otherwise substitute word.
${parameter:=word}
	If parameter is not set or is null set it to word; the
	value of the parameter is substituted.  Positional
	parameters may not be assigned to in this way.
${parameter:?word}
	If parameter is set and is non-null, substitute its
	value; otherwise, print word and exit from the shell.
	If word is omitted, the message "parameter null or not
	set" is printed.
${parameter:+word}
	If parameter is set and is non-null, substitute word;
	otherwise substitute nothing.



#@(#)	I/O Control >--------------------

<word		Use file word as standard input (file descriptor 0).

>word         
		Use file word as standard output (file descriptor 1). If the file does
		not exist it is created; otherwise, it is truncated to zero length.

>>word
	Use file word as standard output. If the file exists output is appended
	to it (by first seeking to the end-of-file); otherwise, the file is
	created.

<<[-]word
	After parameter and command substitution is done on word, the shell
	input is read up to the first line that literally matches the resulting
	word, or to an end-of-file.

<&digit
	Use the file associated with file descriptor digit as standard input.
	Similarly for the standard output using >&digit.

<&-	The standard input is closed. 

>&-	Standard output is closed
digit>&-
	Output file is closed

|	Piping out from left side as input to right side command
		ls -l | wc -l

?>	redirecting ANY file descriptor to file

2>&1	Redirect STDERR (2) to STDOUT (1)

exec > FILE	#Redirect STDOUT to file
		#any output to STDOUT after this command will be
		#redirected to FILE
exec < /dev/tty	#Return STDOUT to original STDOUT

exec 3> file	#Create numeric filehandle (3)
command >&3	#Send output from command to file (3)


#trickread
        exec 3< $0      #This line is placed in LINE
        exec 0<&3
        read LINE
        echo $LINE

Beware of the exec command:
	command1
	exec command2
	command3

The current scrip with command2. command3 will not be executed.

exit [ n ]
	Exit and return code n


#======================================================================
#@(#) REGULAR EXPRESSIONS
#======================================================================

A regurlar expression is used to match pattern:

	mask	match
	.	a single character
	*	zero, one or more characters
	?	one characters
	^	start of line
	$	end of line
	[..]	set of characters like [a-z]
	[^..]	any characters but set
	\{..\}	a number of characters \{min,max\} or \{exact\}
	\(..\)	save match in register \1.
	
	\.$	any line ending with a punctuation
	
	echo "A\tB" | \(.*\)\t\(.*\) ; \2 \1

#======================================================================
#@(#) Inline input
#======================================================================

Complex input can be put together in a structure using inline:

echo <<term
	--------------
	Multiline form
	--------------
term

Inline is the structure from <<term to term. The terminating term must 
be placed alone at a line. EOF is often used as a mnemoteknic term.
The term must NOT be a part of the inline structure.


echo <<\term
	$var
	`command`
term

<<\term		Prevents the inlined variables to be expanded ie. 
		$var is treated as \$var and `command` is not executed

<<-term		Remove any leading tabs in the inline structure.

#@(#)	set : Setting shell flags >-v--------------------------------------

set
-a	Mark variables which are modified or created for export.

-e	Exit immediately if a command exits with a non-zero exit status.
-f	Disable file name generation

-h	Locate and remember function commands as functions are defined
	(function commands are normally located when the function is executed).

-k	All keyword arguments are placed in the environment for a command, not 
	just those that precede the command name.
-n	Read commands but do not execute them.
-t	Exit after reading and executing one command.
-u	Treat unset variables as an error when substituting.
-v	Print shell input lines as they are read.
-x	Print commands and their arguments as they are executed.
--	Do not change any of the following flags; useful in setting $1 to -.
		set -- -1	# $1="-1"

	Using + rather than - causes these flags to be turned off. These flags
	can also be used upon invocation of the shell. The current set of flags
	may be found in $-. The remaining arguments are positional parameters

set 1 2 3
	Setting numbered argument variables $1=1, $2=2, $3=3.

#-^- set -^------------------------------------------------------------

#@(#)	readonly variables >-v---------------------------------------------

readonly variables
	Marking variables as readonly. Shell returns an error if script 
	attempts to change the variables.

#@(#)	unset variable >-v-------------------------------------------------

unset variables
	Remove the variables from shell environment.

#-^- set -^------------------------------------------------------------

#@(#)	signals >-v--------------------------------------------------------

	SIGHUP	1	Proc	Hangup. Send to children when group 
				leder terminates
	SIGINT	2	Keyb	Interrupt [DEL] or [Ctrl]+[C]
	SIGQUIT	3	Keyb	Quit [Ctrl]+[D]
	SIGILL	4	HW	Illegal instruction	(kill -4 proc)
	SIGTRAP	5	HW	Trace trap used for debugging
	SIGIOT	6	HW	I/O trap instruction on hardware failure
	SIGFPE	8	HW	Floating Point Exception
	SIGKILL	9	Proc	Signal to kill process	(kill -9 proc)
	SIGBUS	10	HW	Bus Error - allignment problem
	SIGEGV	11	HW	Segment violation
	SIGALRM	14	Proc	Alarm clock
	SIGTERM	15	Proc	Software Termination.	(kill -15 proc). 
				Nice before SIGKILL.
	SIGUSR1	16	Proc	Configurable (app. dependent)
	SIGUSR2	17	Proc	Configurable (app. dependent)
	SIGPWR	19	HW	Power fail

#-^- signals -^--------------------------------------------------------

#@(#)	test >-v-----------------------------------------------------------

	if test -r file ; then
		echo "File is readable"
	fi
is equal to.
	if [ -r file ] ; then
		echo "File is readable"
	fi

¤¤¤
	TEST:
	str="="
	test -z "${str}"	#failes
	if [ -z "${str}" ]	#failes too ???
Use	if [ ! = !"${str}" ]


#-^- test -^-----------------------------------------------------------

#@(#)	test (files) >-v---------------------------------------------------

	test - valuates conditional expressions

	Expression	True if file
	test -f file	Exists:	if [ -f file ]
	test -r file	Is readable
	test -w file	Is writable
	test -x file	Is executable
	test -d file	is a directory

#@(#)	test (numeric) >-v-------------------------------------------------

	test x operator y
			True if operator relation between x and Y is true
	Operators:	-eq, -ne. -gt. -lt. -le

	$?		Return code from test

		check()
		{
		        echo "Check($1)"
		        return $1
		}

		if check 0  ; then
		        echo "$? / TRUE"
		else
		        echo "$? / FALSE"
		fi
		if check 1   ; then
		        echo "$? / TRUE"
		else
		        echo "$? / FALSE"
		fi

#@(#)	test (string) >-v--------------------------------------------------

	Expression	True if s
	test -z s	is null
	test -n s	is NOT null
	test s1 = s2	s1 is identical to s2
	test s1 != s2	s1 is NOT identical to s2

	!		Not
	-a		AND	(¤¤¤ &&)
	-o		OR	(¤¤¤ ||)
	(..)		grouping.
			Don't forget to escape the parenteses \( and \)

	test \( -f file -o -w file \) -a '-' file

	See isdigt()

#@(#)	trap >-v-----------------------------------------------------------

trap [ arg ] [ n ] ...

	The command arg is to be read and executed when the shell receives
	signal(s) n. (Note that arg is scanned once when the trap is set and
	once when the trap is taken.) Trap commands are executed in order of
	signal number. Any attempt to set a trap on a signal that was ignored on
	entry to the current shell is ineffective. An attempt to trap on signal
	11 (memory fault) produces an error. If arg is absent all trap(s) n are
	reset to their original values. If arg is the null string this signal is
	ignored by the shell and by the commands it invokes. If n is 0 the
	command arg is executed on exit from the shell. The trap command with no
	arguments prints a list of commands associated with each signal number.

	trap "echo Caught: [Ctrl]+[C]" 2	# Trap break
	trap 2					# Initiate normal trap
	trap : 2				# Trap break in current shell
						# but NOT for subshells

#-^- trap -^-----------------------------------------------------------

#@(#)	type - identifying command type >-v--------------------------------

type file
	Identify a command type like Shell build-in (like pwd), 
	function (like func() ) or file based command (like /bin/cat).

#-^- type -^-----------------------------------------------------------

#@(#)	which - find origin of command >-v---------------------------------

which cat
	returns the origin in the filesystem of the command (/bin/cat)

#-^- which -^----------------------------------------------------------

#@(#)	file - estimate file type >-v--------------------------------------

file myfile
	Try to identify content of myfile like ASCII text, C command, 
	binary file.

#-^- file -^-----------------------------------------------------------



#@(#)	wait >-v-----------------------------------------------------------

wait [ n ]

	Wait for your background process whose process id is n and report its
	termination status. If n is omitted, all your shell's currently active
	background processes are waited for and the return code will be zero.

#-^- wait -^-----------------------------------------------------------

#======================================================================
#@(#) Background processing
#======================================================================

#@(#)	command & >-v--------------------------------------------------------------

	command &
	Will run command in background. Prompt will be returned to user.

	Can be used on structures too. Like loops:
		#Copy file
		while read string
		do
			echo "${string}"
		done < inputfile > outputfile &

#-^- & -^--------------------------------------------------------------

#@(#)	fg and bg >-v------------------------------------------------------

	Korn shell has the commands:
	fg	foreground
	bg	background
	
	used for putting a command execution in background and taking 
	it to the foreground again

#-^- fg and bg -^------------------------------------------------------

#======================================================================
#@(#) Offline processes
#======================================================================

#@(#)	nohup >-v----------------------------------------------------------

nohup command &	

	NOHangUP on command. ie. process will keep running even if connection 
	is lost. & puts process in background. Output will be redirected to
	nohup.out.
	Can be used on

#-^- nohup -^----------------------------------------------------------

#@(#)	cron >-v-----------------------------------------------------------
¤¤¤
#-^- cron -^-----------------------------------------------------------

#@(#)	at >-v-------------------------------------------------------------
¤¤¤¤
#-^- at -^-------------------------------------------------------------


#@(#)	File and variable checks >-----------------------------------------

if [ -n "${DEBUG}" ]	#if $DEBUG is defined
if [ -z "${DEBUG}" ]	#If $DEBUG is not defined

if [ -f ${MSGFILE} ]	#If file is found
if [ ! -f ${MSGFILE} ]	#If file is NOT found

#@(#)	.profile >-v------------------------------------------------------

	umask	022	#Displays or sets the file mode creation mask

	/bin/stty line 2 erase '^H' kill '^U' intr '^C' echoe ctlecho eval 'tset -S -Q'

	lsc() { /bin/ls -C $*; }	#List directories in columns



#======================================================================
#@(#) SHELL FUNCTIONS
#======================================================================

#@(#)	combine() >-v------------------------------------------------------

combine()
{

#--- Combine ---
# AND uniq -d
# OR uniq
# Xor   uniq -u
#
if [ "$2x" = "andx" ] ; then
	#AND
	ID=`echo "$ID1\n$ID2" | sort | uniq -d`
	TERM=`echo "($TERM1) and ($TERM2)"`
else
	##OR
	ID=`echo "$ID1\n$ID2" | sort | uniq`
	TERM=`echo "($TERM1) or ($TERM2)"`
fi
}	#*** combine() ***

#-^- combine   (function) -^-------------------------------------------------


#---	countbar() >-v-------------------------------------------------------------

#@(#) countbar - simulates a looping character
COUNTBAR1=".oOo"	; export COUNTBAR1
COUNTBAR="-\\|/"	; export COUNTBAR
COUNTER=0		; export COUNTER
countbar()
{
	if [ $COUNTER -lt 1 ] ; then
		COUNTER=1 ;
	fi
	NEXTCOUNT=`expr $COUNTER + 1`

	echo "`echo $COUNTBAR | cut -c $COUNTER` \b\b\c"

	if [ $NEXTCOUNT -gt 4 ]
	then
		COUNTER=1 ;
	else
		COUNTER=$NEXTCOUNT ;
	fi
}

#Example
	loop=1 ; export loop
	cat /etc/profile | ( while read line
		do
			loop=`expr $loop + 1`
			countbar
		done

		echo "Counting $loop"
		)

#-^- countbar -^-------------------------------------------------------------


#---	edit() >-v---------------------------------------------------------

#@(#) edit - Make backup of file before editing. 
edit()
{
	cp -p $1 $1.`/usr/bin/date "+%Y%m%d%H%M%S"`
	vi $1
}	#*** edit() ***

#-^- edit() -^---------------------------------------------------------


#@(#)	get_current_userid (function) >-v----------------------------------------

get_current_userid()
{
	CURRENTUSERID=`who am i | cut -c12-19`
	CURRENTUSERID=`ps -ef | grep $CURRENTUSERID`
	CURRENTUSERID=`echo $CURRENTUSERID | cut -f1 -d" "`
}	#*** get_current_userid() ***
#-^- get_current_userid (function) -^----------------------------------

#---	isdigit() >-v------------------------------------------------------

#@(#) isdigit() - Checks if argument is a valid digit
isdigit()
{
	ISDIGIT=`expr	$1 \* 1 2>/dev/null`
	if [ $?	-eq 0 ] ; then
		echo "$1 is a digit"
		return 0
	else
		echo "$1 is *not* a digit"
		return 1
	fi
}	#*** isdigit() ***

#-^- isdigit() -^------------------------------------------------------


#---	isodate() >-v------------------------------------------------------

#@(#) isodate() - Set a date string YYYY-MM-DD/hh:mm:ss with current date
isodate()
{
	ISODATE=`/usr/bin/date "+%Y-%m-%d/%H:%M:%S"`
	if [ -! $? ] ; then
		_ERRORCODE=$?
		echo "ERROR!\tCode ${_ERRORCODE}\tSetting ISODATE in $0 failed"
		return ${_ERRORCODE}
	else
		export ISODATE
		echo ${ISODATE}
	fi
	return 0
} #*** isodate() ***

#-^- isodate() -^------------------------------------------------------

#@(#)	latest() >-v-------------------------------------------------------

latest_files()
while true
do
	ls -ltr | tail
	sleep 2
done

#-^- latest() -^-------------------------------------------------------


#@(#)	month2dec() >-v----------------------------------------------------

month2dec()
{
	case $Month in
	jan)	Month=1;;
	feb)	Month=2;;
	mar)	Month=3;;
	apr)	Month=4;;
	may)	Month=5;;
	maj)	Month=5;;
	jun)	Month=6;;
	jul)	Month=7;;
	aug)	Month=8;;
	sep)	Month=9;;
	oct)	Month=10;;
	okt)	Month=10;;
	nov)	Month=11;;
	dec)	Month=12;;
	*)	echo "\n ERROR!\n Month $date not found\a\n";
		Month=0;;
        esac
}	#*** month2dec() ***

#-^- month2dec (function) -^-------------------------------------------------


#@(#)	once_a_day() >-v---------------------------------------------------

# Get Current date
TmpUserDate='echo $TmpDate | cut -f7 -d" "`
WeekDay='date +%w'
Hour=`date +%H`
Morning=7
Evening=1

if [ `expr $CurrentDate` -eq `expr $TmpUserDate` ]; then
	if [ $FORCE != "YES" ] ; then
		echo "$0 : Already executed today. Use -f to force execution"
		exit 0
	fi
fi

#-^- once_a_day() -^---------------------------------------------------


#@(#)	Usage >-v----------------------------------------------------------------

USAGE="usage: do this" ; export USAGE

usage()
{
	what $0
	echo $(USAGE)
	exit 0
}	#*** usage() ***

#-^- Usage -^----------------------------------------------------------------

#@(#)	verbose (function) >-v---------------------------------------------------

verbose()
{
	if [ -n "${VERBOSE}" ] ; then
	¤¤¤¤ set -x
		echo "$*" >&2
	fi
}
#-^- verbose (function) -^---------------------------------------------------

#=^= SHELL FUNCTIONS =^======================================================




#@(#)	AWK functions >-v--------------------------------------------------

FROM=`awk '/^[fF][rR][oO][mM] / { printf("%s", $2) ; exit ; }' $TMP`
	Use perl functions!!!!!

#======================================================================
#@(#) ORACLE
#======================================================================

#@(#)	Oracle SQL >-v-----------------------------------------------

SQL> select sysdate from dual;

SYSDATE
--------
98-10-05

SQL> select sysdate-30 from dual ;

SYSDATE-
--------
98-09-05

#@(#)	Oracle interface >-v-----------------------------------------------

ORASAMTID=samtid/samtid
ORACLE_SID=DE
ORAENV_ASK=NO
. /usr/bin/oraenv
LANG=da_DK
LANGUAGE=dk
NLS_LANG=danish_denmark.WE81S08859P1
export LANG LANGUAGE NLS_LANG

ORA_date-init()
{
# $1	DATO
# $2	ENDDATO

LDATO=`/usr/oracle/bin/sqlplus -s $ORASAMTID << EOF
	set pages 0
	set heading off
	SET feedback off

	select to-char( to-date('$1','DD-MON-YY'), 'YYYY-MM-DD'	) from dual ;
	exit
EOF`

echo "<input type=\"hidden\" name=\"ldato\" value=\"$LDATO\">" >> $outfile

LENDDATO=`/usr/oracle/bin/sqlplus -s $ORASAMTID << EOF
	set pages 0
	set heading off
	SET feedback off

	select to-char( to date('$1','DD-MON-YY'), 'YYYY-MM-DD' ) from dual ;
	exit
EOF`


echo "<input type=\"hidden\" name=\"lenddato\" value=\"${LENDDATO}\">" >> $outfile

DATO_WEEKDAY=`/usr/oracle/bin/sqlplus -s $ORASAMTID << EOF
	set pages 0
	set heading off
	SET feedback off

	select to-char( to-date('$1','DD-MON-YY'), 'DAY' ) from dual ;
	exit
EOF`

echo "<input type=\"hidden\" name=\"dato-weekday\" value=\"${DATO-WEEKDAY}\">" >> $outfile


ENDDATO_WEEKDAY=`/usr/oracle/bin/sqlplus -s $ORASAMTID << EOF
	set pages 0
	set heading off
	SET feedback off

	select to char( to date('$l','DD-MON-YY'), 'DAY' ) from dual
	exit

EOF`
echo "<input type=\"hidden\" name=\"enddato-weekday\" value=\"${ENDDATO-WEEKDAY}\">" >> $outfile

}	#*** ORA_date-init() ***


ORA_date_check()
{
	CHECKDATO=`/usr/oracle/bin/sqlplus -s $ORASAMTID << EOF
		set pages 0
		set heading off
		set feedback off
		
		SELECT to_date('$ENDDATO','DD-MON-YY')
			- to_date('$DATO','DD-MON-YY')
		FROM dual;
		exit
EOF`	#Allways at pos 1.


	CHECKDATO=`expr ${CHECKDATO} + 0`

	if [ `expr ${CHECKDATO} \< 0 ` != 0 ] ; then
		errorhandle "Error! $ENDDATO is NOT after $DATO"
	fi

}	#*** ORA_date_check() ***


. /etc/profile 1> /dev/null 2>&1
		echo "---start --- " >> $outfile

	/usr/oracle/bin/sqlplus -s $ORASAMTID << EOF >> $outfile 2>&1
		set pages 0
		set heading off
		SET feedback off
		set lines 250
		set linesize 250
		SET pagesize 62
		SET newpage 0
		column kategori.beskrivelse FORMAT a30

		SELECT '<BR>Dato: '||to_char(DATO, 'YYYY-MM-DD')||' ('||to_char(DATO, 'DY)
			||'), Forbrugt ialt: '||tidsforbrug||' (imellem
			kl. '||starttid||' og '||sluttid||')'
		FROM daglig
		WHERE initialer='$INIT' AND dato='$DATO'
		exit
EOF

#-^- Oracle interface -^-----------------------------------------------



#======================================================================
#@(#) SCCS - Source Code Control System
#======================================================================


#!/usr/bin/sh
#**********************************************************************
# @ (#) %M% Rel. %I%
# @ (#)
# @ (#) SYNOPSIS: %M% {-u user} {-f} {-d device}
# @ (#)  -u xxx       Opened by xxx ( used if not LOGNAME )
# @ (#)  -f           Force execution. If already executed today
# @ (#)  -d yyy       Prints to device/file
# @ (#)  -?           Usage
# @ (#)
# @ (#) Source: %P%
#**********************************************************************
#@ (#)%E%-%U%/Erik Bachmann (e_bachmann@hotmail.com
#**********************************************************************

# sccs create O.sh
#

create 

	create is used when creating new s. files. For example, given a C
	source language file called I obscure.c', create would perform the
	following actions: (1) create the 's.' file called in the SCCS
	directory; (2) rename the original source file to ',obscure.c'; (3) do
	an 'sccs get' on 'obscure.c'. Compared to the SCCS admin command, create
	does more of the startup work for you and should be used in
	preference to admin.

enter

	enter is just like create, except that it does not do the final 'sccs
	get'. It is usually used if an sccs edit' is to be performed immediately
	after the enter.

edit 

	Get a file for editing.

delget 

	Perform a delta on the named files and thenget new versions. The new
	versions have ID keywords expanded, and so cannot be edited.

deledit 

	Same as delget, but produces new versions suit able for editing. deledit
	is useful for making a ''checkpoint'' of your current editing phase.

fix 

	Remove the named delta, but leaves you with a copy of the delta with the
	changes that were in it. fix must be followed by a -r flag. fix is
	useful for fixing small compiler bugs, and so on. Since fix does not
	leave audit trails, use it carefully.

clean

	Remove everything from the current directory that can be recreated from
	SCCS files. clean checks for and does not remove any files being
	edited.If 'clean -b' is used, branches are not checked to see if they
	are currently being edited. Note: -b is dangerous if you are keep ing
	the branches in the same directory.

unedit

	"Undo" the last edit or 'get -e' and return a file to its previous
	condition. If you unedit a file being edited, all changes made since the
	beginning of the editing session are lost.


info

	Display a list of all files being edited. if the -b flag is given,
	branches (that is, SID's with two or fewer components) are ignored. if
	the -u flag is given (with an optional argu ment), only files being
	edited by you (or the named user) are listed.

check 

	Check for files currently being edited, like info, but returns an exit
	code rather than a listing: nothing is printed if nothing is being
	edited, and a non-zero exit status is returned if anything is being
	edited. check may thus be included in an install'' entry in a makefile,
	to ensure that everything is included in an SCCS file before a version
	is installed.

tell

	Display a list of files being edited on the standard output. Filenames
	are separated by NEWLINE characters. Take the -b and -u flags like info
	and check.

diffs 

	Compare (in diff-like format) the current version of the program you
	have out for editing and the versions in SCCS format. diffs accepts the
	same arguments as diff, except that the -c flag must be specified as -C
	instead, because the -c flag is taken as a flag to get indicating which
	version is to be compared with the current version.

print 

	Print verbose information about the named files. print does an 
	'sccs prs -e' followed by an `sccs get -p -m` on each file.

 EXAMPLES
 The command:
	sccs -d/usr/include get sys/inode.h
 converts to:
	get /usr/include/sys/SCCS/s.inode.h
 The intent here is to create aliases such as:
	alias	syssccs sccs -d/usr/src
 which will be used as:
	syssccs	get cmd/who.c
 The command:
	sccs	-pprivate get usr/include/stdio.h
 converts to:
	get usr/include/private/s.stdio.h
 To put a file called myprogram.c into SCCS format for the
 first time, assuming also that there is no SCCS directory
 already existing:
	$ mkdir SCCS
	$ sccs create myprogram.c
	$ myprogram.c:

	1.1
	14 lines
	$
 To get a copy of myprogram.c for editing, edit that file,
 then	place it back in the SCCS database:
	$ sccs edit myprogram.c
	1.1
	new delta 1.2
	14 lines
	$ vi myprogram.c
	your editing session
	$ sccs delget myprogram.c
	comments? Added responses for compatibility
	1.2
	7 inserted
	7 deleted
	7 unchanged
	1.2
	14 lines
	$
	To get a file from another directory:
		sccs -p/usr/src/sccs/ get cc.c
	or:
		sccs get /usr/src/sccs/cc.c
	To make a delta of a large number of files in the current
	directory:
		sccs delta *.c
	To get a list of files being edited that are not on
	branches:
		sccs info -b
	To delta everything that you are editing:
		$ sccs delta 'sccs tell -u 
	Tn a makefile, to get source files from an SCCS file if it
	does not already exist:
	SRCS = <list of source files>
	$(SRCS):
		sccs get $(REL) $@

#-^- SCCS -^-----------------------------------------------------------


#@(#)	CGI: time >-v------------------------------------------------------

STARTTIME=$FORM_start
DATO=$FORM-day-$FORM-month-$FORM-year
ENDDATO=$FORM_end_day-$FORM_end_month-$FORM_end_year
ENDTIME=$FORM_end

USEDTTME=`expr \( \( \( $ENDTIME / 100 \) \* 60 \) + \( $ENDTIME % 100 \) \) - \( \( \( $STARTTIME / 100 \) \* 60 \) + \( $STARTTIME % 100 \) \)'

#-^- CGI -^------------------------------------------------------------------

#@(#)	CGI esc sequence >-v-----------------------------------------------------
#Replace escape sequences:
	#	\n	012	New line (%5C)
	#	\f	014	Form feed
	#	\b	008	Backspace
	#	\r	015	carriage return
	#	\t		Horizontal tab
	#	\'		Single Quote
	#	+	053	Space		377 ' '
	#	*		Asterics
	#	%5C		Backslash	177	11
 	#

	#Encoding
	QUERY_STRING=`echo "$QUERY STRING" | sed "s/%5C/\\/g" \
		|sed "s/\*/\*/g"| tr '\O53' '\377'` 

	#Decoding
	echo "$FORM text" | tr '\177' '\134' |	tr '\377' '\040' \
		| tr '\015' '\377' | sed "s/ÿ /ÿ/g" \
		| tr '\377' '\015' >> $outfile

#-^- CGI esc sequence -^-----------------------------------------------


#

formatering af uddata fra sqlplus og uddata til env-variabel. 
Filtest og variabel test: Eksistere, er tom, skrivebeskyttet etc. kald af loop
pointeroverforsel.O

#*** End of File ***

#======================================================================
#@(#) VI for VIderekomne
#======================================================================

#@(#)	Kort om vi for viderekomne.

(Eksempler på kommandoer er i dobbeltanførselstegn, white space betyder
en eller flere tab, blank eller linieskift, yank betyder kopier). 

Editering af flere filer: 
	#		forrige fil
	%		aktuel fil i kolon-kommandoer. 
F.eks. 
	vi minfil
	:e nyfil
	:e#
	:w %.gem

Efter 
	vi fil1 fil2 *.fil
kan man gå igennem filerne med
	:n
Med
	:rew
rewinder man til første fil (fil1). 

#@(#)	Cursor-flytning: 

	w		næste ord, 		
	W		forbi næste white space, 
	b		et ord tilbage,
	B		tilbage til senete white space, 
	22G		linie 22, 
	G		sidste linie, 
	^		første betydende tegn pa linie, 
	O		liniestart, $	linieslut,
	^F		en side frem, 
	^B		en side tilbage, 
	^D		½ side frem, 
	^U		½ side tilbage, 
	^M		midt pa siden, 
	/mintekst	næste forekomst af "mintekst",
	?mintekst	seneste forekomst af "mintekst", 
	n		gentag seneste søgning,
	N		gentag seneste søgning i modsat retning, 
	h		tegn til venstre, 
	l		tegn til højre, 
	j		linie ned, 
	k		linie op. 

#@(#)	Tekstmanipulation: 

	d<cursor>	slet til <cursorflytning>, 
	x		slet tegn under cursor, 
	X		slet tegn foran cursor, 
	y<cursor>	yank til <cursor-flytning>, 
	yy		yank aktuel linie, 
	u		fortryd seneste tekstmanipulation, 
	U		retabler aktuel linie, 
	ZZ		forlad editor (gem evt. ændringer), 
	i		indsæt tekst her, 
	I		indsæt tekst for første betydende tegn, 
	a		tilføj tekst efter cursor, 
	A		tilføj tekst efter linie, 
	c		tilføj tekst pa ny linie under denne, 
	O		tilføj tekst pa ny linie over denne,
	p		print buffer efter dette tegn/denne linie, 
	P		print buffer for dette tegn/denne linie, 
	J		fjern linieskift efter denne linie, 
	C		ret resten af linien, 
	c<cursor>	ret til cursor-flytning, 
	r		ret tegn, 
	R		ret fremad 
	.		gentag seneste tekstmanipulation. 

#@(#)	Repeat-faktor: 

Flere af funktionerne til cursor-flytning og tekstmanipulation kan gøres med repeat-faktor. F.eks. 
	8w	flytter cursoren 8 ord frem
	8yy	kopierer 8 linier til bufferen
	d8b	sletter de 8 foregaende ord.

Marker punkt i teksten:
	m<tekstmærke>	marker dette punkt. F.eks. "ma",
			som markerer denne linie med a. 

	'		(enkeltanforselstegn) flytter cursoren til et mærke, f.eks. "'a". 
			Da "'a" er en cursor-flytning, kan man med "d'a" slette teksten nellem cursoren og tekstmærket a. 

#@(#)	Navngivne buffere: 

Aktuel buffer overskrives ved hver ny kopiering eller sletning og den
kan ikke bringes med hen til næste fil (ved brug af ":n" eller ":e
nyfil". Hvis man vil have flere buffers eller vil printe bufferindhold i
en anden fil end % (aktuel fil), kan man navngive buffere med " (dobbelt
anforselstegn. F.eks. vil:

	"ayy		gemme aktuel linie i buffer a. 
	""ap" 		Buffer kan printes ud i enhver fil, man henter ind med ":e" eller ":n". 
	"kd'a		vil slette til mærke a og gemme det slettede i buffer k. 

#@(#)	Kolon-kommandoer:

	:w		write
	:e		editer
	:q		quit
	:n		next
	:rew		rewind
	:s		substituer
	:!		execute
	:r		read
	:r!date		Indsæt dato (date)
	:r!date +%Y-%m-%dT%H:%M:%S
			Indsæt ISO dato: YYYY-MM-DDThh:mm:ss


#@(#)	vi : Erstatning af tegn >---------------------------------------

:s/old_pattern/new_pattern/
	# Replace first occurence of old_pattern with new_pattern

:s/old_pattern/new_pattern/g
	# Replace all occurences of old_pattern with new_pattern on current line

:g/old_pattern/s//new_pattern/g
	# Replace all occurences of old_pattern with new_pattern in entire file

:g/test_pattern/s/old_pattern/new_pattern/g
	# Replace all occurences of old_pattern with new_pattern on lines with test_pattern


#@(#)	Byt om på det for og efter "og" i denne linie >--------------------

	Før:				Efter:
	Hans og Grethesnaldergrumsvås	Hans og Grethe>

	Kommando:
	 	":.s-snalder.*--" 

#@(#)	Byt om på det for og efter "og" i alle linier >-------------------
	Før:				Efter:
	Grethe og Hans			Hans og Grethe
	Julie og Romeo			Romeo og Julie>

	Kommando:
		":%s-\(.*\)\( og \)\(.*\)-\3\2\1-"

#@(#)	Ret x til y imellem a og b >---------------------------------------
	Før:				Efter:
	Her: der star blabla :her	Her: der star våsvås :her
	xHer: mere blabla :her		xHer; mere blabla :her
	Her: og mere blabla :her	Her: og mere våsvås :her
	Her: blabla igen :herx		Her: blabla igen :herx>

	Kommando: 
		":%s-^\(Her:.*\)\(blabla\)\(.*:her\)$-\1våsvås\3"
	(Ret blabla til våsvås i linier, der begynder 
	med Her: og slutter med :her).

#@(#)	Fjern efterstillede blanke i alle linier >--------------------------
	Før:		Efter:
	FELT1 FELT2	FELT1 FELT2
	----- -----	----- ----
	KAM   10.00	KAM   10.00
	SPÆK   2.00	SPÆK   2.00>

	Kommando: 
		":%s- *$--" 

#@(#)	Tekstsubstituering til (e)grep og sed >----------------------------
	Tekstgenkendelse og substituering med andre værktøjer:

	Den udvidede syntaks i vi kan også bruges i tekstværktøjer som grep,
	egrep og sed.

	F.eks.:
	Filindhold:			Output:
	Her: står våsvås :her		Her: står våsvås :her
	xHer: mere blabla :her		Her: og mere våsvås :her
	Her: og mere våsvås :her	Her: blabla igen :herx

	Unixkommando: "egrep '^Her:.*her$' minfil"

	Filindhold:			Output:
	Her: der står blabla :her	Her: der står våsvås :her
	xHer: mere blabla :her		xHer: mere blabla :her
	Her: og mere blabla :her	Her: og mere våsvås :her
	Her: blabla igen :herx		Her: blabla igen :herx

	Unixkommando:
	"sed 's-^\(Her:.*\)\(blabla\)\(.*:her\)$-\(våsvås\3-' minfil"

#**********************************************************************
#	Rebuild index: 
#		grep -n "@(#)" shell.txt >shell.idx
#		perl -p -i.bak -e "s/\@\(#\)//;s/\>.*$//; s/^(\d+)\:\#/#\t$1\t/" shell.idx
#
#======================================================================
#@(#) INDEX
#======================================================================
#
#	Line	Heading
#
#	5	NAME
#	6		shell.txt - a tips & tricks list for UNIX shell scripting
#	8	SYNOPSIS
#	9		more shell.txt
#	42	2001-05-30/Erik Bachmann	Mailto:e_bachmann@hotmail.com
#	44	
#	45	 IN GENERAL ...
#	79	 STARTING A SCRIPT
#	81		HEADER
#	117		TEXTUAL HEADER
#	121			Example of a header 
#	155	 The tags "" are used by the what command on extracting SCCS
#	168		File identification 
#	183	 HANDLING OPTIONS (ARGUMENTS)
#	188		Options handling (getopts)
#	212		Options handling, alternate. Process command line arguments
#	249		find_user_without_passwd() - Basic check for users without password
#	262		Find latest access to .profile 
#	264	 Find latest access to .profile
#	268		Variables set by shell ($x) 
#	290		Variables used by shell 
#	300		Basic check for users without password 
#	310		Find file 
#	319		xargs: Multiple arguments 
#	337		Wildcards and masking 
#	350		Separators 
#	360	 CONTROL STRUCTURES
#	363		for .. in .. do .. done 
#	376		case in .. esac 
#	394		if .. then .. else .. fi 
#	435		NULL command 
#	444		if - one-liner 
#	455		Checking return values 
#	469		while do done 
#	476		Breaking while loop (continue or break) 
#	489		Infinite loop for checking files 
#	502		Boolean operation 
#	546		I/O Control 
#	608	 REGULAR EXPRESSIONS
#	629	 Inline input
#	655		set : Setting shell flags 
#	685		readonly variables 
#	691		unset variable 
#	698		signals 
#	720		test 
#	740		test (files) 
#	751		test (numeric) 
#	776		test (string) 
#	794		trap 
#	816		type - identifying command type 
#	824		which - find origin of command 
#	831		file - estimate file type 
#	841		wait 
#	852	 Background processing
#	855		command & 
#	869		fg and bg 
#	881	 Offline processes
#	884		nohup 
#	895		cron 
#	899		at 
#	904		File and variable checks 
#	912		.profile 
#	923	 SHELL FUNCTIONS
#	926		combine() 
#	952	 countbar - simulates a looping character
#	989	 edit - Make backup of file before editing. 
#	999		get_current_userid (function) 
#	1011	 isdigit() - Checks if argument is a valid digit
#	1029	 isodate() - Set a date string YYYY-MM-DD/hh:mm:ss with current date
#	1046		latest() 
#	1058		month2dec() 
#	1085		once_a_day() 
#	1104		Usage 
#	1117		verbose (function) 
#	1133		AWK functions 
#	1139	 ORACLE
#	1142		Oracle SQL 
#	1156		Oracle interface 
#	1270	 SCCS - Source Code Control System
#	1440		CGI: time 
#	1451		CGI esc sequence 
#	1485	 VI for VIderekomne
#	1488		Kort om vi for viderekomne.
#	1510		Cursor-flytning: 
#	1534		Tekstmanipulation: 
#	1559		Repeat-faktor: 
#	1573		Navngivne buffere: 
#	1585		Kolon-kommandoer:
#	1600		vi : Erstatning af tegn 
#	1615		Byt om på det for og efter "og" i denne linie 
#	1623		Byt om på det for og efter "og" i alle linier 
#	1631		Ret x til y imellem a og b 
#	1643		Fjern efterstillede blanke i alle linier 
#	1653		Tekstsubstituering til (e)grep og sed 
#	1682	 INDEX
#
#*** End of File ******************************************************

