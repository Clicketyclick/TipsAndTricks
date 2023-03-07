Reading: TipsAndTricks/docs/Php/of-course.md

### CORS on PHP (Of CORse)

If you don't have access to configure Apache, you can still send the header from a PHP script. It's a case of adding the following to your PHP scripts:
```php
 <?php
 header("Access-Control-Allow-Origin: *");
```
Note: as with all uses of the PHP header function, this must be before any output has been sent from the server.

Source: https://enable-cors.org/server_php.html

If you only want to open for a specific server:
```php
 <?php
 header("Access-Control-Allow-Origin: SOURCE-SERVER");
```
