# Relativ paths in JavaScript


If scripts are using the same image repository, but are themselves located at various directories the image path may also vary dynamicly


    ├─  fig.html            main_stub
    ├─   fig.js             Updateing path and captions
    ├─   metadata.js        metadata in JSON 
    ├─   README.md          This file
    │
    ├───images              image files
    │
    └───sub
        └─ fig_sub.html     sub_stub

Given the to HTML files `./fig.html` and `./sub/fig_sub.html` will each reference the same image differently:

File| img src
---|---
`./fig.html`			| `images/001608687.jpg`
`./sub/fig_sub.html`	| `../images/001608687.jpg`

By updating the `src` dynamicly the same block of `img` code can be reused:

	<script src='fig.js'></script>
	<script src='metadata.js'></script>
	<script>caller='main_stub';</script>
	:

	<figure 
		id='figure_53165133'
		class="cover">
		<img 
			id='53165133'
			class="cover" 
			src='dummy' 
			onerror="this.src = sessionCoverPath( this.id, caller);" 
			onload="updateTitleImageInfo( this );updateCaption( this );" 
			width=300px height=auto
		>
		<figcaption id='caption_53165133'>53165133: ?  / ? </figcaption>
	</figure>

To migrate the figure block to another location simply requires a change of `caller`name and an updated path (or copy of the script) `fig.js`.

The file `./sub/fig_sub.html` will have the configuration:
	<script src='../fig.js'></script>
	<script src='../metadata.js'></script>
	<script>caller='sub_stub';</script>

where caller is defined in the `_SESSION` JSON in `fig.js`:

	var _SESSION = { 
		paths: { 
			cover:"images/"		// Images dir root
		,	main_stub: ""		// Images dir relative to main_stub (= `fig.html`)
		,	sub_stub:  "../"	// Images dir relative to sub_stub  (= `sub/fig_sub.html` i.e. `../images/`)
		}
	};

## Process

	src='dummy' 

Will fail - on error 

	onerror="this.src = sessionCoverPath( this.id, caller);" 

is called and `this.src` is updated with a path to an image with the ID held in `this.id`.

in `fig.html` the ID `53165133` and `<script>caller='main_stub';</script>` will give a relative path of:

	images/53165133.jpg

in `sub/fig_sub.html` the same ID `53165133` and `<script>caller='sub_stub';</script>`  will give a relative path of:

	../images/53165133.jpg

## Examples

File | Description
---|---
[`fig.html`](fig.html)            		| main_stub
[`fig.js`](fig.js)             			| Updateing path and captions
[[`metadata.js`](metadata.js)        	| metadata in JSON 
[`README.md`]()          				| This file
[`images`](images/)              		| image files
[`sub/fig_sub.html`](sub/fig_sub.html)	| sub_stub

---
