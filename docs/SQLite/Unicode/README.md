
## Unicode

### Decoding imbedded encoded Uncode characters

```diff
- \u00E6\u00F8\u00E5\u00C6\u00D8\u00C5
+ æøåÆØÅ
```

```sql
SELECT '- Decoding unicode';
UPDATE meta
SET record = json_extract(
    '"' || 
    REPLACE(
        REPLACE(
            REPLACE(record, '\', '\\'), -- 1. Escape all backslashes
        '\\u', '\u'),                             -- 2. Put the unicode markers back to normal
    '"', '\"')                                    -- 3. Escape any existing double quotes
    || '"', 
'$')
--WHERE rowid=2
;
SELECT record FROM meta
-- WHERE rowid=2
;
```
