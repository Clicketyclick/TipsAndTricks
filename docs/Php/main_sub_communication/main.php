<!DOCTYPE html>
<html lang="en">
  <head>
    <title>main - sub communication</title>
    <link rel="icon" href="data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACwAAAAAAQABAAACAkQBADs=">
<style>
iframe {
    /*display: block;       /* iframes are inline by default */
    /*background: #000;*/
    /*border: none;         /* Reset default border */
    /*height: 100vh;        /* Viewport-relative units */
    height: 40vh;
    width: 100vw;
    width: 90vw;
}
</style>
</head>
<body>
<h2>
2024-02-15 11:36:55<?php echo __FILE__; ?>
</h2>
<label for="progress">Progress:</label>
<progress id="progress" value="0" max="100"> 32 </progress>
Data:[<span id="data">Data</span>]<br>
Status:[<span id="status">Status</span>]<br>

<iframe 
    id='iframe' 
    src="sub.php" 
></iframe>
