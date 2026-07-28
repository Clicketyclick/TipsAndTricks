<img src="../icons/Firefox.logo.png"  width=64 style="float: right;">

## Firefox

### Changing PDF Zoom Settings

1. Type `about:config` in the Firefox address bar and press <kbd>Enter</kbd>.
2. Accept the warning risk message.
3. Search for `pdfjs.defaultZoomValue` and change it from `auto` to `page-width` or `page-fit`.
4. Search for `pdfjs.ignoreDestinationZoom` and toggle it to true if you want Firefox to ignore annoying internal zoom commands embedded inside specific PDF files.
