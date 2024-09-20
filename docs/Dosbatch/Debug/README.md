## Verbose, debug and logging

Enabeling / disabeling **verbose**, **debug** and **logging** functionality in a batch script using environment variable.

Verbose and debug is redirected to STDERR (&2). Log messages to logfile.

All three functions can dynamically be switched on and off by setting the environment variables and calling `_debug.cmd`.

Environment | Value | Target |Function | Prefix
---|---|---|---|---|
verbose|0         | NUL                   | Verbose is off                    |
verbose|1         | STDERR                | Verbose is on writting to STDERR  | `- `
debug  |0         |  NUL                  | Debug is off                      |
debug  |1         | STDERR                | Debug is on - and so is Verbose   | `DEBUG: `
logging|          |  NUL                  | No logging                        |
logging|filename  | Logging to `filename` | Logging is on                     | `LOG: `


Set the environment variables:
```cmd
SET verbose=1
SET debug=1
SET logging=logfilename
```

And call _debug to setup the calls:
```cmd
CALL _debug
    %__VERBOSE__% Verbose: something to verbose
    %__VERBOSE__% Verbose: more to to verbose
    %__DEBUG__% something to debug
    %__DEBUG__% more to debug
    %__LOGGING__% something to log
    %__LOGGING__% some more to log
```
If verbose, debug and logging is active this will produce the output:

```console
- Verbose: something to verbose
- Verbose: more to to verbose
DEBUG: something to debug
DEBUG: more to debug
```
And a log file `logfilename` with the content:
```console
LOG: something to log
LOG: some more to log
```

### Testing 

The test script `_debug_test` demonstrates the functionallity.

Set the environment variables and run the script

```console
> _debug_test

┌────────────────────────────────────────────────────────────────────────┐
│* file      _debug_test.cmd                                             │
│* brief     Testing verbose, debug and log functions - w cleanup        │
│* version   2024-09-20T20:18:26                                         │
└────────────────────────────────────────────────────────────────────────┘
Full name: [c:\dev\getGithub\_debug_test.cmd]
Full path: [c:\dev\getGithub\]
State:     v:[]/d:[]/l:[mylog] [::][::]

State:     v:[]/d:[1]/l:[mylog] [1 ECHO:-][1 ECHO:DEBUG:]

- Verbose: something to verbose
- Verbose: more to to verbose
DEBUG: something to debug
DEBUG: more to debug

┌┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┐
┆ >>> --- :cleanup ---                                           ┆
┆ Sweeping the floor                                             ┆
┆                                                                ┆
┆Logfile: 20-09-2024  23:05                46 mylog              ┆
┆>>> ---8<--- Logfile: mylog --->8---                            ┆
┆LOG: something to log                                           ┆
┆LOG: some more to log                                           ┆
┆<<< ---8<---Logfile: mylog --->8---                             ┆
┆<<< --- :cleanup ---                                            ┆
└┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┘

Delete log file?? [Y,N,C]?Y
Deleting log file [mylog]
Done
```
