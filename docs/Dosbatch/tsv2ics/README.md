# tsv2ics.cmd

Convert a tab separated calendar to a valid ICS calendar file w. local timezone for Copenhagen.


## Example

```
tsv2ics.cmd input.txt > test.ics
* file      isodate.cmd
* brief     Convert tab separated list to ics calendar
* version   2024-06-17 17:40:41
loop
[20240617] [100000] [103000] [+2] [Arrival] [What to do\nAnd how] [Location1]
[20240617] [113000] [129000] [+2] [Lunch] [Open lunchbox\nAnd eat] [Cafeteria]
```

### Input
input.txt



Date|start|end|Summary|Description|Location
---|---|---|---|---|---|
2024-06-17	|10.00	|10.30	|Arrival	|What to do\nAnd how	|Location1
2024-06-17	|11:30	|12:90	|Lunch	|Open lunchbox\nAnd eat	|Cafeteria
2024-06-17	|1630	|1700	|Closing time	|Go home	|@home

```csv
2024-06-17	10.00	10.30	Arrival	What to do\nAnd how	Location1
2024-06-17	11:30	12:90	Lunch	Open lunchbox\nAnd eat	Cafeteria
2024-06-17	1630	1700	Closing time	Go home	@home
```

### Output


test.ics

```ics
BEGIN:VCALENDAR
VERSION:2.0
PRODID:-//isodate.cmd v2024-06-17 17:40:41//Erik Bachmann ErikBachmann@ClicketyClick.dk//EN
CALSCALE:GREGORIAN
METHOD:PUBLISH
BEGIN:VTIMEZONE
TZID:Europe/Copenhagen
X-LIC-LOCATION:Europe/Copenhagen
BEGIN:DAYLIGHT
TZOFFSETFROM:+0100
TZOFFSETTO:+0200
TZNAME:CEST
DTSTART:19700329T020000
RRULE:FREQ=YEARLY;BYDAY=-1SU;BYMONTH=3
END:DAYLIGHT
BEGIN:STANDARD
TZOFFSETFROM:+0200
TZOFFSETTO:+0100
TZNAME:CET
DTSTART:19701025T030000
RRULE:FREQ=YEARLY;BYDAY=-1SU;BYMONTH=10
END:STANDARD
END:VTIMEZONE

BEGIN:VEVENT
DTSTAMP:20240617T100000
DTSTART:20240617T100000
DTEND:20240617T103000
SUMMARY:Arrival
DESCRIPTION:What to do\nAnd how
LOCATION:Location1
CLASS:PUBLIC
SEQUENCE:0
CREATED:20240617T154446Z
LAST-MODIFIED:20240617T154446Z
STATUS:CONFIRMED
TRANSP:OPAQUE
END:VEVENT

BEGIN:VEVENT
DTSTAMP:20240617T113000
DTSTART:20240617T113000
DTEND:20240617T129000
SUMMARY:Lunch
DESCRIPTION:Open lunchbox\nAnd eat
LOCATION:Cafeteria
CLASS:PUBLIC
SEQUENCE:0
CREATED:20240617T154446Z
LAST-MODIFIED:20240617T154446Z
STATUS:CONFIRMED
TRANSP:OPAQUE
END:VEVENT

END:VCALENDAR
```
