
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

All entries with `lang` attribute should be hidden by default (done in the stylesheet `dynamic_language.css`)

```css
/* Matches every element that has a lang attribute, no matter the value */
[lang] { display: none; }
```
- and only the browser language OR designated `lang=` displayed

The two scripts `parseLanguage()` and `switchLanguageOn()` must be run "onLoad":
```html
 <body onload='parseLanguage( true );switchLanguageOn( language, true );'>
```
orby request from bottons.

All scripts and styles are included in the header:

```html
    <header>
        <link rel="stylesheet" href="dynamic_language.css">
        <script src='dynamic_language.js'></script>
    </header>
```

So you need:

File | Content
---|---
[`dynamic_language.html`](dynamic_language.html)  | Example script
[`dynamic_language.css`](dynamic_language.css)    | Styling
[`dynamic_language.js`](dynamic_language.js)      | The javascripts


### Examples

Arguments | Result
---|---
dynamic_language.html                 | Default (=en)
dynamic_language.html?lang=en         | Default (=en)
dynamic_language.html?lang=da         | Danish
dynamic_language.html?lang=sp,fr      | Spanish and French
dynamic_language.html?lang=xx         | Undefined/Failing! (xx is ignored) 
dynamic_language.html?lang=xx,hi,da   | Hindi and Danish (xx is ignored) 

This is the output of `dynamic_language.html?lang=fr,es`

```
Bonjour Hola
[Danish] [English] [French] [Hindi] [Spanish] [All off] [Latin off]

We can use different languages in the HTML document simply by defining the "lang" property

English:""
Danish:""
French:"Bonjour"
Spanish:"Hola"
Hindi:""
```

If you switch on all languages the title will be:

```console
Hello Goddag Bonjour Hola नमस्ते
```

Press <kbd>Latin off</kbd> and French and Spanish are switched off:

```console
Hello Goddag नमस्ते
```
