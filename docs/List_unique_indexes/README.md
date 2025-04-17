## List unique indexes

Source: [@@Stackoverflow_icon@@](https://stackoverflow.com/a/53629321/7485823)

As of sqlite 3.16.0 you could also use pragma functions:

### List all names of unique indexes
```sql
-- list all names of unique indexes.
SELECT distinct il.name
  FROM sqlite_master AS m,
       pragma_index_list(m.name) AS il,
       pragma_index_info(il.name) AS ii
 WHERE m.type='table' AND il.[unique] = 1;
```

### List all tables and their columns if the column is part of a unique index.
```sql
-- List all tables and their columns if the column is part of a unique index.
SELECT DISTINCT m.name as table_name, ii.name as column_name, il.name as index_name
  FROM sqlite_master AS m,
       pragma_index_list(m.name) AS il,
       pragma_index_info(il.name) AS ii
 WHERE m.type='table' AND il.[unique] = 1;
```
