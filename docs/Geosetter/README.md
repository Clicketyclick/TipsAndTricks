


https://www.pentaxforums.com/forums/32-digital-processing-software-printing/471356-geosetter-v4-0-49-issue-exiftool-workaround.html
  Recent versions of exiftool have changed their directory structures and as a consequence Geosetter after any automated update of exiftool now breaks:
  0002547: Exiftool 12.88 and 12.89 brings error "could not find .... exiGeoSetter_beta\tools\ftool_files\perl5*.dll" - GeoSetter - MantisBT

https://www.geosetter.de/mantis/view.php?id=2548
  0002548: Exiftool.org changed packaging for Exiftool, update not working anymore
  Beskrivelse	According to https://exiftool.org/install.html#Windows the install procedure for exiftool was changed.
  Since 12.88 update does not work anymore
  Exiftool.exe complains tah the perl libraries were not found.
  The details section of geosetter says

  NOTE: The https://exiftool.org/install.html#Windows has changed!
  Windows EXE version now uses Oliver Betz's bundle with Strawberry Perl and comes in 32- and 64-bit versions

  Geosetter gets a wrong version and populates the tools folder with lots of perl files. exiftool.exe is there, but does not work.
  However if you download the windows zip file 32 bit or 64 bit, clear the tools folder and export the contents of the zip to the tools folder and rename exiftool-(k).exe to exiftool.exe, everything works again

1. Download latest ExifTool version.
2. Unpack to `""%USERPROFILE%\AppData\Roaming\GeoSetter_beta\tools"`.
3. Rename `exiftool(-k).exe` to `exiftool.exe`.

