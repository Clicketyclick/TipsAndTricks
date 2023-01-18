## Linux Shell Tip: Remove files with names that contains spaces, and special characters such as -, —
By Vivek Gite -February 4, 201466676
[&#x1F517;](https://www.linux.com/training-tutorials/linux-shell-tip-remove-files-names-contains-spaces-and-special-characters-such/)



In Linux or Unix-like system you may come across file names with special characters such as:

- –
- —
- ;
- &amp;
- $
- ?
- *
- White spaces, backslashes and more.


In this quick tip I am going to show you to delete or copy files with names that contain strange characters on Linux.

### Sample file list

Here is a sample list of file names:

```
file
>file
-file
--file
@#$%^&file
$ file
*file
*  file
my resume.doc
```

<!--p><img decoding="async" src="https://www.linux.com/training-tutorials/images/stories/18529/file-1.png" width="466" height="224" alt="file-1"></p-->

<img decoding="async" src="file-1.png" width="466" height="224" alt="file-1">


### The problem and solution

Your default bash shell considers many of these special characters (also known as meta-characters) as commands. If you try to delete or move/copy such files you may end up with errors. In this example, I am trying to delete a file named ‘&gt;file’:


```
 rm &gt;file
```


Sample outputs:

```
rm: missing operand
Try `rm --help' for more information.
```


The rm command failed to delete the file due to strange character in filename.


#### Tip #1: Put filenames in quotes</h3>

The following command is required to copy or delete files with spaces in their name, for example:

```
$ cp "my resume.doc" /secure/location/
$ rm "my resume.doc"
```


The quotes also prevent the many special characters interpreted by your shell, for example:

```
$ rm -v "&gt;file"
removed `&gt;file'
```


The double quotes preserve the value of all characters enclosed, except for the dollar sign, the backticks and the backslash. You can also try single quotes as follows:

```
$ rm -v 'a long file   name  here'
$ cp 'my mp3 file.mp3' /backup/disk/
```



#### Tip #2: Try a backslash</h3>

You can always insert a backslash () before the special character in your filename:

```
$ cp "my resume.doc" /secure/location/
$ rm "*file"
```



#### Tip #3: Try a ./ at the beginning of the filename</h3>

The syntax is as follows to delete a file called ‘-file’:

```
$ rm -v ./-file
removed `./-file'
```


The ./ at the beginning of the filename forces rm not to interpret – as option to the rm command.


#### Tip #4: Try a — at the beginning of the filename</h3>

A — signals the end of options and disables further option processing by shell. Any arguments after the — are treated as filenames and arguments. An argument of – is equivalent to –. The syntax is:

```
$ rm -v -- -file
$ rm -v -- --file
$ rm -v -- "@#$%^&amp;file"
$ rmdir -v -- "--dirnameHere"

```



#### Tip #5: Remove file by an inode number</h3>

The -i option to ls displays the index number (inode) of each file:

```
ls -li
```


Use find command as follows to delete the file if the file has inode number 4063242:

```
$ find . -inum 4063242 -delete
```


OR

```
$ find . -inum 4063242 -exec rm -i {} ;
```

<!--p>Sample session:<img decoding="async" loading="lazy" src="https://www.linux.com/training-tutorials/images/stories/18529/file-2.png" width="500" height="385" alt="file-2"></p-->

Sample session:

<img decoding="async" loading="lazy" src="file-2.png" width="500" height="385" alt="file-2">

For more information and options about the find, rm, and bash command featured in this tip, type the following command at the Linux prompt, to read man pages:

```
$ man find
$ man rm
$ man bash
```
