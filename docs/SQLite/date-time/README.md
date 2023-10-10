
## Date and time

### TIMESTAMP vs. ISO8601 dates

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

