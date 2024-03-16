
## FORFILES - Window file finder

`FORFILES` is The-Windows-way of finding directories and files. It's a pauvre attempt to mimic Linux `find`.

## Example

```batch
FORFILES /P "%USERPROFILE%" /M "dropbox*" /s  /C "cmd /c echo @relpath"  2>nul | find /V "AppData" 2>nul
```

1.  Start in `%USERPROFILES%` directory
2. Matching "dropbox*"
3. Look in all subdirectories
4. On match execute `echo @readpath`
5. Filter all lines NOT contaning "AppData"


### Usage
```console
FORFILES [/P pathname] [/M searchmask] [/S]
         [/C command] [/D [+ | -] {yyyy-MM-dd | dd}]

Description:
    Selects a file (or set of files) and executes a
    command on that file. This is helpful for batch jobs.

Parameter List:
    /P    pathname      Indicates the path to start searching.
                        The default folder is the current working
                        directory (.).

    /M    searchmask    Searches files according to a searchmask.
                        The default searchmask is '*' .

    /S                  Instructs forfiles to recurse into
                        subdirectories. Like "DIR /S".

    /C    command       Indicates the command to execute for each file.
                        Command strings should be wrapped in double
                        quotes.

                        The default command is "cmd /c echo @file".

                        The following variables can be used in the
                        command string:
                        @file    - returns the name of the file.
                        @fname   - returns the file name without
                                   extension.
                        @ext     - returns only the extension of the
                                   file.
                        @path    - returns the full path of the file.
                        @relpath - returns the relative path of the
                                   file.
                        @isdir   - returns "TRUE" if a file type is
                                   a directory, and "FALSE" for files.
                        @fsize   - returns the size of the file in
                                   bytes.
                        @fdate   - returns the last modified date of the
                                   file.
                        @ftime   - returns the last modified time of the
                                   file.

                        To include special characters in the command
                        line, use the hexadecimal code for the character
                        in 0xHH format (ex. 0x09 for tab). Internal
                        CMD.exe commands should be preceded with
                        "cmd /c".

    /D    date          Selects files with a last modified date greater
                        than or equal to (+), or less than or equal to
                        (-), the specified date using the
                        "yyyy-MM-dd" format; or selects files with a
                        last modified date greater than or equal to (+)
                        the current date plus "dd" days, or less than or
                        equal to (-) the current date minus "dd" days. A
                        valid "dd" number of days can be any number in
                        the range of 0 - 32768.
                        "+" is taken as default sign if not specified.

    /?                  Displays this help message.

Examples:
    FORFILES /?
    FORFILES
    FORFILES /P C:\WINDOWS /S /M DNS*.*
    FORFILES /S /M *.txt /C "cmd /c type @file | more"
    FORFILES /P C:\ /S /M *.bat
    FORFILES /D -30 /M *.exe
             /C "cmd /c echo @path 0x09 was changed 30 days ago"
    FORFILES /D 2001-01-01
             /C "cmd /c echo @fname is new since Jan 1st 2001"
    FORFILES /D +2024-3-16 /C "cmd /c echo @fname is new today"
    FORFILES /M *.exe /D +1
    FORFILES /S /M *.doc /C "cmd /c echo @fsize"
    FORFILES /M *.txt /C "cmd /c if @isdir==FALSE notepad.exe @file"
```
