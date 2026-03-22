## Attributes to keep new line and protect binary files

Add this to `.gitattributes`:

```
# Auto detect text files and perform LF normalization
#* text=auto
#This diff contains a change in line endings from 'LF' to 'CRLF'
* text eol=lf
# 
*.tif binary
*.tiff binary
*.png binary
*.jpg binary
*.jpeg binary
*.db binary
*.sqlite binary
```
