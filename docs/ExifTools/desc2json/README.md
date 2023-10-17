# Load descriptions into images

Images in current dir and descriptions in subdir `desc` as .TXT files.
```
└───images
    └───desc
```

For short run:

```
Desc2Json.cmd 
%exiftool% -json="desc.default.utf-8.json" *.tif
```



## export to JSON file

Example:
```console
exiftool -json "c:\Users\Phil\Images" > "c:\Users\Phil\test.json"
```

Export:
```
%exiftool%  -json *.tif > exif.json
```

## Compile desccriptions

```console
Desc2Json.cmd >desc.json
```


### Convert charset

```
powershell.exe -noprofile -command "Get-Content desc.json -Encoding Oem | Out-File desc.utf-8.json -Encoding utf8"
```

Or more specific from CMD:
```
powershell.exe -noprofile -command "Get-Content desc.json -Encoding Default | Out-File desc.utf-8.json -Encoding utf8"
```



- https://superuser.com/a/1201481 -- Convert a text file from ansi to UTF-8 in windows batch scripting
- https://learn.microsoft.com/en-us/dotnet/api/microsoft.powershell.commands.filesystemcmdletproviderencoding?redirectedfrom=MSDN&view=powershellsdk-1.1.0 -- FileSystemCmdletProviderEncoding Enum
- https://stackoverflow.com/a/10402108 -- One-liner PowerShell script



## import from JSON file

Example:
```
exiftool -json="c:\Users\Phil\test.json" "c:\Users\Phil\Images"
```

Single file: 
```
%exiftool% -json="exif.json" kbp1970-20232.tif
```

Loading export:
```
%exiftool% -json="exif.json" *.tif
```

Load compiled desccriptions
```
%exiftool% -json="desc.json" *.tif
```

## Extra descriptions

This can be included in `global.json`:

```json
  "CountryCode": "DNK",
  "Location": "Location",
  "Country": "Country",
  "State": "State",
  "City": "City",
  "Sub-location": "Location",
  "Province-State": "State",
  "Country-PrimaryLocationCode": "DNK",
  "Country-PrimaryLocationName": "Country",

  "Creator": "Byline",
  "By-line": "Byline",	
  "AuthorsPosition": "Bylinetitle",
  "By-lineTitle": "Bylinetitle",

  "Credit": "Credits_byline",

  "Rights": "CopyXn",
  "CopyrightNotice": "CopyXn",

  "Subject": ["xnKey1","xnKey2"],
  "HierarchicalSubject": ["xnKey1","xnKey2"],
  "Keywords": ["xnKey1","xnKey2"],
  "SupplementalCategories": "Erik Bachmann Pedersen (00001)",

  "Headline": "Headline text",
  "Description": "Caption text",
  "Caption-Abstract": "Caption text",


  "Source": "Source",
```
