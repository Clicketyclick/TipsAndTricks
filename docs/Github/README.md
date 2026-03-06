
### Files not removed from `.gitignore`

Check if the files were already tracked: If the files you want to ignore were already tracked by Git before you added them to the .gitignore, 
they will continue to be tracked. You need to untrack them. You can do this by running the following command in your terminal:
```console
git rm --cached FILENAME
```


### Semantic Versioning

```console
:: Add tag
git tag -a "v0.1.0-beta" -m "version v0.1.0-beta"
git show v0.1.0-beta
:: Get latest tag
git describe --abbrev=0 --tags
```

https://stackoverflow.com/a/46434732

### Auto build number and revision date

#### [How to manage the version number in Git?](https://stackoverflow.com/a/66605369)

1. Create file in project dir (or where you want) build_number and put the value 1 in this file
2. Go to git dir and create file called "pre-commit" in .git/hooks/ (without .sample)
3. Put this code there

```bash
currentbuildnumber=`cat build_number`
let "currentbuildnumber++"
printf $currentbuildnumber > build_number
currentbranch=`git branch | tr -cd "[:alpha:]"`
git log $currentbranch --pretty=format:"%h - %an, %ar : %s, Build: $currentbuildnumber"
```
Example: [pre-commit](pre-commit)

#### Revision date
- [date command --iso-8601 option](https://unix.stackexchange.com/a/629504)
- [how to get local date/time in linux terminal while server configured in UTC/different timezone?](https://stackoverflow.com/a/63063754)

```bash
#For a local time, use "date".
date +'%Y-%m-%dT%H:%M:%S.%3N%:z' > revision.local
# For UTC time, use "date -u".
date -u +'%Y-%m-%dT%H:%M:%S.%3N%:z' > revision
```

#### Post commit log

In `.git/hooks/post-commit` add the command:

```bash
git show --pretty=format:'{"commit":"%H","author":"%an","email":"%ae","date":"%aI","subject":"%f"}' --no-patch --date=iso-strict > postcommit.json
```
which will give you data like:
```json
{"commit":"cafedeaffacebadaddbeebeefdeaddadbadbedacecab","author":"myName","email":"me@nowhere.com","date":"2026-03-06T10:16:38+01:00","subject":"Commit test-2"}
```
Example: [post-commit](post-commit)
