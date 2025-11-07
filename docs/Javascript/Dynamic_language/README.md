
## Dynamic language in browser

Sometimes I need to use language specific texts on a webpage. Default is the browsers language

```js
// Detect browser language
let language = navigator.language;
```

But it is convenient to be able to enforce at specific language using an argument

In the HTML code the `lang='..'` is useful:

```html
<span lang='en'>Hello</span><span lang='fr'>Bon Jour</span>
```

All entries with `lang` attribute should be hidden by default
```css
/* Matches every element that has a lang attribute, no matter the value */
[lang] { display: none; }
```
- and only the browser language OR designated `lang=` displayed

The two scripts `parseLanguage()` and `switchLanguageOn()` must be run "onLoad" or by request:
```html
 <body onload='parseLanguage( true );switchLanguageOn( language, true );'>
```

All scripts and styles are included in the header:

```html
    <header>
        <link rel="stylesheet" href="dynamic_language.css">
        <script src='dynamic_language.js'></script>
    </header>
```

So you need:

`dynamic_language.html`  | Example script
`dynamic_language.css`    | Styling
`dynamic_language.js`    | The javascripts


### Examples

Arguments | Result
---|---
dynamic_language.html                 | Default (=en)
dynamic_language.html?lang=en         | Default (=en)
dynamic_language.html?lang=da         | Danish
dynamic_language.html?lang=sp,fr      | Spanish and French
dynamic_language.html?lang=xx         | Undefined/Failing! (xx is ignored) 
dynamic_language.html?lang=xx,hi,da   | Hindi and Danish (xx is ignored) 

