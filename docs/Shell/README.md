@@Shell_logo@@

# Shell

- [Shell script by example](shell.sh) tips for shell scripts, vi, awk and a few Perl one-liners. (Comments in danish - sorry)

## Modules / libraries

- [testMore](testMore/) - yet another framework for writing test scripts
- [trim](trim/) - trim leading and trailing whitespace from string

## Tricks

- [Print script header](print_header.md) looking for DoxyIt header
- [Set window title](BashWindowTitle.md) in Bash
- [Wrap commands with comments](wrap_cmd_w_comments.md)
- [sprintf()](sprintf) - sprint() alias

### Remove files with names that contains special characters
- [@@Linux_com_logo@@ Linux Shell Tip: Remove files with names that contains spaces, and special characters such as -, —](https://www.linux.com/training-tutorials/linux-shell-tip-remove-files-names-contains-spaces-and-special-characters-such/)  [<span title="CopyLeft &#x1F12F; Local copy">(&#x0254;)</span>](remove_files_w_special_chars/)

```shell
mv -- --remove-files remove-files
```

### Archive and delete files

```shell
# Find file older than 90 sec and tar
find . -type f -mtime +90 -name 'emailntc.ran.*' | xargs tar cvf emailntc.ran.tar 
# Delete archived files
find . -type f -mtime +90 -name 'emailntc.ran.*' | xargs rm
```

### Get doxy header

```shell
# Print header
grep -E '^#\s+@' $0 1>&2
```

### Zulu time
```shell
date -u +%Y-%m-%dT%H:%M:%S%z
```
### crontab guru
The quick and simple editor for cron schedule expressions by Cronitor: https://crontab.guru/#*/10_7-17_*_*_*

## External

- [Bash scripting cheatsheet](https://devhints.io/bash)

