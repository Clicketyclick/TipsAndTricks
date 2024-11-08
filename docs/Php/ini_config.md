
### INI config

Mimimum changes to php.ini (from php.ini-development)
```diff
12,13c12,13
< ; 2. The PHPRC environment variable. (As of PHP 5.2.0)
< ; 3. A number of predefined registry keys on Windows (As of PHP 5.2.0)
---
> ; 2. The PHPRC environment variable.
> ; 3. A number of predefined registry keys on Windows
407c407,409
< max_execution_time = 30
---
> ;max_execution_time = 30
> ;2024-03-03 13:47:01/ErBa No limit on execution-time
> max_execution_time = 0
433c435,436
< memory_limit = 128M
---
> ;memory_limit = 128M
> memory_limit = 8589934592
541a545
> ; 2024-07-19T08:29:48: on
650c654,656
< variables_order = "GPCS"
---
> ;variables_order = "GPCS"
> ;2024-10-29T13:16:19/ErBa
> variables_order = "EGPCS"
768c774
< ;extension_dir = "ext"
---
> extension_dir = "ext"
863a870
> ;2023-10-11/ErBa https://stackoverflow.com/a/12587073
868c875,878
< allow_url_include = Off
---
> ;2023-10-18T09:59:26/ErBa	Deprecated: Directive 'allow_url_include' is deprecated in Unknown on line 0
> ;allow_url_include = Off
> ;allow_url_include = On
> 
925a936,937
> ;2024-11-06T23:57:02/Erba curl
> extension=ldap
927a940,941
> ;2024-11-06T23:57:02/Erba curl
> extension=curl
931c945
< ;extension=gd
---
> extension=gd
934a949,954
> ;2024-03-13 19:11:05/ErBa ImageMagick: From http://pecl.php.net/package/imagick
> extension=php_imagick.dll
> ;2024-03-02 16:07:58/erBa numberformatter
> ;2024-07-19T08:31:58
> ;;extension=intl
936,937c956,961
< ;extension=mbstring
< ;extension=exif      ; Must be after mbstring as it depends on it
---
> ;2023-03-07/ErBa
> ;2024-07-19T08:31:58
> extension=mbstring
> ;2023-03-07/ErBa
> ;2024-07-19T08:31:58
> extension=exif      ; Must be after mbstring as it depends on it
942c966,970
< ;extension=openssl
---
> ;2024-11-06T22:25:48/ErBa
> extension=openssl
> ;2023-10-11/ErBa Enable https requests https://stackoverflow.com/a/12587073
> ;2024-07-19T08:31:58
> ;;extension=openssl
948c976,977
< ;extension=pdo_sqlite
---
> ;2023-03-07/ErBa
> extension=pdo_sqlite
959,960c988,991
< ;extension=sqlite3
< ;extension=tidy
---
> ;2023-03-07/ErBa
> extension=sqlite3
> ;2023-03-07/ErBa
> extension=tidy
961a993,994
> ;2023-03-07/ErBa
> ;extension=zip
1288a1322,1328
> ; Tuning: Sets the amount of LOB data that is internally returned from
> ; Oracle Database when an Oracle LOB locator is initially retrieved as
> ; part of a query. Setting this can improve performance by reducing
> ; round-trips.
> ; https://php.net/oci8.prefetch-lob-size
> ; oci8.prefetch_lob_size = 0
> 
1901a1942
> ; This should improve performance, but requires appropriate OS configuration.
1935a1977,1978
> ;2024-11-06T23:58:54/Erba curl: https://curl.se/docs/caextract.html
> curl.cainfo ="C:\Program Files\php\cacert\cacert.pem"
1944a1988,1989
> ;2024-11-06T23:59:20/ErBo curl: https://curl.se/docs/caextract.html
> openssl.cafile="C:\Program Files\php\cacert\cacert.pem"
```
