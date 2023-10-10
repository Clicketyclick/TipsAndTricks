## Paradox

Data types are different in SQLite compared to Paradox. We automatically adjust them as we copy the tables so you don't have to worry about it. You can adjust the mapping rules if you wish to change the following defaults:

Paradox|SQLite
---|---
bool | integer
date | datetime
int | integer
money | double
smallint | integer
time | text
timestamp | datetime
varchar | text 

### Automated conversion

- https://www.rebasedata.com/convert-paradox-to-sqlite-online
- https://www.fullconvert.com/howto/paradox-to-sqlite
