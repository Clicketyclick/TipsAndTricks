
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
Or simplyfied: [Select last 10 records from a table](https://www.w3resource.com/sqlite-exercises/sqlite-subquery-exercise-14.php)

```sql
-- Selecting all columns (*) from a subquery result
SELECT * FROM (
  -- Selecting all columns (*) from the "employees" table, ordering by rowid in descending order, and limiting to the top 10 rows
  SELECT * FROM employees ORDER BY rowid DESC LIMIT 10
)
-- Ordering the results from the subquery by employee_id in ascending order
ORDER BY employee_id ASC;
```
