# Ansi codes in CMD

Windows 10+ supports ANSI code for colouring out put as a default.

However it is pretty grim to encode.

```batch
ECHO [^[[92;40mBold green on black^[[0m]>CON:
```
Which shold be:
1. Print "["
2. Turn on GREEN on BLACK background
3. Print "Bold green on black"
4. Turn colour off
5. Print "]"

And of cause you will have to remember the exact syntax, coding etc.

A better way is to encode the colours as numbers in `{{}}` and let a script do the encoding:

```
CALL ansi "[{{92;40}}Bold green on black{{0}}]"
```
This is much easier to remember!

BUT! This script sends coloured output directly to the console (CON:)! You cannot redirect output to file.

## ANSI Codes

## Font Effects

Code         |Effect         |Note
---|---|---
0       |Reset / Normal                 |all attributes off
1       |Bold or increased intensity    |
2       |Faint (decreased intensity)    |Not widely supported.
3       |Italic                         |Not widely supported. Sometimes treated as inverse.
4       |Underline                      |
5       |Slow Blink                     |less than 150 per minute
6       |Rapid Blink                    |MS-DOS ANSI.SYS; 150+ per minute; not widely supported
7       |[[reverse video]]              |swap foreground and background colours
8       |Conceal                        |Not widely supported.
9       |Crossed-out                    |Characters legible, but marked for deletion. Not widely supported.
10      |Primary(default) font          |
11–19   |Alternate font                 |Select alternate font n-10
20      |Fraktur                        |hardly ever supported
21      |Bold off or Double Underline   |Bold off not widely supported; double underline hardly ever supported.
22      |Normal colour or intensity     |Neither bold nor faint
23      |Not italic, not Fraktur        |
24      |Underline off                  |Not singly or doubly underlined
25      |Blink off                      |
27      |Inverse off                    |
28      |Reveal                         |conceal off
29      |Not crossed out                |
30–37   |Set foreground colour          |See colour table below
38      |Set foreground colour          |Next arguments are 5;<n> or 2;<r>;<g>;<b>, see below
39      |Default foreground colour      |implementation defined (according to standard)
40–47   |Set background colour          |See colour table below
48      |Set background colour          |Next arguments are 5;<n> or 2;<r>;<g>;<b>, see below
49      |Default background colour      |implementation defined (according to standard)
51      |Framed                         |
52      |Encircled                      |
53      |Overlined                      |
54      |Not framed or encircled        |
55      |Not overlined                  |
60      |ideogram underline             |hardly ever supported
61      |ideogram double underline      |hardly ever supported
62      |ideogram overline              |hardly ever supported
63      |ideogram double overline       |hardly ever supported
64      |ideogram stress marking        |hardly ever supported
65      |ideogram attributes off        |reset the effects of all of 60-64
90–97   |Set bright foreground colour   |aixterm (not in standard)
100–107 |Set bright background colour   |aixterm (not in standard)



