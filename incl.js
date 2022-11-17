console.log("Incl.js loaded");
//document.getElementsByTagName("body")[0].innerHTML = "HEADER HERE<div align='right'><a href='..' title='Up'><kbd>&#x2303;</kbd></a><a href='/' title='Home'><kbd>&#x1F3E0;</kbd></a></div></a> HEADER END" + document.getElementsByTagName("body")[0].innerHTML;
var REPO = "TipsAndTricks";

document.getElementsByTagName("body")[0].innerHTML = 
  "[</a><div align='right'><a href='https://bit-sdub.github.io/"
    +REPO
  +"/demo.html' title='Demo'><kbd>&#x24B9;</kbd></a><a href='https://bit-sdub.github.io/"
    +REPO
  +"/releases' title='Releases'><kbd>&#x24C7;</kbd></a><a href='https://github.com/BIT-SDUB/"
    +REPO
  +"' title='Source'><kbd>&lt;&gt;</kbd></a> <a href='..' title='Up'><kbd>&#x2303;</kbd></a><a href='/' title='Home'><kbd>&#x1F3E0;</kbd></a></div>]" 
  + document.getElementsByTagName("body")[0].innerHTML;
console.log("Incl.js Header inserted");
console.log("Incl.js ended");





