# Set window title in Bash

Default:

`PS1='\[\e]0;\w\a\]\n\[\e[32m\]\u@\h \[\e[33m\]\w\[\e[0m\]\n\$ '`

```bash
# https://unix.stackexchange.com/a/574983
wtitle() {
#  if [ "$TERM" == "xterm" ] ; then
    echo "Setting window title: [$1]"
    # Remove the old title string in the PS1, if one is already set.
    PS1=$(echo "$PS1" | sed -r 's/^\\\[[^]]+][^]]+\\\]//g')
    export PS1="\[\033]0;$1 - \u@\h:\w\007\]$PS1"
#  else
#    echo "You are not working in xterm. I cannot set the title."
# fi
}
```
