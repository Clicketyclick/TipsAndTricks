## Handle images

### Raw images
Raw image files can be read and stored directly as blobs.

```sql
-- https://sqlite.org/forum/forumpost/92f93aa9dd0d9ada
-- https://sqlite.org/forum/forumpost/92f93aa9dd0d9ada - Larry Brasfield (larrybr) on 2021-03-12 23:03:59
DROP TABLE IF EXISTS images;
CREATE TABLE images(id TEXT primary key, image blob);
.print 'Loading icon and logo'
REPLACE INTO images (id, image) values ('icon', readfile('icon.png'));
REPLACE INTO images (id, image) values ('logo', readfile('logo.png'));
SELECT * FROM images;
SELECT "Changes: "||changes();
SELECT id FROM images;
```

```sql
-- Dump images
select (writefile('icon_copy.png', image)) from images where id='icon';
select (writefile('logo_copy.png', image)) from images where id='logo';
```

### Base64 encoded images

This requires encoding via an external programming language like PHP - or loading a module
```
<?php
$filename   = "icon.png";
$filename   = $argv[1] ?? "icon.png";

$data_type  = image_type_to_mime_type( exif_imagetype( $filename ) );
$dataToSave = file2base64( $filename );

// https://stackoverflow.com/a/8499716 How to display Base64 images in HTML
file_put_contents( "output.html", sprintf("
<div>
    <img src='data:%s;base64, %s' alt='%s' title='%s: %s' />
</div>
"
,   $data_type
,   $dataToSave
,   $filename
,   $filename
,   $filename
));
print "done\n";

/**
 *  @fn        file2base64
 *  @brief     Brief description
 *  
 *  @param [in] $filename 	Description for $filename
 *  @return    Return description
 *  
 *  @details   More details
 *  
 *  @example   
 *  
 *  @todo      
 *  @bug       
 *  @warning   
 *  
 *  @see       https://stackoverflow.com/a/9097729 Put an image into a SQLite database
 *  @since     2023-03-03T14:17:02 / erba
 */
function file2base64( $filename )
{
    return base64_encode(file_get_contents( $filename ));
}   // file2base64()

function base642file( $filename, $blob )
{
    return file_put_contents( $filename, base64_decode( $blob ) );
}   // base642file()

?>
```



References:
- [Compile and load](https://www.sqlite.org/loadext.html)
- [Miscellaneous Extensions](https://www.sqlite.org/src/file/ext/misc)
  - [Base64.c](https://www.sqlite.org/src/file?name=ext/misc/base64.c&ci=tip)
