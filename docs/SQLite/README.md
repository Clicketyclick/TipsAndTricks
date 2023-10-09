
## Tips and tricks on SQLite

- [Handle images](handle_images/) - Raw images or Base64 encoded images
- [Handle newlines](handle_newlines/) - Newlines (and other special characters) can be escaped using the CHAR() function or using the hex X'0A'.
- [Delete rows with duplicate values](delete_rows_with_duplicate_values) (https://stackoverflow.com/a/74994082/7485823) - How to delete all rows with duplicate values in 2 columns but keep the last inserted row?
- [Insert UUID as ID](Insert_UUID_as_ID) (https://stackoverflow.com/a/22725697/7485823)
- [Extract nested JSON from SQLite](SQLite2JSON_hash/) (Based on [Stackoverflow](https://stackoverflow.com/a/61004015/7485823) )
- [UUID as default value for id](DefaultUUID/) (Based on [Stackoverflow: SQLite - Generate GUID/UUID on SELECT INTO statement](https://stackoverflow.com/a/66625212) )

## sqlean - All the Missing SQLite Functions
- [nalgeon / sqlean](https://github.com/nalgeon/sqlean) All the Missing SQLite Functions

A true gold mine on extentions to SQLite.

These are the most popular functions. They are tested, documented and organized into the domain modules with clear API.

Think of them as the extended standard library for SQLite:

- crypto: hashing, encoding and decoding data
- define: user-defined functions and dynamic sql
- fileio: read and write files
- fuzzy: fuzzy string matching and phonetics
- ipaddr: IP address manipulation
- math: math functions
- regexp: regular expressions
- stats: math statistics
- text: string functions
- unicode: Unicode support
- uuid: Universally Unique IDentifiers
- vsv: CSV files as virtual tables
- The single-file sqlean bundle contains all extensions from the main set.

## TIMESTAMP vs. ISO8601 dates

SQLite has an internal timestamp with the syntax `YYYY-MM-DD hh:mm:ss`. This is NOT a valid timestamp as defined in ISO8601 where the syntax is `YYYY-MM-DD`**T**`hh:mm:ssZ` - with the letter `T` as delimiter (between date an time) and a timezone  (Zulu for UTC).

```sql
DROP TABLE IF EXISTS temp_times;
CREATE TEMPORARY TABLE temp_times (
  sqlite    TIMESTAMP  DEFAULT CURRENT_TIMESTAMP,
  iso8601   TEXT       DEFAULT (strftime('%Y-%m-%dT%H:%M:%SZ')),
  sometext  TEXT
 );
```

Testing this using:

```sql
REPLACE INTO temp_times(sometext) values("hello world");
SELECT * FROM temp_times;
```
Should produce:
```console
2022-04-27 18:49:07|2022-04-27T18:49:07Z|hello world
```
Please note that both timestamps are in UTC timezone (Local time is 20:52)

If you have a CURRENT_TIMESTAMP in a table, this could be translated using:
```sql
SELECT replace( CURRENT_TIMESTAMP, ' ', 'T');
```
But more correct would be:

```sql
SELECT strftime('%Y-%m-%dT%H:%M:%S.%fZ', sqlite) FROM temp_times;
```
Note that "fraction of a second" will always be "000", since the timestamp in SQLite does not contant fractions.


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
