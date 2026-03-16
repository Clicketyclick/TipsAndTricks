
### Download individual directory from repository

To download a folder from GitHub:
1. navigate to your desired repository
2. select the folder you want to download from GitHub
3. copy the URL
4. navigate to https://download-directory.github.io/
5. paste the URL into the text box
6. hit &#x23CE;

Source: <img src="../icons/Gitkraken.icon.png" width=32 height=auto> [How to Download a Folder from GitHub](https://www.gitkraken.com/learn/git/github-download#how-to-download-a-folder-from-github "How to Download a Folder from GitHub")

### Files not removed from `.gitignore`

Check if the files were already tracked: If the files you want to ignore were already tracked by Git before you added them to the .gitignore, 
they will continue to be tracked. You need to untrack them. You can do this by running the following command in your terminal:
```console
git rm --cached FILENAME
```


### Semantic Versioning

```console
git config --global user.name "username"
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
<!--
2. Go to git dir and create file called "pre-commit" in .git/hooks/ (without .sample)

```bash
#!/bin/bash
#
# An example hook script to verify what is about to be committed.
# Called by "git commit" with no arguments.  The hook should
# exit with non-zero status after issuing an appropriate message if
# it wants to stop the commit.
#
# Update Buildnumber
# - Read buildnumber from JSON or default 0
currentbuildnumber=$((cat repo.json 2>/dev/null || echo '{}') | jq '.build_number // 0')
# - Increment
((currentbuildnumber+=1))
#echo $currentbuildnumber
#
# Log Buildnumber
currentbranch=`git branch | tr -cd "[:alpha:]"`
git log $currentbranch --pretty=format:"%h - %an, %ar : %s, Build: $currentbuildnumber"
#
# Get repository name
repo=$(basename `git rev-parse --show-toplevel`)
#
# Get version from tags (= latest)
version=$(git describe --abbrev=0 --tags)
#git tag>tags
#
# [date command --iso-8601 option](https://unix.stackexchange.com/a/629504)
# [how to get local date/time in linux terminal while server configured in UTC/different timezone?](https://stackoverflow.com/a/63063754)
# For a local time, use "date".
revision_local=$(date +'%Y-%m-%dT%H:%M:%S.%3N%:z')
#
# For UTC time, use "date -u".
revision=$(date -u +'%Y-%m-%dT%H:%M:%S.%3N%:z')
#
# Build JSON
json=$(cat <<EOL
{
    "repository":       "${repo:-REPOSITORY}",
    "version":          "${version:-VERSION}",
    "revision":         "${revision:-REVISION}",
    "revision_local":   "${revision_local:-revision_local}",
    "build_number":     ${currentbuildnumber:-0}
}
EOL
)
# Write JSON to file
echo "$json" > repo.json
```

Example: [pre-commit](pre-commit)

<!--
#### Revision date
- [date command --iso-8601 option](https://unix.stackexchange.com/a/629504)
- [how to get local date/time in linux terminal while server configured in UTC/different timezone?](https://stackoverflow.com/a/63063754)

```bash
#For a local time, use "date".
date +'%Y-%m-%dT%H:%M:%S.%3N%:z' > revision.local
# For UTC time, use "date -u".
date -u +'%Y-%m-%dT%H:%M:%S.%3N%:z' > revision
```
-->

#### Post commit log

2. Go to git dir and create file called "post-commit" in .git/hooks/ (without .sample)
In `.git/hooks/post-commit` add the command:

```bash
git show --pretty=format:'{"commit":"%H","author":"%an","email":"%ae","date":"%aI","subject":"%f"}' --no-patch --date=iso-strict > .postcommit.json
```
which in `.post-commit` will give you data like:
```json
{"commit":"cafedeaffacebadaddbeebeefdeaddadbadbedacecab","author":"Who Me","email":"whome@nowhere.com","date":"2026-03-06T10:16:38+01:00","subject":"Commit test-2"}
```

3. Put this code there if you want "The Full Monty"

(Source: [git-show](https://git-scm.com/docs/git-show) - Show various types of objects ):

```bash
#!/bin/bash
# Runs after commit
#
# [Auto build number and revision date](https://github.com/Clicketyclick/TipsAndTricks/tree/master/docs/Github#auto-build-number-and-revision-date)
# [Post commit log](https://github.com/Clicketyclick/TipsAndTricks/tree/master/docs/Github#post-commit-log)
#
# Read build number
buildnumber=$((cat postcommit.json 2>/dev/null || echo '{}') | jq '.buildnumber // 0')
# - Increment
((buildnumber+=1))
#
currentbranch=`git branch | tr -cd "[:alpha:]"`
git log $currentbranch --pretty=format:"%h - %an, %ar : %s, Build: $buildnumber" > /dev/null
#
# Get repository name
system_name=$(basename `git rev-parse --show-toplevel`)
#
version=$(git describe --abbrev=0 --tags)


# 1. Define the Git fields we want to extract (separated by a pipe)
# Note: Use a delimiter that is unlikely to appear in names (like | or \t)
git_format="%H|%h|%T|%t|%P|%p|%an|%aN|%ae|%aE|%al|%aL|%ad|%aD|%ar|%at|%ai|%aI|%as|%ah|%cn|%cN|%ce|%cE|%cl|%cL|%cd|%cD|%cr|%ct|%ci|%cI|%cs|%ch|%d|%D|${system_name}|${version}|${currentbranch}|${buildnumber}|%cI"

# 2. Define the jq transformation structure
# This maps the array indices from the split to your JSON keys
jq_filter='split("|") | {
    "system_name": .[36],
    "version": .[37],
    "currentbranch": .[38],
    "buildnumber": (.[39] | tonumber),
    "revision": .[40],
    "commit_hash": .[0],
    "abbreviated_commit_hash": .[1],
    "tree_hash": .[2],
    "abbreviated_tree_hash": .[3],
    "parent_hashes": .[4],
    "abbreviated_parent_hashes": .[5],
    "author_name": .[6],
    "author_name_mailmap": .[7],
    "author_email": .[8],
    "author_email_mailmap": .[9],
    "author_email_local-part": .[10],
    "author_local-part": .[11],
    "author_date": .[12],
    "author_date_RFC2822_style": .[13],
    "author_date_relative": .[14],
    "author_date_UNIX_timestamp": .[15],
    "author_date_ISO_8601-like_format": .[16],
    "author_date_strict_ISO_8601_format": .[17],
    "author_date_short_format_(YYYY-MM-DD)": .[18],
    "author_date_human_style": .[19],
    "committer_name": .[20],
    "committer_name_mailmap": .[21],
    "committer_email": .[22],
    "committer_email_mailmap": .[23],
    "committer_email_local-part": .[24],
    "committer_local-part": .[25],
    "committer_date": .[26],
    "committer_date_RFC2822_style": .[27],
    "committer_date_relative": .[28],
    "committer_date_UNIX_timestamp": .[29],
    "committer_date_ISO_8601-like_format": .[30],
    "committer_date_strict_ISO_8601_format": .[31],
    "committer_date_short_format": .[32],
    "committer_date_human_style": .[33],
    "ref_names": .[34],
    "ref_names_without_wrapping": .[35]
}'

# 3. Execute
git show -s --format="$git_format" --no-patch --date=iso-strict | jq -R "$jq_filter" > .postcommit.json
```


### Dummy UID to use in examples

Avoid displaying any UID's that resembles real values. But use a combination of "hex" words  with 0-9, a-f:

> ace, add, bee, cab, cad, dab, dad, bad, bed, bead, beef, cafe, face, fade, deaf, dead, decaf, deface, efface, defaced, effaced, beaded

Example: `cafedeaffacebadaddbeebeefdeaddadbadbedacecab`
or `0123456789cafedeaffacebadaddbeebeefdeaddadba`


Example: [post-commit](post-commit)
