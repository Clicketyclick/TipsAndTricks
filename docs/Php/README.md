@@Php_logo@@

## PHP 

- [CORS on PHP (Of CORse)](of-course.html)
- [Start local webserver (DOS)](local_server.html)
- [INI config](ini_config)

### PHP scripts

- [CPR](/cpr) Checking danish CPR-numbers (Personal identification number in Denmark)
- [Country Codes](/country.io/) - Country code lists bases on ISO2 and ISO3 combined into JSON structures.
- [JsonDb](/jsondb/) - Rutines to read / write JSON and mixed data to SQL database
- [Doxygen header](Doxygen/) - Dumping the Doxygen file header in current file
- [Parse_cli2request](parse_cli2request/) - Parse cli arguments and insert into $_REQUEST
- [Manipulate multi-dimensional array](Modify_structure/) - How to access and manipulate multi-dimensional array by key names / path
- [Progressbar for CLI](Progressbar/) - Show a status bar in the console
- [Read_text_block](Read_text_block/) - Read a block of text from file delimited by string as a record delimited
- [Get users full name](netuser) from windows
- [Timing](Timing/) - timing and duration using `microtime()` - and **beware** of float math!

### Tips

#### Date format

Format character | Example
---|---
`c`                | 2004-02-12T15:19:21+00:00
`Y-m-d\Th-i-s.e`   | 2025-07-29T11:57:22.Europe/Copenhagen
`Y-m-d\Th-i-s.P`   | 2025-07-29T11:57:22.+02:00

#### Recursive functions
Do not use "call to self" by name inside recursive functions. Use variable functions instead:

```php
function test($i) {
   static $__this = __FUNCTION__;
   if($i > 5) {
       echo $i. "\n";
       $__this($i-1);
   }
}
```
Source: [@@Stackoverflow_logo@@ Can you make a PHP function recursive without repeating its name?](https://stackoverflow.com/a/2719016)


## [@@Stackoverflow_logo@@ Can I make a PHP function "private" in a script?](https://stackoverflow.com/q/59420923/7485823)

`$func = function () { ... }`. Then you can use it as `$func();`.


#### Duration
See [Timing](Timing/)

### Modules

PHP 8. which gives error with  `imagettfbbox`. it has to be replaced with `imageftbbox`

```ini
extension=gd
;2024-03-13 19:11:05/ErBa ImageMagick
extension=php_imagick.dll
```


### Ini

#### CA certificates for SSL

Certificates are available from: https://curl.se/docs/caextract.html

Run this script in elevated state (CMD - not you)

```console
:getCacert
    CD "%ProgramFiles%\php"
    SET CACERTDIR="%ProgramFiles%\php\cacert"
    :: Create dir if not exist

    CD %CACERTDIR% 2>NUL || (ECHO %CACERTDIR% & MKDIR %CACERTDIR% & CD %CACERTDIR%)
    curl --etag-compare etag.txt --etag-save etag.txt --remote-name https://curl.se/ca/cacert.pem
    DIR
GOTO :EOF
```

Modify `php.ini` to enable the SSL:

```diff
- ;extension=openssl
---
+ ;2024-11-06T22:25:48/ErBa
+ extension=openssl
+ ;2023-10-11/ErBa Enable https requests https://stackoverflow.com/a/12587073
+ ;2024-07-19T08:31:58
+ ;;extension=openssl
```

```diff
+ ;2024-11-06T23:58:54/Erba curl: https://curl.se/docs/caextract.html
+ curl.cainfo ="C:\Program Files\php\cacert\cacert.pem"
1944a1988,1989
+ ;2024-11-06T23:59:20/ErBo curl: https://curl.se/docs/caextract.html
+ openssl.cafile="C:\Program Files\php\cacert\cacert.pem"
```
