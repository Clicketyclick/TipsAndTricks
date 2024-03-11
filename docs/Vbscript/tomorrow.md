## Get tomorrows date - or next from timestamp

```vbscript
'
'/**
' *  @file      tomorrow.vbs
' *  @brief     Get the date AFTER the given OR tomorrow
' *  
' *  @details   Given date (OR today) + 1
' *  
' *  @example   cscript //nologo tomorrow.vbs 2023-12-31
' *  
' *  @copyright http://www.gnu.org/licenses/lgpl.txt LGPL version 3
' *  @author    Erik Bachmann <ErikBachmann@ClicketyClick.dk>
' *  @since     2024-03-11T15:36:56 / erba
' *  @version   2024-03-11T15:36:56
' */


' Now
t  = date()
' Today YYYY-MM-DD
id = Year(t)            & "-"   & _
    Right("0" & Month(t),2) & "-"   & _
    Right("0" & Day(t),2)   

If 1 = WScript.Arguments.count Then
    wscript.echo WScript.Arguments.Item(0)
    id = WScript.Arguments.Item(0)
End if
wscript.echo id
' Tomorrow
d=CDate( id ) + 1

'wscript.echo(FormatDateTime(d) & "")
'wscript.echo(FormatDateTime(d,1) & " 1")
'wscript.echo(FormatDateTime(d,2) & " 2")
'wscript.echo(FormatDateTime(d,3) & " 3")
'wscript.echo(FormatDateTime(d,4) & " 4")

wscript.echo timeStamp( d )
' yesterday.vbs
' https://stackoverflow.com/a/31870104/7485823
'd = date() - 1
'wscript.echo year(d) * 10000 + month(d) * 100 + day(d)
'FOR /F %%a IN ('cscript //nologo yesterday.vbs') DO SET _date=%%a&ECHO _date[%_date%]3



'/**
' *  @fn        myFunction
' *  @brief     $(Brief description)
' *  
' *  @param [in] $abc  $(Description for $abc)
' *  @param [in] $defg $(Description for $defg)
' *  @return    $(Return description)
' *  
' *  @details   $(More details)
' *  
' *  @example   
' *  
' *  @todo      
' *  @bug       
' *  @warning   
' *  
' *  @see       https://
' *  @since     2024-03-11T15:37:37 / erba
' */
Function timeStamp( d)
    Dim t 
    't = Now
    t = d
    
    timeStamp = Year(t)     & _
    Right("0" & Month(t),2) & _
    Right("0" & Day(t),2)   
    
    
    'timeStamp = Year(t) & "-" & _
    'Right("0" & Month(t),2)  & "-" & _
    'Right("0" & Day(t),2)  & "_" & _  
    'Right("0" & Hour(t),2) & _
    'Right("0" & Minute(t),2) '    '& _    Right("0" & Second(t),2) 
End Function

```
