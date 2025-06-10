## Queue

### Creating a queue system in SQLite
Source: https://stackoverflow.com/a/79315986

generate UUIDv7 using a view:
```sql
-- DROP VIEW IF EXISTS uuid7;
CREATE VIEW uuid7 AS
WITH unixtime AS (
    SELECT CAST((STRFTIME('%s') * 1000) + ((STRFTIME('%f') * 1000) % 1000) AS INTEGER) AS time
    -- SELECT CAST((UNIXEPOCH('subsec') * 1000) AS INTEGER) AS time -- for SQLite v3.38.0 (2022)
)
SELECT PRINTF('%08x-%04x-%04x-%04x-%012x', 
       (select time from unixtime) >> 16,
       (select time from unixtime) & 0xffff,
       ABS(RANDOM()) % 0x0fff + 0x7000,
       ABS(RANDOM()) % 0x3fff + 0x8000,
       ABS(RANDOM()) >> 16) AS next;
```
Usage:
```console
sqlite> SELECT next FROM uuid7;
01901973-f202-71ca-9a22-14e7146dab85
```

Creating the queue

```sql
DROP TABLE IF EXISTS queue;
CREATE TABLE queue (
    uuid TEXT PRIMARY KEY,
    created DATETIME DEFAULT(datetime('subsec')),
    content TEXT NOT NULL,
    CONSTRAINT check_queue_uuid CHECK (uuid REGEXP '[a-f0-9]{8}-([a-f0-9]{4}-){3}[a-f0-9]{12}')
);

-- DROP TRIGGER IF EXISTS trigger_after_insert_on_queue;
CREATE TRIGGER trigger_after_insert_on_queue
    AFTER INSERT ON queue FOR EACH ROW WHEN NEW.uuid IS NULL
BEGIN
    UPDATE queue SET uuid = (SELECT next FROM uuid7) WHERE ROWID = NEW.ROWID;
END;

```

### Insert values

```sql
INSERT INTO QUEUE (content)
VALUES ('one');

INSERT INTO QUEUE (content)
VALUES ('two');
```

### Read and delete entries

```sql
.mode box
DELETE FROM queue returning *;
SELECT * FROM queue;
```

```console
sqlite> DELETE FROM queue returning *;
┌──────────────────────────────────────┬─────────────────────────┬─────────┐
│                 uuid                 │         created         │ content │
├──────────────────────────────────────┼─────────────────────────┼─────────┤
│ 01975973-ac18-7ce6-b118-0403c3bae9ac │ 2025-06-10 10:47:22.392 │ one     │
│ 01975973-ac29-7a4f-a964-6a27c219b658 │ 2025-06-10 10:47:22.409 │ two     │
└──────────────────────────────────────┴─────────────────────────┴─────────┘
sqlite> SELECT * FROM queue;
sqlite>
```

> NOTE!
> The `DELETE ... returning` will delete the entries and return content (as a `SELECT` followed by `DELETE` would)

## Sources

- [https://www.w3schools.com/xml/ajax_database.asp](https://www.w3schools.com/xml/ajax_database.asp)
- [Using UUIDs in SQLite + generate UUIDv7 using a view](https://stackoverflow.com/a/79315986)
- [SQLite: Combine SELECT and DELETE in one statement](https://stackoverflow.com/a/70592506)
- [SQLite Current Timestamp with Milliseconds?](https://stackoverflow.com/a/17575175)
