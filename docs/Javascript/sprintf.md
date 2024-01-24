
## sprintf()

&nbsp;|&nbsp;
---|---
Read from:		| https://raw.githubusercontent.com/alexei/sprintf.js/master/src/sprintf.js
Redirect by:	| https://lukasgamper.medium.com/how-to-import-files-directly-from-github-1a41c72a3ad3

```javascript
<script src='https://cdn.jsdelivr.net/gh/alexei/sprintf.js@latest/src/sprintf.js'></script>
<script>

function print(str) { document.write(str + "<br>"); }

print(sprintf('%s: %s', 'Lives', 3));
print(sprintf('Your code is %s.', Math.round(Math.random()*999)));
print(sprintf('Hi %s, how are you doing?', 'Lee'));
print(sprintf('Hi %s %s, how are you doing %s?', 'Lee', 'Jensen', 'darling'));
print(sprintf('Latitude: %d, Longitude: %d, Count: %s', 41.847, -87.661, 'two'));
print(sprintf('Latitude: %04.2f, Longitude: %d, Count: %s', 41.847, -87.661, 'two'));
print( sprintf('%.2s ', 'Hello world') );

print( sprintf('%2$s %3$s a %1$s', 'cracker', 'Polly', 'wants') );
</script>
```
