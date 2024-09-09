# Progress bar

Show a status bar in the console

[Based on @@stackoverflow_icon@@](https://stackoverflow.com/a/9853018)
 
```php
for($x=1;$x<=100;$x++){
    show_status($x, 100);
    usleep(100000);
 }
```

Will produce a bar like:

```console
[===>                           ]  10% 🕐  10/100        elap.⧔:  0 sec. remain.⧕:  0 sec. eta.𝜂  0
```
Building up till:

```console
[===============================] 100% 🕛 100/100        elap.⧔:  0 sec. remain.⧕:  0 sec. eta.𝜂  0
```

## Files

- [progressbar.php](progressbar.php)
- [progress_bar__test.php](progress_bar__test.php) Testing `progress_bar.php`
- [progress_bar__test.json](progress_bar__test.json) Expected output from test
