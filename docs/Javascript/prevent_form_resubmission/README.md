
Reloading a page with <kbd>F5</kbd> in browers can give some nasty sideeffict - if say last action was deleting...
This little gem in JavaScript prevents that:

[@@Stackoverflow_icon@@ How to prevent form resubmission when page is refreshed (F5 / CTRL+R)](https://stackoverflow.com/a/45656609)
<!--![Stackoverflow](icons/Stackoverflow.icon.png)-->
```javascript
<script>
  //[How to prevent form resubmission when page is refreshed (F5 / CTRL+R)](https://stackoverflow.com/a/45656609)
  if ( window.history.replaceState ) {
    window.history.replaceState( null, null, window.location.href );
  }
</script>
```
