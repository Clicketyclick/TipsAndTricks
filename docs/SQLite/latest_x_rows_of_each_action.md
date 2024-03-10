
## Get the latest X rows of each action 

```sql
-- Get the latest X rows of each action from audit
-- https://stackoverflow.com/a/43455229
CREATE INDEX IF NOT EXISTS idx_audit_action_start
on audit(action, start)
;

SELECT action, start
 FROM audit a
    WHERE a.ROWID IN  
    ( SELECT b.ROWID FROM audit b
      WHERE b.action = a.action
      ORDER by start DESC 
      LIMIT 2 
    ) 
    ORDER BY action, start ASC
    ;
```
