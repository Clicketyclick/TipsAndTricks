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
