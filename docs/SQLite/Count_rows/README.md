# What is the most efficient way to count rows in a table in SQLite?

Source: https://chatgpt.com/c/6a5e11d3-d140-83eb-9b5b-8751787e6e11

For an **exact count of all rows**, use:

```sql
SELECT COUNT(*) FROM table_name;
```

This is the most efficient standard form in SQLite.

### Why `COUNT(*)`?

SQLite can count the table’s B-tree entries without loading or interpreting every column value.

These alternatives are not faster:

```sql
SELECT COUNT(1) FROM table_name;
SELECT COUNT(rowid) FROM table_name;
SELECT COUNT(id) FROM table_name;
```

`COUNT(id)` may also produce a different result because it excludes rows where `id` is `NULL`. `COUNT(rowid)` does not work for `WITHOUT ROWID` tables.

### Counting filtered rows

```sql
SELECT COUNT(*)
FROM table_name
WHERE status = 'active';
```

Create an index on frequently filtered columns:

```sql
CREATE INDEX idx_table_status
ON table_name(status);
```

SQLite may then count matching entries directly from the smaller covering index:

```sql
SELECT COUNT(*)
FROM table_name
WHERE status = 'active';
```

Confirm the query plan with:

```sql
EXPLAIN QUERY PLAN
SELECT COUNT(*)
FROM table_name
WHERE status = 'active';
```

### For very large tables and frequent counts

SQLite does not normally maintain a stored row count. If counting repeatedly becomes expensive, maintain one explicitly:

```sql
CREATE TABLE table_statistics (
    table_name TEXT PRIMARY KEY,
    row_count  INTEGER NOT NULL
);

INSERT INTO table_statistics(table_name, row_count)
VALUES ('my_table', 0);
```

Then update it with triggers:

```sql
CREATE TRIGGER my_table_count_insert
AFTER INSERT ON my_table
BEGIN
    UPDATE table_statistics
    SET row_count = row_count + 1
    WHERE table_name = 'my_table';
END;

CREATE TRIGGER my_table_count_delete
AFTER DELETE ON my_table
BEGIN
    UPDATE table_statistics
    SET row_count = row_count - 1
    WHERE table_name = 'my_table';
END;
```

The count becomes constant-time:

```sql
SELECT row_count
FROM table_statistics
WHERE table_name = 'my_table';
```

For ordinary use, however, the correct choice remains:

```sql
SELECT COUNT(*) FROM table_name;
```
