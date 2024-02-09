@@Markdown_logo@@

## Markdown

### Page break [^1]

[^1]: (Based on [<img src="../logo-stackoverflow.icon.png" title="Link to Stackoverflow" width=16px height=auto> - pagebreak in markdown while creating pdf](https://stackoverflow.com/a/29642392)).

```html
 
<div style="page-break-after: always;"></div>
 
```
A blank line after the &lt;div&gt; is mandatory.

### Markup

Highligting a snippet of text can (in some editors) be marked as:

```html
- **This** *is* a ==highlighted== text
- **This** *is* a <mark>highlighted</mark> text
```
- **This** *is* a ==highlighted== text
- **This** *is* a <mark>highlighted</mark> text

> Note that Github removes the HTML tag &lt;mark&gt;

Just like &lt;fieldset&gt; etc

```html
<fieldset><legend>Note</legend>Github removes the HTML tag &lt;mark&gt;</fieldset>
```
<fieldset><legend>Note</legend>Github removes the HTML tag &lt;mark&gt; - but they will be visible on Github Pages!</fieldset>

### Alerts  [^2]

[^2]: (Snip from [<img src="../github-mark.png" title="Link to Github" width=16px height=auto> - Basic writing and formatting syntax - Alerts](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax#alerts))

<fieldset><legend>Warning</legend>NOT available Github Pages - only in Github Source!</fieldset>

```html
> [!NOTE]
> Highlights information that users should take into account, even when skimming.

> [!TIP]
> Optional information to help a user be more successful.

> [!IMPORTANT]
> Crucial information necessary for users to succeed.

> [!WARNING]
> Critical content demanding immediate user attention due to potential risks.

> [!CAUTION]
> Negative potential consequences of an action.
```

> [!NOTE]
> Highlights information that users should take into account, even when skimming.

> [!TIP]
> Optional information to help a user be more successful.

> [!IMPORTANT]
> Crucial information necessary for users to succeed.

> [!WARNING]
> Critical content demanding immediate user attention due to potential risks.

> [!CAUTION]
> Negative potential consequences of an action.



---
