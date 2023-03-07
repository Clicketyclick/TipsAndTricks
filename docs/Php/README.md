## PHP 

[CORS on PHP (Of CORse)(of-course.html)


### INI config

Mimimum changes to php.ini (from php.ini-development)
```diff
763c763
< ;extension_dir = "ext"
---
> extension_dir = "ext"
931,932c931,934
< ;extension=mbstring
< ;extension=exif      ; Must be after mbstring as it depends on it
---
> ;2023-03-07/ErBa
> extension=mbstring
> ;2023-03-07/ErBa
> extension=exif      ; Must be after mbstring as it depends on it
943c945,946
< ;extension=pdo_sqlite
---
> ;2023-03-07/ErBa
> extension=pdo_sqlite
954,955c957,960
< ;extension=sqlite3
< ;extension=tidy
---
> ;2023-03-07/ErBa
> extension=sqlite3
> ;2023-03-07/ErBa
> extension=tidy
957c962,963
< ;extension=zip
---
> ;2023-03-07/ErBa
> extension=zip
```
