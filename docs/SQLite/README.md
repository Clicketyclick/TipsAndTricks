@@Sqlite_logo@@

## SQLite


### Date and time

- [Date and time](date-time/)  
Date and time functions
- [Date_to_epoch](Date_to_epoch)  
Date to EPOCH and vice versa


### Images

- [Handle images](handle_images/)
- [Raw images or Base64 encoded images](List_unique_indexes/)


### Indexes
- [`glob` vs. `like`](glob_like) - wildcard on index.
- [List unique indexes](List_unique_indexes/)


### Insert/update/replace

- [Default](select_default_value) value on SELECT: coalesce(x,y,..)
- [Delete rows with duplicate values](delete_rows_with_duplicate_values)  
How to delete all rows with duplicate values in 2 columns but keep the last inserted row?
     (Based on [<img src="../logo-stackoverflow.icon.png" title="Link to Stackoverflow" width=16px height=auto>](https://stackoverflow.com/a/74994082/7485823))
- [Copy one column at a time](Copy_one_column_at_a_time)  
Copy from one table to another - one column at a time
- [Insert UUID as ID](Insert_UUID_as_ID)
     (Based on [<img src="../logo-stackoverflow.icon.png" title="Link to Stackoverflow" width=16px height=auto>](https://stackoverflow.com/a/22725697/7485823))
- [UUID as default value for id](DefaultUUID/)  
    SQLite - Generate GUID/UUID on SELECT INTO statement
     (Based on [<img src="../logo-stackoverflow.icon.png" title="Link to Stackoverflow" width=16px height=auto>](https://stackoverflow.com/a/66625212))


### Profiling, debug and cleanup

- [Database analytics](Database_analytics/)
   - get the first 10 tables using the most disk space
   - see how efficiently the content of a table is stored on disk
   - average fan-out for a table
   - fraction of the pages in a database are sequential
- [Profiler](Profiler/) - Simple profiler for SQLite
- [Performance tuning](Performance_tuning/) - Read, write


### Select
- [Get the latest X rows of each action](latest_x_rows_of_each_action)  
Tail for SQLite
- [Diff on two tables](diff_on_two_tables)

### Strings

- [Handle newlines](handle_newlines/).  
Newlines (and other special characters) can be escaped using the CHAR() function or using the hex X'0A'.
- [Extract nested JSON from SQLite](SQLite2JSON_hash/)
     (Based on [<img src="../logo-stackoverflow.icon.png" title="Link to Stackoverflow" width=16px height=auto>](https://stackoverflow.com/a/61004015/7485823))

### Various

- [sqlean](sqlean/)  
All the Missing SQLite Functions (From [nalgeon / sqlean](https://github.com/nalgeon/sqlean))
- [Paradox](paradox/)  
Convert Paradox data to SQLite

