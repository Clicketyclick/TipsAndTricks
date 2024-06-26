## Date and time


**SQLite does not have a dedicated date/time datatype!** (Periode!)

Dates and timestamps can best be stored as TEXT. This makes spaces, punctuation etc. valid.
Else you'll have to deal with `integer` or `real` values.

SQLite supports seven scalar date and time functions as follows:

1. date(time-value, modifier, modifier, ...)  
2. time(time-value, modifier, modifier, ...)  
3. datetime(time-value, modifier, modifier, ...)  
4. julianday(time-value, modifier, modifier, ...)  
5. unixepoch(time-value, modifier, modifier, ...)  
6. strftime(format, time-value, modifier, modifier, ...)  
7. timediff(time-value, time-value)  


## date() - 'YYYY-MM-DD'

Simple date as text in this format: YYYY-MM-DD. 

Example: `2024-05-23`

```sql
SELECT date();
```

## time() - 'hh:mm:ss'

Simple time format as text 
in formatted as HH:MM:SS or as HH:MM:SS.SSS if the subsec modifier is used.

Example: `17:45:36`

```sql
SELECT time();
```

Example: `18:03:11.796`

```sql
SELECT time('subsec');
```


## datetime() - 'YYYY-MM-DD hh:mm:ss'

Example: `2024-05-23 17:48:50`

```sql
SELECT datetime();
```

Example: `2024-05-23 18:04:34.575`

```sql
SELECT datetime('subsec');
```


##  julianday() - ''

The fractional number of days since noon in Greenwich on 
November 24, 4714 B.C. (Proleptic Gregorian calendar).
 
Example: `2460454.24282019`

```sql
SELECT julianday();
```

## unixepoch() - ''

Example: `1716487511`

```sql
SELECT unixepoch();
```

Example: `1716487554.112`

```sql
SELECT unixepoch('subsec');
```

Alias:

```sql
SELECT strftime('%s', 'now' )||substring( strftime('%f', 'now' ), 3);
```


## strftime() 


## timediff() - '+/-YYYY-MM-DD hh:mm:ss.sss'

Returns a string that describes the amount of time that must be added to B 
in order to reach time A. The format of the timediff() result is designed to be human-readable. 

The format is: (+|-)YYYY-MM-DD HH:MM:SS.SSS 


### From now to the end of the month:

1. now
2. Start of this month
3. Plus one month
4. Minus one day

Example: `+0000-00-07 05:45:09.000`

```sql
SELECT timediff( datetime('now','start of month','+1 month','-1 day'), datetime( ) );
```





## SQLite date

- 2024-05-23 19:28:07

```sql
SELECT datetime('now','localtime');
```

## ISO 8601

- 2024-05-23T12:06:36+00:00

```sql
SELECT strftime('%Y-%m-%dT%H:%M:%S+00:00', 'now');
```

## Modifiers


The available modifiers are as follows.

1. NNN days		[^1]
2. NNN hours	[^1]
3. NNN minutes	[^1]
4. NNN seconds	[^1]
5. NNN months	[^1]
6. NNN years	[^1]
7. ±HH:MM [^1] [^2]
8. ±HH:MM:SS	[^1]	[^2]
9. ±HH:MM:SS.SSS	[^1]	[^2]
10. ±YYYY-MM-DD	[^1]	[^2]
11. ±YYYY-MM-DD HH:MM	[^1]	[^2]
12. ±YYYY-MM-DD HH:MM:SS	[^1]	[^2]
13. ±YYYY-MM-DD HH:MM:SS.SSS	[^1]	[^2]
14. ceiling
15. floor
16. start of month	[^3]
17. start of year	[^3]
18. start of day	[^3]
19. weekday N		[^4]
20. unixepoch		[^5]
21. julianday
22. auto			[^7]
23. localtime		[^8]
24. utc
25. subsec			[^9]
26. subsecond		[^9]


[^1]: Add the specified amount of time to the date and time specified by the arguments to its left. The 's' character at the end of the modifier names in 1 through 6 is optional. The NNN value can be any floating point number, with an optional '+' or '-' prefix. 

[^2]: The time shift modifiers (7 through 13) move the time-value by the number of years, months, days, hours, minutes, and/or seconds specified. An initial "+" or "-" is required for formats 10 through 13 but is optional for formats 7, 8, and 9. The changes are applies from left to right. First the year is shifted by YYYY, then the month by MM, and then day by DD, and so forth. The timediff(A,B) function returns a time shift in format 13 that shifts the time-value B into A.

[^3]: The "start of" modifiers (16 through 18) shift the date backwards to the beginning of the subject month, year or day.

[^4]: The "weekday" modifier advances the date forward, if necessary, to the next date where the weekday number is N. Sunday is 0, Monday is 1, and so forth. If the date is already on the desired weekday, the "weekday" modifier leaves the date unchanged.

