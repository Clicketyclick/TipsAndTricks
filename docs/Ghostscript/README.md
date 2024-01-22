

### Split a PDF into individual pages

```batch
:: Using GhostView to split a PDF into individual pages
::https://superuser.com/a/168474

:: Path to GhostView
SET GS="C:/Program Files/gs/gs10.02.1/bin/gswin64.exe"

:: Prefix of each page
SET _PREFIX=rakker
%gs% ^
    -dBATCH ^
    -dNOPAUSE ^
    -dSAFER ^
    -sDEVICE=jpeg ^
    -dJPEGQ=95 ^
    -r600x600 ^
    -dPDFFitPage ^
    -dAutoRotatePages=/PageByPage ^
    -dFIXEDMEDIA ^
    -sDEFAULTPAPERSIZE=a4 ^
    -sOutputFile=%_PREFIX%-%04d.jpg ^
    original.pdf
```
