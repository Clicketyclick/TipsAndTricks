
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
{"commit":"cafedeaffacebadaddbeebeefdeaddadbadbedacecab","author":"Who Me","email":"whome@nowhere.com","date":"2026-03-06T10:16:38+01:00","subject":"Commit test-2"}
```

Or if you want "The Full Monty"
(Source: [git-show](https://git-scm.com/docs/git-show) - Show various types of objects ):

```bash
git show --pretty=format:'{
    "commit_hash": "%H",
    "abbreviated_commit_hash": "%h",
    "tree_hash": "%T",
    "abbreviated_tree_hash": "%t",
    "parent_hashes": "%P",
    "abbreviated_parent_hashes": "%p",
    "author_name": "%an",
    "author_name_mailmap": "%aN",
    "author_email": "%ae",
    "author_email_mailmap": "%aE",
    "author_email_local-part": "%al",
    "author_local-part": "%aL",
    "author_date": "%ad",
    "author_date_RFC2822_style": "%aD",
    "author_date_relative": "%ar",
    "author_date_UNIX_timestamp": "%at",
    "author_date_ISO_8601-like_format": "%ai",
    "author_date_strict_ISO_8601_format": "%aI",
    "author_date_short_format_(YYYY-MM-DD)": "%as",
    "author_date_human_style": "%ah",
    "committer_name": "%cn",
    "committer_name_mailmap": "%cN",
    "committer_email": "%ce",
    "committer_email_mailmap": "%cE",
    "committer_email_local-part": "%cl",
    "committer_local-part": "%cL",
    "committer_date": "%cd",
    "committer_date_RFC2822_style": "%cD",
    "committer_date_relative": "%cr",
    "committer_date_UNIX_timestamp": "%ct",
    "committer_date_ISO_8601-like_format": "%ci",
    "committer_date_strict_ISO_8601_format": "%cI",
    "committer_date_short_format": "%cs",
    "committer_date_human_style": "%ch",
    "ref_names": "%d",
    "ref_names_without_wrapping": "%D"
}' --no-patch --date=iso-strict > postcommit.json
```

Example: [post-commit](post-commit)
