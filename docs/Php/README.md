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
- [parse_cli2request](parse_cli2request/) - Parse cli arguments and insert into $_REQUEST
- [manipulate multi-dimensional array](Modify_structure/) - How to access and manipulate multi-dimensional array by key names / path

### Tips

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

#### Duration

```php
$starttime  = microtime( TRUE );  // Initiate star
:
list($sec, $usec) = explode('.', microtime( TRUE ) - $starttime ); //split the microtime on .
print date('H:i:s.', $sec) . $usec;       //appends the decimal portion of seconds
```
Source: [@@Stackoverflow_icon@@ How to convert microtime() to HH:MM:SS:UU](https://stackoverflow.com/questions/16825240/how-to-convert-microtime-to-hhmmssuu)

### Modules

PHP 8. which gives error with  `imagettfbbox`. it has to be replaced with `imageftbbox`

```ini
extension=gd
;2024-03-13 19:11:05/ErBa ImageMagick
extension=php_imagick.dll
```


