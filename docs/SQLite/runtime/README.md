
## Runtime calculation

Based on https://www.sqlitetutorial.net/sqlite-date/ I've build this runtime calculator

```sql
---
DROP TABLE time_stamp IF EXISTS;

CREATE TEMPORARY TABLE IF NOT EXISTS time_stamp(
    key     TEXT        DEFAULT('starttime'),
    utc     DATETIME    DEFAULT(datetime('subsec')),
    local   DATETIME    DEFAULT(datetime('subsec', 'localtime')),
    PRIMARY KEY ( key )
);
```
Initiate start:
```sql
INSERT INTO time_stamp DEFAULT VALUES;
```

Set endtime (= now)
```sql
REPLACE INTO time_stamp(key)  VALUES( 'endtime' );
```

Now you can start calculating:

### Simple query

```sql
-- TYPE
SELECT
	key,
	utc,
	typeof(utc),
	local,
	typeof(local)
FROM
	time_stamp;
```

Example

```console
starttime|2026-05-19 05:56:02.586|text|2026-05-19 07:56:02.586|text
endtime|2026-05-19 06:01:56.263|text|2026-05-19 08:01:56.263|text
```

### Simple runtime

Based on UTC

```sql
SELECT 'UTC runtime: '||
    ROUND(
        (julianday(e.utc) - julianday(s.utc)) * 86400.0,
        3
    ) AS runtime_seconds
FROM time_stamp AS s
JOIN time_stamp AS e
    ON s.key = 'starttime'
   AND e.key = 'endtime';
```
Example

```console
UTC runtime: 353.677
```


Based on local time

```sql
SELECT 'Local runtime: '||
    ROUND(
        (julianday(e.local) - julianday(s.local)) * 86400.0,
        3
    ) AS runtime_seconds
FROM time_stamp AS s
JOIN time_stamp AS e
    ON s.key = 'starttime'
   AND e.key = 'endtime';
```


```console
Local runtime: 353.677
```

> [!NOTE]
> UTC vs. local ?! This really makes NO difference!

### Human readable runtime

#### ISO-8601 duration (PT...S)

```sql
SELECT
    printf(
        'PT%.3fS',
        (julianday(e.utc) - julianday(s.utc)) * 86400.0
    ) AS runtime_iso8601
FROM time_stamp AS s
JOIN time_stamp AS e
    ON s.key = 'starttime'
   AND e.key = 'endtime';
```

Example output:
```console
PT1.237S
```

#### Full ISO-8601 duration

```sql
WITH diff(seconds) AS (
    SELECT (julianday(e.utc) - julianday(s.utc)) * 86400.0
    FROM time_stamp s
    JOIN time_stamp e
      ON s.key = 'starttime'
     AND e.key = 'endtime'
)
SELECT printf(
    'PT%dH%dM%.3fS',
    CAST(seconds / 3600 AS INT),
    CAST((seconds % 3600) / 60 AS INT),
    (seconds % 60)
) AS runtime_iso8601
FROM diff;
```
Example output:
```console
PT1H2M3.456S
```

### human readable: YYYY-MM-DDThh:mm.ss.m

Runtime as an offset from a zero epoch and use strftime (1970-)

```sql
WITH diff(seconds) AS (
    SELECT (julianday(e.utc) - julianday(s.utc)) * 86400.0
    FROM time_stamp s
    JOIN time_stamp e
      ON s.key = 'starttime'
     AND e.key = 'endtime'
)
SELECT strftime(
    '%Y-%m-%dT%H:%M:%f',
    seconds,
    'unixepoch'
) AS runtime
FROM diff;
```
Example

```console
1970-01-01T00:00:01.237
```

> [!NOTE]
> This is not really a duration format — it is a timestamp relative to the Unix epoch.

For durations, a more semantically correct human-readable format is usually:

```console
0000-00-00T01:02:03.456
```

which SQLite does not directly support.

You can construct that manually:

```sql
WITH diff(seconds) AS (
    SELECT (julianday(e.utc) - julianday(s.utc)) * 86400.0
    FROM time_stamp s
    JOIN time_stamp e
      ON s.key = 'starttime'
     AND e.key = 'endtime'
)
SELECT printf(
    '0000-00-00T%02d:%02d:%06.3f',
    CAST(seconds / 3600 AS INT),
    CAST((seconds % 3600) / 60 AS INT),
    (seconds % 60)
) AS runtime
FROM diff;
```

Example

```console
0000-00-00T01:02:03.456
```

## Full Example

`initRuntime.sql`:
```sql
/**
 * @file       initRuntime.sql
 * @brief      Creating a TEMP table for runtime
 * @details    
 * 
 * @copyright  http://www.gnu.org/licenses/lgpl.txt LGPL version 3
 * @author     Erik Bachmann <Erik@ClicketyClick.dk>
 * @since      2026-05-19T08:49:31 / erba
 * @version    2026-05-19T08:49:31
 */

DROP TABLE IF EXISTS time_stamp;

CREATE TEMPORARY TABLE IF NOT EXISTS time_stamp(
    key     TEXT        DEFAULT('starttime'),
    utc     DATETIME    DEFAULT(datetime('subsec')),
    local   DATETIME    DEFAULT(datetime('subsec', 'localtime')),
    PRIMARY KEY ( key )
);

-- Initiate start:
INSERT INTO time_stamp DEFAULT VALUES;
```

`getRuntime.sql`:

```sql
/**
 * @file       getRuntime.sql
 * @brief      Calculate runtime
 * @details    
 * 
 * @copyright  http://www.gnu.org/licenses/lgpl.txt LGPL version 3
 * @author     Erik Bachmann <Erik@ClicketyClick.dk>
 * @since      2026-05-19T08:51:01 / erba
 * @version    2026-05-19T08:51:01
 */

REPLACE INTO time_stamp(key)  VALUES( 'endtime' );
WITH diff(seconds) AS (
    SELECT (julianday(e.utc) - julianday(s.utc)) * 86400.0
    FROM time_stamp s
    JOIN time_stamp e
      ON s.key = 'starttime'
     AND e.key = 'endtime'
)
SELECT printf(
    '0000-00-00T%02d:%02d:%06.3f',
    CAST(seconds / 3600 AS INT),
    CAST((seconds % 3600) / 60 AS INT),
    (seconds % 60)
) AS runtime
FROM diff;
```
