
## Tips and tricks on SQLite

- [Handle newlines](handle_newlines/)
- [Delete rows with duplicate values](delete_rows_with_duplicate_values) (https://stackoverflow.com/a/74994082/7485823)
- [Insert UUID as ID](Insert_UUID_as_ID) (https://stackoverflow.com/a/22725697/7485823)
- [Extract nested JSON from SQLite](SQLite2JSON_hash/) (Based on [Stackoverflow](https://stackoverflow.com/a/61004015/7485823) )
- [UUID as default value for id](DefaultUUID/) (Based on [Stackoverflow: SQLite - Generate GUID/UUID on SELECT INTO statement](https://stackoverflow.com/a/66625212) )


## TIMESTAMP vs. ISO8601 dates

SQLite has an internal timestamp with the syntax `YYYY-MM-DD hh:mm:ss`. This is NOT a valid timestamp as defined in ISO8601 where the syntax is `YYYY-MM-DD`**T**`hh:mm:ssZ` - with the letter `T` as delimiter (between date an time) and a timezone  (Zulu for UTC).

```sql
DROP TABLE times;
CREATE TABLE times (
  sqlite    TIMESTAMP  DEFAULT CURRENT_TIMESTAMP,
  iso8601   TEXT       DEFAULT (strftime('%Y-%m-%dT%H:%M:%SZ')),
  sometext  TEXT
 );
```

Testing this using:

```sql
REPLACE INTO times(sometext) values("hello world");
SELECT * FROM times;
```
Should produce:
```console
2022-04-27 18:49:07|2022-04-27T18:49:07Z|hello world
```
Please note that both timestamps are in UTC timezone (Local time is 20:52)


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
