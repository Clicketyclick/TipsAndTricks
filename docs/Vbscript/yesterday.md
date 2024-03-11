## Get yesterdays date


```vbscript
' yesterday.vbs
' https://stackoverflow.com/a/31870104/7485823
d = date() - 1
wscript.echo year(d) * 10000 + month(d) * 100 + day(d)
'FOR /F %%a IN ('cscript //nologo yesterday.vbs') DO SET _date=%%a&ECHO _date[%_date%]
```
