## Phone numbers

### Syntax

> The ITU-T E.164 standard defines a general format for international telephone numbers. 
Plan-conforming telephone numbers are limited to only digits and to a maximum of fifteen digits.
The specification divides the digit string into a country code of one to three digits, and the subscriber telephone number of a maximum of twelve digits. 

Source: [Wikipedia](https://en.wikipedia.org/wiki/E.164)

Suggestion for regex:

`^(\+?[1-9])[0-9]{5,13}$`

i.e. (group: '+' optional + digits 1–9 as country code)(5–13 digits)
