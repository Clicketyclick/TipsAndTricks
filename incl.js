console.log("Incl.js loaded");

document.getElementById("header").innerHTML += "Incl. included: "  ;

document.getElementByTag("header").innerHTML += "Incl. included: "  ;

document.getElementsByTagName("body")[0].innerHTML = "HEADER HERE" + document.getElementsByTagName("body")[0].innerHTML;
console.log("Incl.js Header inserted");
console.log("Incl.js ended");
