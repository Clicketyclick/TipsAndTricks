
## `glob` vs. `like` - wildcard on index.

`like` can really kill your database performance.

Replacing:
```sql
SELECT DISTINCT path FROM images WHERE path = '%s';
```
With:
```sql
SELECT DISTINCT path FROM images WHERE path glob '%s*';
```
reduced excecution time from aprox. 2 MINUTES to 2 seconds!!!

> [!NOTE]
> This DOES requre and index on images.path !

The [Documentation](https://www.sqlite.org/lang_expr.html#glob) states:

> The GLOB operator is similar to LIKE but uses the Unix file globbing syntax for its wildcards. Also, GLOB is case sensitive, unlike LIKE. Both GLOB and LIKE may be preceded by the NOT keyword to invert the sense of the test. The infix GLOB operator is implemented by calling the function glob(Y,X) and can be modified by overriding that function.


This is explained so brilliantly by *Ciro Santilli* OurBigBook.com in [Should LIKE 'searchstr%' use an index?](https://stackoverflow.com/a/76512019).
