
Use the read command to wait for a single character (-n1) input from the user
```bash
# Source - https://stackoverflow.com/a/42234997
# Posted by Inian, modified by community. See post 'Timeline' for change history
# Retrieved 2026-11-02, License - CC BY-SA 4.0

read -p "Press key to continue.. " -n1 -s
```

or as a function

```bash
pause() { 
    read -p "Press key to continue.. " -n1 -s;
    echo -e "\n"
}
```
