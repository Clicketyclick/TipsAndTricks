var _SESSION = { 
	paths: { 
		cover:"images/"		// Images dir root
	,	main_stub: ""		// Images dir relative to main_stub (= `fig.html`)
	,	sub_stub:  "../"	// Images dir relative to sub_stub (= `sub/fig_sub.html` i.e. `../images/`)
	}
};

function sessionCoverPath( id, caller) {
	path= _SESSION["paths"][caller]
	+	_SESSION["paths"]["cover"]
	+	id
	+	".jpg";
	console.log("coverpath:"+path);
	
	return path;
}	// sessionCoverPath


function insertImage( anchor, src ) {
	var img = document.createElement("img");
	
	img.src = src;		//img.src = "http://www.google.com/intl/en_com/images/logo_plain.png";
	anchor.appendChild(img);	//var src = document.getElementById("header");
}	// insertImage()

function updateTitleImageInfo( anchor ) {
	var width = anchor.clientWidth;
	var height = anchor.clientHeight;
	anchor.title=anchor.title+' ['+width+'x'+height+'] '+ sessionCoverPath( anchor.id, caller);
}	// updateTitleImageInfo()

function updateCaption( anchor ) {
	let target=document.getElementById('caption_'+anchor.id);
	target.innerHTML=anchor.id +": "+  _image[anchor.id]['title'];
	if ( _image[anchor.id]['author'] ) {
		target.innerHTML = target.innerHTML + ' / ' + _image[anchor.id]['author'];
	}
}	// updateTitleImageInfo()
