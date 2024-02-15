<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <title>sub</title>
    <link rel="icon" href="data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACwAAAAAAQABAAACAkQBADs=">
</head>

<body onLoad="setData();">
<h4>
2024-02-15 11:37:26 <?php echo __FILE__; ?>
</h4>

<div id="data"></div>

<?php
if (ob_get_level() == 0) ob_start();    // 

print( "<script>parent.document.getElementById('status').innerHTML = 'calling parent';</script>");

@ini_set('zlib.output_compression',0);
@ini_set('implicit_flush',1);
@ob_end_clean();

//set_time_limit(0);
//ob_implicit_flush(1);
@set_time_limit(0);
///ob_implicit_flush(1);
$timer   = 15000;
for ( $i = 0 ; $i <= 100 ; $i++ ) 
{
    printf( "<script>parent.document.getElementById('data').innerHTML = '%s msec';</script>", $i * $timer );
    print( "<script>parent.document.getElementById('progress').value = $i;</script>");
    echo str_repeat(' ',1024*64);
        //ob_flush();
        //flush();
    usleep($timer);
}

?>
</body>
</html>