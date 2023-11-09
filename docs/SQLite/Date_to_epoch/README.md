## Date to EPOCH and vice versa

```sql
-- Date to EPOCH and vice versa

DROP TABLE MyTable;
CREATE TABLE IF NOT EXISTS MyTable (
   epoch   TEXT ,
   iso      TEXT
);

-- set iso
REPLACE INTO MyTable (iso)
VALUES( "2023-11-09T04:22:00");

-- Update epoch from iso
-- select CAST(strftime('%s', '2018-03-31 01:02:03') as integer);
UPDATE MyTable SET epoch = (select CAST(strftime('%s', iso) as integer));

SELECT * from MyTable;

UPDATE MyTable SET iso = null;
SELECT * from MyTable;

-- Update ISO from epoch
-- UPDATE MyTable SET iso = (SELECT DATETIME(ROUND(epoch / 1000), 'unixepoch'));
UPDATE MyTable SET iso = (SELECT DATETIME(ROUND(epoch ), 'unixepoch'));

SELECT * from MyTable;
```
