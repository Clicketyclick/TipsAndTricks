console.log("Incl.js loaded");

document.getElementById("header").innerHTML += "Incl. included: "  ;

document.getElementByTag("header").innerHTML += "Incl. included: "  ;

document.getElementsByTagName("body")[0].innerHTML = "HEADER HERE  <div align="right"><a href=".." title="Up"><kbd>&#x2303;</kbd></a><a href="/" title="Home"><kbd>&#x1F3E0;</kbd></a></div></a> HEADER END" + document.getElementsByTagName("body")[0].innerHTML;
console.log("Incl.js Header inserted");
console.log("Incl.js ended");
