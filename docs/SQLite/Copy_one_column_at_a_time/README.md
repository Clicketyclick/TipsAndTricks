### Copy one column at a time (if exist)

```sql
-- Copy one column at a time
DROP TABLE table1;
DROP TABLE table2;

CREATE TABLE table1 (col1 TEXT, col2 TEXT);
CREATE TABLE tableB (colA TEXT, colB TEXT);
INSERT INTO table1 (col1,col2)
VALUES
	( 'value1',	'valuea'),
	( 'value2',	null),
	( 'value3',	'valueb')
;

-- Copy col1
INSERT INTO tableB (colB)
SELECT col1 FROM table1
;

-- copy col2
UPDATE tableB
SET colB = (
	SELECT col2
	FROM table1
	WHERE rowid = tableB.rowid
);

SELECT * FROM table1;
SELECT * FROM tableB;
```
https://stackoverflow.com/a/17703189


### Copy potential column
Copy column if exists - else insert default value
```sql
UPDATE audit
SET start = (   -- Set field in target
SELECT CASE 
         WHEN (SELECT name FROM pragma_table_info('audit_old') WHERE name = 'start')    -- column is found?
           IS NULL THEN ''                                                              -- Error if NOT
         ELSE ( SELECT start FROM audit_old WHERE rowid = audit.rowid)                  -- Else get value
       END 
	--WHERE rowid = audit.rowid                                                           -- Line by line
);
```
