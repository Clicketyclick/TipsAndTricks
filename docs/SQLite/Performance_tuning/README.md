## Performance tuning



```sql
/**
 *  @file      new 4
 *  @brief     SQLite performance tuning: concurrent reads, writes
 *  
 *  @details   
 *  
 *  @see		https://news.ycombinator.com/item?id=35547819
 *  
 *  @copyright http://www.gnu.org/licenses/lgpl.txt LGPL version 3
 *  @author    Erik Bachmann <ErikBachmann@ClicketyClick.dk>
 *  @since     2024-07-02T21:00:44 / Bruger
 *  @version   2024-07-02T21:00:44
 */

-- 

pragma journal_mode = WAL;
-- Instead of writing directly to the db file, write to a write-ahead-log instead and regularily commit the changes. Allows multiple concurrent readers, and can significantly improve performance.

PRAGMA synchronous=NORMAL;
-- or even off. normal is still completely corruption safe in WAL mode, and means not every insert/update has to wait for FSYNC. off can cause db corruption though I've never had problems. See here: https://www.sqlite.org/pragma.html#pragma_synchronous

pragma temp_store = memory;
-- stores temporary indices / tables in memory. sqlite automatically creates temporary indices for some queries. Not sure how much this one helps.

pragma mmap_size = 30000000000;
-- Uses memory mapping instead of read/write calls when db is < mmap_size. Less syscalls, and pages and caches will be managed by the OS, so the performance of this depends on your operating system. Note that it will not use this amount of physical memory, just virtual memory. Should be much faster on at least Linux.

pragma page_size = 32768;
-- this improved performance and db size a lot for me in one project, but that might only be true because i was storing somewhat large blobs in my database and might not be good for other projects where rows are small.
-- PRAGMA main.page_size = 4096;

PRAGMA main.cache_size=10000;
PRAGMA main.locking_mode=EXCLUSIVE;
PRAGMA main.temp_store = MEMORY;
```
