@@Sqlite_logo@@

## SQLite

- [`glob` vs. `like`](glob_like) - wildcard on index.
- [Default](select_default_value) value on SELECT: coalesce(x,y,..)
- [Handle images](handle_images/)
- [Diff on two tables](diff_on_two_tables)
- [List unique indexes](List_unique_indexes/)

Raw images or Base64 encoded images
- [Handle newlines](handle_newlines/).  
Newlines (and other special characters) can be escaped using the CHAR() function or using the hex X'0A'.
- [Delete rows with duplicate values](delete_rows_with_duplicate_values)  
How to delete all rows with duplicate values in 2 columns but keep the last inserted row?
     (Based on [<img src="../logo-stackoverflow.icon.png" title="Link to Stackoverflow" width=16px height=auto>](https://stackoverflow.com/a/74994082/7485823))
- [Insert UUID as ID](Insert_UUID_as_ID)
     (Based on [<img src="../logo-stackoverflow.icon.png" title="Link to Stackoverflow" width=16px height=auto>](https://stackoverflow.com/a/22725697/7485823))
- [Extract nested JSON from SQLite](SQLite2JSON_hash/)
     (Based on [<img src="../logo-stackoverflow.icon.png" title="Link to Stackoverflow" width=16px height=auto>](https://stackoverflow.com/a/61004015/7485823))
[UUID as default value for id](DefaultUUID/)  
SQLite - Generate GUID/UUID on SELECT INTO statement
     (Based on [<img src="../logo-stackoverflow.icon.png" title="Link to Stackoverflow" width=16px height=auto>](https://stackoverflow.com/a/66625212))
- [sqlean](sqlean/)  
All the Missing SQLite Functions (From [nalgeon / sqlean](https://github.com/nalgeon/sqlean))
- [Database analytics](Database_analytics/)
   - get the first 10 tables using the most disk space
   - see how efficiently the content of a table is stored on disk
   - average fan-out for a table
   - fraction of the pages in a database are sequential
- [Date and time](date-time/)  
Date and time functions
- [Paradox](paradox/)  
Convert Paradox data to SQLite
- [Date_to_epoch](Date_to_epoch)  
Date to EPOCH and vice versa
- [Copy one column at a time](Copy_one_column_at_a_time)  
Copy from one table to another - one column at a time
- [Get the latest X rows of each action](latest_x_rows_of_each_action)  
Tail for SQLite
- [Profiler](Profiler/)  
Simple profiler for SQLite
- [Performance tuning](Performance_tuning/) - Read, write
