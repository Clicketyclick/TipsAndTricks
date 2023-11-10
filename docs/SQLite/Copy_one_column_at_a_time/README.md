### Copy one column at a time

```sql
-- Copy one column at a time
drop table table1;
drop table table2;

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
select col1 from table1
;

-- copy col2
UPDATE tableB
SET colB = (
	SELECT col2
	FROM table1
	WHERE rowid = tableB.rowid
);

select * from table1;
select * from tableB;
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
         ELSE ( select start from audit_old WHERE rowid = audit.rowid)                  -- Else get value
       END 
	--WHERE rowid = audit.rowid                                                           -- Line by line
);
```
