# Timestamp with subseconds
https://stackoverflow.com/a/17575175


replace:
```sql
   d1 DATETIME DEFAULT(datetime('now')),    -- 2026-01-26 08:53:51
```
with
```sql
   d2 DATETIME DEFAULT(datetime('subsec')), -- 2026-01-26 08:53:51.792
```


## Example

```sql

DROP TABLE datetime_text;
CREATE TABLE datetime_text(
   action text NOT NULL,
   d1 DATETIME DEFAULT(datetime('now')),    -- 2026-01-26 08:53:51
   d2 DATETIME DEFAULT(datetime('subsec')), -- 2026-01-26 08:53:51.792
   diff REAL
);

-- On INSERT
CREATE TRIGGER datetime_text_ai_diff
AFTER INSERT ON datetime_text
FOR EACH ROW
WHEN NEW.d1 IS NOT NULL AND NEW.d2 IS NOT NULL
BEGIN
  UPDATE datetime_text
  SET diff = unixepoch(NEW.d2, 'subsec') - unixepoch(NEW.d1, 'subsec')
  WHERE rowid = NEW.rowid;
END;

/*
-- On UPDATE
CREATE TRIGGER datetime_text_au_diff
AFTER UPDATE OF d1, d2 ON datetime_text
FOR EACH ROW
WHEN NEW.d1 IS NOT NULL AND NEW.d2 IS NOT NULL
BEGIN
  UPDATE datetime_text
  SET diff = unixepoch(NEW.d2, 'subsec') - unixepoch(NEW.d1, 'subsec')
  WHERE rowid = NEW.rowid;
END;
*/
```


## Test

```sql
INSERT INTO datetime_text (action)
VALUES( 'boo' );

SELECT * FROM datetime_text;
```
> 2026-01-26 08:25:06**.608**|2026-01-26 08:25:06

