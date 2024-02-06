## SELECT default value - if not found

Wanting a default value on not found?

COALESCE is the thing.

The COALESCE function accepts two or more arguments and returns the first non-null argument.

```sql
CREATE TABLE IF NOT EXISTS Vars
        (
                key   TEXT PRIMARY KEY,
                value TEXT
        )
;
REPLACE INTO vars 
	VALUES 
	('name', 'database')
,	('version', '00.01')
,	('release', CURRENT_TIMESTAMP )
;
```
- Get existing value: database
```sql
SELECT COALESCE((SELECT value FROM  vars where key = 'name'), 'xxx');
```

- Get default value: xxx since 'alias' is not found
```sql
SELECT COALESCE((SELECT value FROM  vars where key = 'alias'), 'xxx');
```

- Get default value: xxx since neither 'alias' nor 'level' is found
```sql
SELECT COALESCE(
   (SELECT value FROM  vars where key = 'alias')
,  (SELECT value FROM  vars where key = 'level') 
,  'xxx');
```


```sql
sqlite> SELECT COALESCE((SELECT key FROM  vars where key = 'name'), 'xxx');
name
sqlite> SELECT COALESCE((SELECT key FROM  vars where key = 'namex'), 'xxx');
xxx
```
