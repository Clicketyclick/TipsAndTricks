
Example from: [stackoverflow.com](https://stackoverflow.com/a/74994082/7485823)

How to delete all rows with duplicate values in 2 columns but keep the last inserted row?

> I want to remove any rows that have duplicate values 
> in columns val1 and val2 (so that would be rows 1 and 2) 
> but keep the row that was inserted last (row 2). 
> In the example table only row 1 would be removed.

```sql
CREATE TABLE queue
    (`id` int, `val1` int, `val2` int, `timestamp` float, `datatype` int )
;
    
INSERT INTO queue
    (`id`, `val1`, `val2`, `timestamp`, `datatype`)
VALUES
    (1, 50, 100, 1471869500, 1),
    (2, 50, 100, 1471869800, 1),
    (3, 60, 70, 1471869800, 1),
    (4, 60, 80, 1471823500, 1),
    (5, 60, 90, 1472869500, 1),
    (6, 60, 100, 1471862500, 1)
;
```
```sql
DELETE
FROM queue
WHERE rowid NOT IN (
  SELECT MAX(rowid) 
  FROM queue 
  GROUP BY val1, val2
);

SELECT * 
FROM queue;
```


id	|val1	|val2	|timestamp	|datatype
---|---|---|---|---
2	|50	|100	|1471869800	|1
3	|60	|70	|1471869800	|1
4	|60	|80	|1471823500	|1
5	|60	|90	|1472869500	|1
6	|60	|100	|1471862500	|1
