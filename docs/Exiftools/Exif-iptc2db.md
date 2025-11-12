# How can I extract all EXIF and ITPC data from an image using exiftool to a SQLite database?

Source: https://lumo.proton.me/u/8/c/43d11501-3aa1-4083-ad95-af1e67139a1d

Below is a practical, step‑by‑step recipe you can run on a typical Unix‑like system (Linux/macOS). It uses exiftool to read the metadata, formats the output as CSV, and then loads that CSV into a SQLite database with the standard sqlite3 CLI.

1️⃣ Install the required tools
```
# exiftool – reads EXIF, IPTC, XMP, etc.
# (most package managers already have it)
sudo apt-get install libimage-exiftool-perl   # Debian/Ubuntu
# or
brew install exiftool                         # macOS Homebrew

# sqlite3 – the command‑line client for SQLite
sudo apt-get install sqlite3                  # Debian/Ubuntu
# or
brew install sqlite3                          # macOS Homebrew
```
    
> Tip: If you already have the binaries in your $PATH, you can skip the installation step.

2️⃣ Decide on the schema

A simple schema that works for most use‑cases stores each tag as a separate row:
Column	|Type	Meaning
file	TEXT	Path (or name) of the image file
tag	TEXT	Name of the EXIF/IPTC/XMP tag (e.g., EXIF:Make)
value	TEXT	The tag’s value (stored as text for simplicity)

If you prefer a wide table (one column per tag), you can generate a custom CREATE statement after inspecting the CSV header, but the “long” format above avoids having to rebuild the table whenever new tags appear.

```
CREATE TABLE IF NOT EXISTS img_meta (
    file  TEXT NOT NULL,
    tag   TEXT NOT NULL,
    value TEXT
);
```

3️⃣ Export the metadata to CSV

Run exiftool with the -csv flag. The -charset UTF8 option ensures Unicode characters are preserved.

```
exiftool -charset UTF8 -csv -r -ext jpg -ext png /path/to/images > metadata.csv
```

Explanation of the flags:
Flag	Purpose
-charset UTF8	Guarantees proper encoding for non‑ASCII characters
-csv	Emits a CSV where the first column is the filename and subsequent columns are tags
-r	Recursively descend into sub‑folders (optional)
-ext jpg -ext png	Limit processing to image types you care about (add more extensions if needed)
/path/to/images	Root folder containing the pictures

The resulting CSV looks roughly like:

```
SourceFile,EXIF:Make,EXIF:Model,IPTC:Keywords,IPTC:Caption-Abstract,...
/path/to/images/img001.jpg,Canon,EOS 80D,"vacation; beach","Sunset over water",...
```

4️⃣ Load the CSV into SQLite

SQLite’s .import command expects a headerless CSV, so we’ll strip the header line first and then import.

# 4a. Create (or reset) the database and table

```
sqlite3 imgmeta.db <<'SQL'
DROP TABLE IF EXISTS img_meta;
CREATE TABLE img_meta (
    file  TEXT NOT NULL,
    tag   TEXT NOT NULL,
    value TEXT
);
```

SQL

```
# 4b. Transform the wide CSV into the long format expected by our table.
#     We’ll use awk (or any scripting language you prefer).
awk -F',' '
NR==1 {                     # Header line – remember column names
    for (i=2; i<=NF; i++) hdr[i]=$i
    next
}
{
    file=$1
    for (i=2; i<=NF; i++) {
        # Skip empty values to keep the DB tidy
        if ($i != "" && $i != "-") {
            gsub(/\r/,"",$i)               # Remove possible Windows CR
            print file "\t" hdr[i] "\t" $i
        }
    }
}
' metadata.csv > long_format.tsv
```

Why TSV?
Using a tab (\t) as the field separator avoids issues with commas that may appear inside tag values.

# 4c. Import the transformed data
```
sqlite3 imgmeta.db <<'SQL'
.mode tabs
.import long_format.tsv img_meta
```

SQL

At this point the SQLite file imgmeta.db contains one row per tag/value pair for every processed image.
5️⃣ Quick sanity check

```
sqlite3 imgmeta.db "SELECT COUNT(*) FROM img_meta;"
# → total number of extracted tag/value pairs

sqlite3 imgmeta.db "SELECT file, tag, value FROM img_meta WHERE tag='IPTC:Keywords' LIMIT 10;"
```

You can now query the database just like any other SQLite DB—join with other tables, filter by tag, aggregate counts, etc.
6️⃣ Optional enhancements
Goal	How to achieve it
Store original data types (numbers, dates)	Keep the CSV output as JSON (exiftool -j) and write a small Python script that parses each JSON object, inspects the value type, and inserts with appropriate SQLite column types.
Batch processing for many folders	Wrap the whole pipeline in a shell function or a Makefile target; the -r flag already handles recursion, but you can also loop over a list of root directories.
Avoid duplicate rows	Add a unique index: CREATE UNIQUE INDEX idx_img_tag ON img_meta(file, tag); then use INSERT OR REPLACE instead of plain .import.
Full‑width table (one column per tag)	After the first CSV export, inspect the header line, generate a CREATE TABLE statement with those column names, and use SQLite’s .mode csv .import directly (no transformation needed). This yields a more compact table at the cost of needing to rebuild the schema whenever new tags appear.
Automation via Python	The pyexiftool wrapper lets you call exiftool from Python, collect the dict output, and use sqlite3’s parameterised executemany() to insert rows. This is handy if you want to embed the process in a larger application.
7️⃣ One‑liner version (for quick ad‑hoc use)

If you just need a throw‑away dump and don’t mind a temporary table:

```
exiftool -charset UTF8 -csv -r /path/to/images \
| tail -n +2 \
| sqlite3 :memory: ".mode csv .import /dev/stdin img_meta"
```

(This creates an in‑memory SQLite DB; replace :memory: with a filename if you want persistence.)
TL;DR Summary

    Export: exiftool -charset UTF8 -csv -r /path/to/images > meta.csv
    Transform (wide → long): use awk (or Python) to produce a TSV where each line = file<TAB>tag<TAB>value.
    Create DB & Table: sqlite3 imgmeta.db → CREATE TABLE img_meta (file TEXT, tag TEXT, value TEXT);
    Import: .mode tabs then .import long_format.tsv img_meta
    Query: SELECT … FROM img_meta WHERE …;

That gives you a searchable SQLite database containing all EXIF, IPTC (and any other tags exiftool reports) for the images you feed it. Happy hacking!
