## Profiler

Setting up a simple profiler in SQLite storing timestamps for start and end plus calculating the diff time.

Process:
1. Initiate tables `.read profiler_init.sql`
2. Run profiling:
    1. Setting name tag (default: `ìnit`): `REPLACE INTO variables (key, value ) VALUES( 'profiler_id','testing' );`
    2. Start profiling  `.read profiler_start.sql`
    3. End profiling    `.read profiler_end.sql`
3. Show results      `.read profiler_list.sql`

Initiate need only to be done once. But can also be used for clearning existing data sets from table.

The profiling can be run multiple times with various unique profiler_id's. 
If you do not change the profiler_id previous data will be overwritten.

Show results can be run at any given time after initiating. It simply lists the current status.


### Initiate

Creates tables or clears data in profiler.

Tables created:
- `variables` - Simple key/value list.
- `profiler` - Profiling data

### Start

Set the start timestamp.

If `profiler_id` is set in table `variables` the ID is listed:

```console
┌─────────────┐
│ profiler_id │
├─────────────┤
│ testing     │
└─────────────┘
```

If `profiler_id` not given in table `variables` a warning is issued:

```console
┌───────────────────────────────────────┐
│              profiler_id              │
├───────────────────────────────────────┤
│ Set "profiler_id" in variables like:  │
│                                       │
│ REPLACE INTO variables (key, value )  │
│ VALUES( 'profiler_id','testing' );    │
└───────────────────────────────────────┘
```



### Example

```console
sqlite> .read profiler_init.sql
-- Initiating profiler by creating tables
CREATE TABLE profiler(
    id          TEXT PRIMARY KEY,
    start       TEXT DEFAULT (STRFTIME('%Y-%m-%d %H:%M:%f', 'NOW')),
    end         TEXT DEFAULT NULL,
    diff        TEXT DEFAULT NULL
);
sqlite> .read profiler_start.sql
-- Setting profiler start
┌───────────────────────────────────────┐
│              profiler_id              │
├───────────────────────────────────────┤
│ Set "profiler_id" in variables like:  │
│                                       │
│ REPLACE INTO variables (key, value )  │
│ VALUES( 'profiler_id','testing' );    │
└───────────────────────────────────────┘
┌──────┬─────────────────────────┬─────┬──────┐
│  id  │          start          │ end │ diff │
├──────┼─────────────────────────┼─────┼──────┤
│ init │ 2024-05-23 06:47:15.257 │     │      │
└──────┴─────────────────────────┴─────┴──────┘
sqlite> .read profiler_end.sql
-- Setting end value for session in profiler
┌──────┬─────────────────────────┬─────────────────────────┬──────────────────┐
│  id  │          start          │           end           │       diff       │
├──────┼─────────────────────────┼─────────────────────────┼──────────────────┤
│ init │ 2024-05-23 06:47:15.257 │ 2024-05-23 06:47:26.903 │ 11.1099998950958 │
└──────┴─────────────────────────┴─────────────────────────┴──────────────────┘
```

And a second run with `profiler_id` set:


```console
sqlite> REPLACE INTO variables (key, value ) VALUES( 'profiler_id','testing' );
sqlite> .read profiler_start.sql
-- Setting profiler start
┌─────────────┐
│ profiler_id │
├─────────────┤
│ testing     │
└─────────────┘
┌─────────┬─────────────────────────┬─────────────────────────┬──────────────────┐
│   id    │          start          │           end           │       diff       │
├─────────┼─────────────────────────┼─────────────────────────┼──────────────────┤
│ init    │ 2024-05-23 07:09:48.267 │ 2024-05-23 07:09:58.669 │ 10.0999999046326 │
│ testing │ 2024-05-23 07:15:10.880 │                         │                  │
└─────────┴─────────────────────────┴─────────────────────────┴──────────────────┘
sqlite> .read profiler_end.sql
-- Setting end value for session in profiler
┌─────────┬─────────────────────────┬─────────────────────────┬──────────────────┐
│   id    │          start          │           end           │       diff       │
├─────────┼─────────────────────────┼─────────────────────────┼──────────────────┤
│ init    │ 2024-05-23 07:09:48.267 │ 2024-05-23 07:09:58.669 │ 10.0999999046326 │
│ testing │ 2024-05-23 07:15:10.880 │ 2024-05-23 07:15:19.375 │ 9.09000015258789 │
└─────────┴─────────────────────────┴─────────────────────────┴──────────────────┘
sqlite> .read profiler_list.sql
-- Listing profiling
┌─────────┬─────────────────────────┬─────────────────────────┬──────────────────┐
│   id    │          start          │           end           │       diff       │
├─────────┼─────────────────────────┼─────────────────────────┼──────────────────┤
│ init    │ 2024-05-23 07:09:48.267 │ 2024-05-23 07:09:58.669 │ 10.0999999046326 │
│ testing │ 2024-05-23 07:15:10.880 │ 2024-05-23 07:15:19.375 │ 9.09000015258789 │
└─────────┴─────────────────────────┴─────────────────────────┴──────────────────┘
```


### Source

- [`profiler_init.sql`](profiler_init.sql)
- [`profiler_start.sql`](profiler_start.sql)
- [`profiler_end.sql`](profiler_end.sql)
- [`profiler_list.sql`](profiler_list.sql)

---
