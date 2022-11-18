# Exiftool

Image processing

1. Copy images from camera to archive
1. Rename to date convention (YYYY-mm-ddThh-mm-ss_filename-copy.ext)
1. Add copyright information


## Install

```console
sudo apt install libimage-exiftool-perl
```

```console
export SOURCE=/media/mint/K-1/DCIM/105_0419
export TARGET=/tmp/DCIM/%Y/%Y-%m-%d
export FILENAME_TEMPLATE=%Y-%m-%dT%H-%M-%S_%%f%%-c.%%le
export IMG=2020-04-19T17-49-39_IMGP5520.jpg
```

## Copy images to archive
```console
#export TITLE="Copy ${SOURCE} to ${TARGET}"
exiftool -progress:${TITLE} -v \
    -o . '-Directory<CreateDate' -d ${TARGET} -r ${SOURCE}
```


## Rename images to date format

```console
exiftool -progress:${TITLE} -v \
    '-filename<CreateDate' -d ${FILENAME_TEMPLATE} -r -ext jpg -ext dng ${TARGET}
```

Option | Description
---|---
`-filename<CreateDate` | rename the image file using the image's creation date and time.
`-d` |Set format for date/time values
`-ext jpg -ext dng`| only rename files with the "jpg" or "dngw" extension.
`-r`|recursively

### FILENAME_TEMPLATE

`%Y-%m-%dT%H-%M-%S_%%f%%-c.%%le` (YYYY-MM-DDThh-mm-ss_filename-copy.ext)


## Extraction meta data

### To JSON

Read all IPTC data from image
```console
exiftool -json -IPTC:all ${IMG}
```

## Adding meta data

### Specific data
```console
exiftool -tagsfromfile "/media/mint/K-1/DCIM/default.json" "-caption-abstract<Description" "-keywords<tags" 2020-04-19T17-49-39_IMGP5520.jpg
```

### From JSON

```console
# Write all data from in.json to image
exiftool -tagsfromfile in.json  ${IMG}
```
