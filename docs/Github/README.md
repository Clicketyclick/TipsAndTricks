## 



### Files not removed from `.gitignore`

Check if the files were already tracked: If the files you want to ignore were already tracked by Git before you added them to the .gitignore, 
they will continue to be tracked. You need to untrack them. You can do this by running the following command in your terminal:
```console
git rm --cached FILENAME
```
