
## Timing

Timing and duration using microtime() - and beware of float math!

I was bold enough to use:
```php
$starttime  = microtime( TRUE );  // Initiate star
:
list($sec, $usec) = explode('.', microtime( TRUE ) - $starttime ); //split the microtime on .
print date('H:i:s.', $sec) . $usec;       //appends the decimal portion of seconds
```
Source: [@@Stackoverflow_icon@@ How to convert microtime() to HH:MM:SS:UU](https://stackoverflow.com/questions/16825240/how-to-convert-microtime-to-hhmmssuu)

BUT `microtime( TRUE ) - $starttime` does **NOT** do the job!

The two time stamps may/will not necessarily have the same precision i.e. you have a perverted result (See: [Warning. Floating point precision](https://www.php.net/manual/en/language.types.float.php).
Or for short: 0.0000081062 may be returned as 8.1062316894531E-6 - and displayed as 8.1 sec!

However using this litle gem:

```php
function microtime_diff( $time_end, $time_start, $precision = 10 )
{
    return( sprintf( "%.*f", $precision, round($time_end, $precision) - round($time_start, $precision) ) );
}   // microtime_diff()
```
can save you face.

Combining this with `microtime2human( $microtime )` you can do this:

```php
$time_start = microtime( TRUE );  // Initiate star
// do something
$time_end   = microtime(true);
$duration   = microtime_diff($time_end, $time_start);
print microtime2human( $duration );
```
and get a proper human readable result like:
```
00:00:00.0000090599
```
> [!NOTE]
> microtime2human() uses ISO-86001 for periode: P[n]Y[n]M[n]DT[n]H[n]M[n]S
> This is NOT pretty, but that's how the standard is.

### Sources

- [microtime2human()](microtime.php) - Return a human readable version of microtime (float) using ISO-86001 for periode: P[n]Y[n]M[n]DT[n]H[n]M[n]S
- [microtime_diff()](microtime.php) - Calculate the difference between to microtimes





