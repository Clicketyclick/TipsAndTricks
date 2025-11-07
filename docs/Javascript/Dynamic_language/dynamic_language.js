/**
 * @file       dynamic_language.js
 * @brief      Set language dynamic
 * @details    
 * 
 * Functions|Brief
 * ---|---
 * parseLanguage        | Set language from URL
 * switchLanguageOn     | Display specific language
 * switchLanguageOff    | Switch off one or more languages
 * 
 * @copyright  http://www.gnu.org/licenses/lgpl.txt LGPL version 3
 * @author     Erik Bachmann <Erik@ClicketyClick.dk>
 * @since      2025-11-07T12:01:35 / erba
 * @version    2025-11-07T12:01:35
 */

// Detect browser language
let language = navigator.language;

/**
 * @fn         parseLanguage
 * @brief      Set language from URL
 * 
 * @param [in]		debug=false		Debug flag
 * 
 * @details    Parses the `lang=` paramter in the URL
 * 
 * <!--
 * @code
 * @endcode
@verbatim
@endverbatim
 * @todo       
 * @bug        
 * @warning    
 * @note    
 * @see        https://
 * -->
 * @since      2025-11-07T12:02:08
 */
function parseLanguage( debug=false ) {
    // Parse arguments
    const queryString = window.location.search;
    if (debug) console.log('queryString' + queryString);
    const urlParams = new URLSearchParams(queryString);
    if (urlParams.get('lang')) {
    const urlParamsLang = urlParams.get('lang')
        console.log(urlParamsLang);
    if (urlParamsLang.lengt != 0)
        language = urlParamsLang;
    if (debug) console.log('language:' + language);
    }
}   // parseLanguage()

//------------------------------------------------------------------------

/**
 * @fn         switchLanguageOn
 * @brief      Display specific language
 * 
 * @param [in]	curLang	= 'en'	    Language to switch on
 * @param [in]	flag	= true	    On/off switch
 * @param [in]	debug   = false		Debug flag
 * 
 * @details    $(More details)
 * 
 * <!--
 * @code
 * @endcode
@verbatim
@endverbatim
 * @todo       
 * @bug        
 * @warning    
 * @note    
 * @see        https://
 * -->
 * @since      2025-11-07T12:04:06
 */
function switchLanguageOn(curLang = 'en', flag = true, debug=false ) {
    if ( curLang.length == 0) curLang = 'en'

    // Only elements whose lang attribute equals "es"
    //  const cols = document.querySelectorAll('[lang="'+curLang+'"]');
    // elements whose lang attribute equals any in list: lang=en,hi = either en or hi
    const cols = document.querySelectorAll('[lang="'+curLang.replace(/,/g, '"], [lang="')+'"]');
    if (debug) console.log('lang[' + curLang + ']:' + cols.length);
    for (i = 0; i < cols.length; i++) {
        if (debug) console.log('display[' + cols[i].style.display + ']' + cols.length);
        // If not set
        if (cols[i].style.display == 'none' || cols[i].style.display == '')
            cols[i].style.display = 'inline';
        else
            if (flag) {
                cols[i].style.display = 'none';
            }
    }
} // switchLanguageOn

//------------------------------------------------------------------------

/**
 * @fn         switchLanguageOff
 * @brief      Switch off one or more languages
 * 
 * @param [in]	curLang	=	''	Language (default all)
 * @param [in]	debug=false		Debug flag
 * 
 * <!--
 * @details    $(More details)
 * 
 * @code
 * @endcode
@verbatim
@endverbatim
 * @todo       
 * @bug        
 * @warning    
 * @note    
 * @see        https://
 * -->
 * @since      2025-11-07T12:05:57
 */
function switchLanguageOff( curLang = '', debug=false ) {
    if ( curLang.length == 0) { // No language
        var cols = document.querySelectorAll('[lang]');
        if (debug) console.log('no langoff[]:' + cols.length);
    }
    else {  // Specific languages
        var cols = document.querySelectorAll('[lang="'+curLang.replace(/,/g, '"], [lang="')+'"]');
    }
    if (debug) console.log('langoff[' + curLang + ']:' + cols.length);
    for (i = 0; i < cols.length; i++) {
        cols[i].style.display = 'none';
    }
} // switchLanguageOn

//------------------------------------------------------------------------

//*** End of File ***