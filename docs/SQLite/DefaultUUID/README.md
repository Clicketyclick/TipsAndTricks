# UUID as default value for id

When creating entries in a table with a unique id created automatically on-the-fly, setting `id` as `TEXT` and with a default as a function in `()` is posible.

This test table has four fields:

Field|Content
---|---
id   | Unique id as a UUID (32 bytes)
t    | SQLite timestamp
size | Size of the string in `id`
note | Bla bla

```sql
DROP TABLE test;
CREATE TABLE IF NOT EXISTS test (
  id TEXT PRIMARY KEY DEFAULT (lower(
    hex(randomblob(4)) || '-' || hex(randomblob(2)) || '-' || '4' || 
    substr(hex( randomblob(2)), 2) || '-' || 
    substr('AB89', 1 + (abs(random()) % 4) , 1)  ||
    substr(hex(randomblob(2)), 2) || '-' || 
    hex(randomblob(6))
  )) check(length(ID) > 5),
  t TIMESTAMP
  DEFAULT CURRENT_TIMESTAMP,
  size INTEGER,
  note text
);

DROP TRIGGER IF EXISTS record_insert_test;
CREATE TRIGGER IF NOT EXISTS record_insert_test
    AFTER INSERT
    ON "test"
    BEGIN
        UPDATE "test"
        SET 
            size = length(note)
        WHERE size IS NULL;
    END;
```

### UUID

The UUID snippet is copied from Stackoverflow:

```sql
(lower(
    hex(randomblob(4)) || '-' || hex(randomblob(2)) || '-' || '4' || 
    substr(hex( randomblob(2)), 2) || '-' || 
    substr('AB89', 1 + (abs(random()) % 4) , 1)  ||
    substr(hex(randomblob(2)), 2) || '-' || 
    hex(randomblob(6))
  ))
 ```
Please note that this function should be in parentheses!

## Example

```sql
.mode insert
REPLACE INTO test(note) values("hello world");
REPLACE INTO test(note) values("hello again, world");
REPLACE INTO test(note) values("hello to the entire world");
REPLACE INTO test(note) values("hello world");
REPLACE INTO test(note) values("hello world");
-- This should fail due to a unique, but too short id
REPLACE INTO test(id, note) values("x","hello world");
-- List content
SELECT * FROM test;
```

```console
Error: stepping, CHECK constraint failed: length(ID) > 5 (19)
sqlite> -- List content
sqlite> SELECT * FROM test;
INSERT INTO "table" VALUES('cf2a966f-7d4a-4407-9bc1-355e9ec9d42b','2022-04-27 17:57:24',11,'hello world');
INSERT INTO "table" VALUES('a9c661b9-a638-4691-8690-3f6f7d9e7204','2022-04-27 17:57:24',18,'hello again, world');
INSERT INTO "table" VALUES('cc00c93f-3a4d-40dc-a566-236d98778945','2022-04-27 17:57:24',25,'hello to the entire world');
INSERT INTO "table" VALUES('46cbde09-f4fe-453a-8117-fc2cf7c8adda','2022-04-27 17:57:24',11,'hello world');
INSERT INTO "table" VALUES('4958f05d-f984-4f63-a187-c32f2c4ba6ea','2022-04-27 17:57:24',11,'hello world');
```
And the row with `id` = "x" fails, the NULL id's are replaced with random UUID's, the `t` holds a timestamp and finally the `size` holds the length of the `note`.

## References

- [Stackoverflow: SQLite - Generate GUID/UUID on SELECT INTO statement](https://stackoverflow.com/a/66625212)
- [SQLitetutorial.net: SQLite datetime Function](https://www.sqlitetutorial.net/sqlite-date-functions/sqlite-datetime-function/)
