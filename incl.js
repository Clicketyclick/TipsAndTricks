console.log("Incl.js loaded");
//document.getElementsByTagName("body")[0].innerHTML = "HEADER HERE<div align='right'><a href='..' title='Up'><kbd>&#x2303;</kbd></a><a href='/' title='Home'><kbd>&#x1F3E0;</kbd></a></div></a> HEADER END" + document.getElementsByTagName("body")[0].innerHTML;
var REPO = "TipsAndTricks";
var TIME= "2022-11-17T16:05:37";
document.getElementsByTagName("body")[0].innerHTML = 
  TIME+ "[</a><div align='right'>"
// Demo
  + "<button onclick=\"location.href='https://bit-sdub.github.io/"
    +REPO
  +"/demo.html'\" title='Demo' type='button' title='Up'>&#x24B9;</button>"
// Releases
  + "<button onclick=\"location.href='https://bit-sdub.github.io/"
    +REPO
  +"/releases'\" title='Releases' type='button' title='Up'>&#x24C7;</button>"

/*
  "[</a><div align='right'><a href='https://bit-sdub.github.io/"
    +REPO
  +"/demo.html' title='Demo'><kbd>&#x24B9;</kbd></a><a href='https://bit-sdub.github.io/"
    +REPO
  +"/releases' title='Releases'><kbd>&#x24C7;</kbd></a>"
  + "<button onclick=\"location.href='https://github.com/BIT-SDUB/"
    +REPO
  +"' title='Source'><kbd>&lt;&gt;</kbd></a> "




  //+ "<a href='..' title='Up'><kbd>&#x2303;</kbd></a><a href='/' title='Home'><kbd>&#x1F3E0;</kbd></a></div>]"
 */

// Source
  + "<button onclick=\"location.href='https://github.com/BIT-SDUB/"
    +REPO
  +"'\" type='button' title='Source'>&lt;&gt;</button>"

  + "<button onclick=\"location.href='..'\" type='button' title='Up'>&#x2303;</button>"
  + "<button onclick=\"location.href='/'\" type='button' title='Home'>&#x1F3E0;</button>"
  + "</div>"
  + document.getElementsByTagName("body")[0].innerHTML;
console.log("Incl.js Header inserted");
console.log("Incl.js ended");





