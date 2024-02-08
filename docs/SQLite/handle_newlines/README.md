## Handle newlines

Newlines (and other special characters) can be escaped using the `CHAR()` function or using the hex `X'0A'`

Beaware that if you're operating in a mixed environment you should use the two level replacement. This can be used on both Windows (`\r\n`) and Linux (`\n`)[^1].
[^1]: On older MAC's newline *can* be `\r`.

### Example
```sql
DROP TABLE IF EXISTS temp_config;
CREATE TEMP TABLE temp_config (
    key         TEXT NOT NULL,
    value       TEXT NOT NULL
);

REPLACE INTO temp_config
VALUES 
    ('first',   "Hello
World"),
    ('second', "Hello\nAgain")
;

.mode box
-- Two level replacement: First \n, then \r`- the safe way
SELECT key, replace( replace( value, CHAR(10), "<BR>"), CHAR(13), "<!-- -->") FROM temp_config;
-- Combined replacement: \r\n
SELECT key, replace( value, CHAR(13)||CHAR(10), "<BR>") FROM temp_config; 
-- Select using hex:
SELECT key, replace( value, X'0A', '\n') FROM temp_config;
```

#### Output
```console
sqlite> -- Two level replacement: First \n, then \r
sqlite> SELECT key, replace( replace( value, CHAR(10), "<BR>"), CHAR(13), "<!-- -->") FROM temp_config;
┌────────┬───────────────────────────────────────────────────────────────────┐
│  key   │ replace( replace( value, CHAR(10), "<BR>"), CHAR(13), "<!-- -->") │
├────────┼───────────────────────────────────────────────────────────────────┤
│ first  │ Hello<BR>World                                                    │
│ second │ Hello\nAgain                                                      │
└────────┴───────────────────────────────────────────────────────────────────┘
sqlite> -- Combined replacement: \r\n
sqlite> SELECT key, replace( value, CHAR(13)||CHAR(10), "<BR>") FROM temp_config;
┌────────┬─────────────────────────────────────────────┐
│  key   │ replace( value, CHAR(13)||CHAR(10), "<BR>") │
├────────┼─────────────────────────────────────────────┤
│ first  │ Hello
World                                 │
│ second │ Hello\nAgain                                │
└────────┴─────────────────────────────────────────────┘
-- Select using hex:
SELECT key, replace( value, X'0A', '\n') FROM temp_config;
┌────────┬──────────────────────────────┐
│  key   │ replace( value, X'0A', '\n') │
├────────┼──────────────────────────────┤
│ first  │ Hello\nWorld                 │
│ second │ Hello\nAgain                 │
└────────┴──────────────────────────────┘
```
