# Clean up MS apps in Windows 10
#	URL: http://www.howtogeek.com/224798/
#	Title: How to Uninstall Windows 10’s Built-in Apps (and How to Reinstall Them)
#	Autor: Chris Hoffman

ECHO "List all Apps"
Get-AppxPackage | Select Name, PackageFullName > ListWindowsApps.txt
more < ListWindowsApps.txt

ECHO "Uninstalling.."

ECHO "Uninstall   3D Builder:"
Get-AppxPackage *3dbuilder* | Remove-AppxPackage

ECHO "Uninstall  Alarms and Clock:"
Get-AppxPackage *windowsalarms* | Remove-AppxPackage

ECHO "Uninstall  Calculator:"
Get-AppxPackage *windowscalculator* | Remove-AppxPackage

ECHO "Uninstall  Calendar and Mail:"
Get-AppxPackage *windowscommunicationsapps* | Remove-AppxPackage

ECHO "Uninstall  Camera:"
Get-AppxPackage *windowscamera* | Remove-AppxPackage

ECHO "Uninstall  Contact Support:"
ECHO "Note! This app can’t be removed."

ECHO "Uninstall  Cortana:"
ECHO "Note! This app can’t be removed."

ECHO "Uninstall  Get Office:"
Get-AppxPackage *officehub* | Remove-AppxPackage

ECHO "Uninstall  Get Skype:"
Get-AppxPackage *skypeapp* | Remove-AppxPackage

ECHO "Uninstall  Get Started:"
Get-AppxPackage *getstarted* | Remove-AppxPackage

ECHO "Uninstall  Groove Music:"
Get-AppxPackage *zunemusic* | Remove-AppxPackage

ECHO "Uninstall  Maps:"
Get-AppxPackage *windowsmaps* | Remove-AppxPackage

ECHO "Uninstall  Microsoft Edge:"
ECHO "Note! This app can’t be removed."

ECHO "Uninstall  Microsoft Solitaire Collection:"
Get-AppxPackage *solitairecollection* | Remove-AppxPackage

ECHO "Uninstall  Money:"
Get-AppxPackage *bingfinance* | Remove-AppxPackage

ECHO "Uninstall  Movies & TV:"
Get-AppxPackage *zunevideo* | Remove-AppxPackage

ECHO "Uninstall  News:"
Get-AppxPackage *bingnews* | Remove-AppxPackage

ECHO "Uninstall  OneNote:"
#Get-AppxPackage *onenote* | Remove-AppxPackage

ECHO "Uninstall  People:"
Get-AppxPackage *people* | Remove-AppxPackage

ECHO "Uninstall  Phone Companion:"
Get-AppxPackage *windowsphone* | Remove-AppxPackage

ECHO "Uninstall  Photos:"
Get-AppxPackage *photos* | Remove-AppxPackage

ECHO "Uninstall  Store:"
Get-AppxPackage *windowsstore* | Remove-AppxPackage

ECHO "Uninstall  Sports:"
Get-AppxPackage *bingsports* | Remove-AppxPackage

ECHO "Uninstall  Voice Recorder:"
#Get-AppxPackage *soundrecorder* | Remove-AppxPackage

ECHO "Uninstall  Weather:"
Get-AppxPackage *bingweather* | Remove-AppxPackage

ECHO "Uninstall  Windows Feedback:"
ECHO "Note! This app can’t be removed."

ECHO "Uninstall  Xbox:"
Get-AppxPackage *xboxapp* | Remove-AppxPackage

#----------------------------------------------------------------------
#2016-01-18/ebp

ECHO "Uninstall Naver Line"
Get-AppxPackage *naver.line* | Remove-AppxPackage

ECHO "Uninstall ZinioLLC.Zinio"
Get-AppxPackage *ZinioLLC.Zinio* | Remove-AppxPackage


#**********************************************************************
	
# How to Reinstall All Built-in Apps

# Get-AppxPackage -AllUsers| Foreach {Add-AppxPackage -DisableDevelopmentMode -Register “$($_.InstallLocation)\AppXManifest.xml”}

# This tells Windows to install those default apps again. Give it some time 
# and allow it to finish, even if nothing appears to happen at first. Even 
# if you see an error message, restart and examine your Start menu — you 
# may just have all those default apps back again, anyway. 

#*** End of File ***
