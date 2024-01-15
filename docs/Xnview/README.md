
# XnView

## Settings

### Background

- Settings / View 
	- Background: black

- Settings / View / Fullscreen
	- Background: black
	
	
	Custom 1: {EXIF:Focal Length}mm f/{EXIF:F-Number} {EXIF:Exposure Time}s {EXIF:ISO Value}iso

### Meta data 

- Settings / Thumbnail / Labels

```console
Filename (with extension)
Custom 2: {Width}x{Height} - {Size KB}
File created date
EXIF: Date Modified
Custom 1: {EXIF:Focal Length}mm f/{EXIF:F-Number} {EXIF:Exposure Time}s {EXIF:ISO Value}iso
IPTC: Headline
IPTC: Caption
```
- Settings / Browser / Tooltip

```console
<b>{Filename}</b><br>{Modified Date}<br>{EXIF:Date taken}<br>{Size KB} KiB
{IPTC:Headline} {IPTC:Caption}
{IPTC:Sublocation} {IPTC:City} {IPTC:State} {IPTC:Country Code} 
<img src="C:\dev\flags\iso\png\xnview\iso3\{IPTC:Country Code}.png"><img src="https://clicketyclick.github.io/country.io/flags/iso3/{IPTC:Country Code}.png">
```

- Settings / Metadata / Encode

Use ***ONLY*** UTF-8 !!!!

- Settings / View / StatusBar

Select all

- Settings / View / Info

```console
{File Index} - {Filename}
{Format} - {Size KB} KiB - {Width}x{Height}
({EXIF:Date Taken}) ({EXIF:Make}) ({EXIF:Model}) ({Zoom}%)
({Tag status}) ({Rating}) ({Color label}) 
{IPTC:Headline} {IPTC:Caption}
{IPTC:Sublocation} {IPTC:City} {IPTC:State} {IPTC:Country Code} 
<img src="C:\dev\flags\iso\png\xnview\iso3\{IPTC:Country Code}.png">
```

<fieldset>
  <legend>Flags</legend>
Imbedded in this configuration are flags mapped to {IPTC:Country Code}. In this examples the flags are located in `C:\dev\flags\iso\png\xnview\iso3\`.

You may place them elsewhere.

Flags can be downloaded from [https://github.com/Clicketyclick/country.io/tree/master/flags](https://github.com/Clicketyclick/country.io/tree/master/flags)
</fieldset>
