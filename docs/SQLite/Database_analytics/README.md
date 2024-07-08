## Database analytics

```sql
-- https://stackoverflow.com/a/60376608
-- get the first 10 tables using the most disk space
SELECT rowid, name, sum(pgsize) AS size FROM dbstat GROUP BY name
  ORDER BY size DESC LIMIT 10;

-- To see how efficiently the content of a table is stored on disk, compute the amount of space used to hold actual content divided by the total amount of disk space used. 
-- The closer this number is to 100%, the more efficient the packing.
SELECT sum(pgsize-unused)*100.0/sum(pgsize) FROM dbstat WHERE name='audit';
SELECT (pgsize-unused)*100.0/pgsize FROM dbstat
 WHERE name='audit' AND aggregate=TRUE;

-- average fan-out for a table
SELECT avg(ncell) FROM dbstat WHERE name='audit' AND pagetype='internal';

-- fraction of the pages in a database are sequential 
CREATE TEMP TABLE s(rowid INTEGER PRIMARY KEY, pageno INT);
INSERT INTO s(pageno) SELECT pageno FROM dbstat ORDER BY path;
SELECT sum(s1.pageno+1==s2.pageno)*1.0/count(*)
  FROM s AS s1, s AS s2
 WHERE s1.rowid+1=s2.rowid;
DROP TABLE s;
```
