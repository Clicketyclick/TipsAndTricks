## Frame grabber

Get contents from iframe and copy to other element like a DIV

All you need is to include the JavaScript library [frame_grabber.js](frame_grabber.js)
```html
<script src="frame_grabber.js"></script>
```
And copy *after* loading the page:
```html
<body onload='copyFrame("myFrame", "myDiv");'>
```

### Example [frame_grabber.html](frame_grabber.html)

Copy content from dummy.html to `myDiv`:

```html
<html>
<head>
    <meta charset="utf-8" />
    <title>frame_grabber</title>
    <script src="frame_grabber.js"></script>
   
</head>
<body onload='copyFrame("myFrame", "myDiv");'>
    <h1>frame_grabber</h1>

    This is the dir to update:
    <div id='myDiv' style='border:1px solid black;'>Placeholder text</div>

    This is the source iframe:<br>
    <iframe id='myFrame' src="dummy.html"></iframe>
</body>
</html>
```
