## Wrap commands with comments


(Based on [<img src="../logo-stackoverflow.icon.png" title="Link to Stackoverflow" width=16px height=auto> - Commenting in a Bash script inside a multiline command](https://stackoverflow.com/a/1456019))


This will have some overhead, but technically it does answer your question:
```shell
echo abc `#Put your comment here` \
     def `#Another chance for a comment` \
     xyz, etc.
```
And for pipelines specifically, there is a clean solution with no overhead:
```shell
echo abc |        # Normal comment OK here
     tr a-z A-Z | # Another normal comment OK here
     sort |       # The pipelines are automatically continued
     uniq         # Final comment
```
And the same with redirect to file:

```shell
(
echo abc |        # Normal comment OK here
     tr a-z A-Z | # Another normal comment OK here
     sort |       # The pipelines are automatically continued
     uniq         # Final comment
) > file
```

Compressed:

```shell
# This will send "one" to STDOUT=output 
# and "two" via STDERR to STDOUT and wc
( echo one ; echo "two three" >&2 ) 2>&1 1>/tmp/output | wc
```

Or expanded:
```shell
(
    ( 
        echo one                # Writes to STDOUT
        echo "two Three" >&2    # Writes to STDERR 
    ) 2>&1 1>/tmp/output        # Redirect STDERR to STDOUT and Redirect original STDOUT to file
) | wc                          # Wordcount original STDERR as STDOUT
```

Should produce:

>       1       1      11

and send "one" to `/tmp/output`