[^5]: The "unixepoch" modifier (20) only works if it immediately follows a time-value in the DDDDDDDDDD format. This modifier causes the DDDDDDDDDD to be interpreted not as a Julian day number as it normally would be, but as Unix Time - the number of seconds since 1970. If the "unixepoch" modifier does not follow a time-value of the form DDDDDDDDDD which expresses the number of seconds since 1970 or if other modifiers separate the "unixepoch" modifier from prior DDDDDDDDDD then the behavior is undefined.

[^6]: The "julianday" modifier must immediately follow the initial time-value which must be of the form DDDDDDDDD. Any other use of the 'julianday' modifier is an error and causes the function to return NULL. The 'julianday' modifier forces the time-value number to be interpreted as a julian-day number. As this is the default behavior, the 'julianday' modifier is scarcely more than a no-op. The only difference is that adding 'julianday' forces the DDDDDDDDD time-value format, and causes a NULL to be returned if any other time-value format is used.

[^7]: The "auto" modifier must immediately follow the initial time-value. If the time-value is numeric (the DDDDDDDDDD format) then the 'auto' modifier causes the time-value to interpreted as either a julian day number or a unix timestamp, depending on its magnitude. If the value is between 0.0 and 5373484.499999, then it is interpreted as a julian day number (corresponding to dates between -4713-11-24 12:00:00 and 9999-12-31 23:59:59, inclusive). For numeric values outside of the range of valid julian day numbers, but within the range of -210866760000 to 253402300799, the 'auto' modifier causes the value to be interpreted as a unix timestamp. Other numeric values are out of range and cause a NULL return. The 'auto' modifier is a no-op for ISO 8601 text time-values. The "auto" modifier is designed to work with time-values even in cases where it is not known which time-value format is stored in the database file, or in cases where the same column stores time-values in different formats on different rows. The 'auto' modifier will automatically select the appropriate format. However, there is some ambiguity. Unix timestamps for the first 63 days of 1970 will be interpreted as julian day numbers. The 'auto' modifier is very useful when the dataset is guaranteed to contain no dates within that range, but should be avoided for applications that might make use of dates in the opening months of 1970.

[^8]: The "localtime" modifier assumes the time-value to its left is in Universal Coordinated Time (UTC) and adjusts that time value so that it is in localtime. If "localtime" follows a time that is not UTC, then the behavior is undefined. The "utc" modifier is the opposite of "localtime". "utc" assumes that the time-value to its left is in the local timezone and adjusts that time-value to be in UTC. If the time to the left is not in localtime, then the result of "utc" is undefined.

[^9]: The "subsecond" modifier (which may be abbreviated as just "subsec") increases the resolution of the output for datetime(), time(), and unixepoch(), and for the "%s" format string in strftime(). The "subsecond" modifier has no effect on other date/time functions. The current implemention increases the resolution from seconds to milliseconds, but this might increase to a higher resolution in future releases of SQLite. When "subsec" is used with datetime() or time(), the seconds field at the end is followed by a decimal point and one or more digits to show fractional seconds. When "subsec" is used with unixepoch(), the result is a floating point value which is the number of seconds and fractional seconds since 1970-01-01. The "subsecond" and "subsec" modifiers have the special property that they can occur as the first argument to date/time functions (or as the first argument after the format string for strftime()). When this happens, the time-value that is normally in the first argument is understood to be "now". For example, a short cut to get the current time in seconds since 1970 with millisecond precision is to say:
```sql
SELECT unixepoch('subsec');
```


### TIMESTAMP vs. ISO8601 dates

SQLite has an internal timestamp with the syntax `YYYY-MM-DD hh:mm:ss`. This is NOT a valid timestamp as defined in ISO8601 where the syntax is `YYYY-MM-DD`**T**`hh:mm:ssZ` - with the letter `T` as delimiter (between date an time) and a timezone  (Zulu for UTC).

```sql
DROP TABLE IF EXISTS temp_times;
CREATE TEMPORARY TABLE temp_times (
  sqlite    TIMESTAMP  DEFAULT CURRENT_TIMESTAMP,
  iso8601   TEXT       DEFAULT (strftime('%Y-%m-%dT%H:%M:%SZ')),
  sometext  TEXT
 );
```

Testing this using:

```sql
REPLACE INTO temp_times(sometext) values("hello world");
SELECT * FROM temp_times;
```
Should produce:
```console
2022-04-27 18:49:07|2022-04-27T18:49:07Z|hello world
```
Please note that both timestamps are in UTC timezone (Local time is 20:52)

If you have a CURRENT_TIMESTAMP in a table, this could be translated using:
```sql
SELECT replace( CURRENT_TIMESTAMP, ' ', 'T');
```
But more correct would be:

```sql
SELECT strftime('%Y-%m-%dT%H:%M:%S.%fZ', sqlite) FROM temp_times;
```
Note that "fraction of a second" will always be "000", since the timestamp in SQLite does not contant fractions.

