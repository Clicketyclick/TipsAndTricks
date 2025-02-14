/**
 *   @file       update_favicon.js
 *   @brief      Function for updating existing favicon
 *   @details    Note! Requres a `<link rel="icon" type="image/x-icon" href="./favicon.ico">` favicon link in head.
 *   
 *   @code
    <link rel="icon" type="image/x-icon" href="./favicon.ico">

<script src="update_favicon.js"></script>
<script>
// Icon set to loop through
var favs = [
    'https://devhints.io//assets/favicon.png',
    'https://stackoverflow.com/favicon.ico',
];
set_favicon( favs[1] );
</script>
 *   @endcode
 *   
 *   @copyright  http://www.gnu.org/licenses/lgpl.txt LGPL version 3
 *   @author     Erik Bachmann <ErikBachmann@ClicketyClick.dk>
 *   @since      2025-02-14T10:34:41 / ErBa
 *   @version    2025-02-14T10:49:51
 */

// https://stackoverflow.com/a/260876 - Changing website favicon dynamically
function set_favicon( url ) {
    var link = document.querySelector("link[rel~='icon']");
    if (!link) {
        link = document.createElement('link');
        link.rel = 'icon';
        document.head.appendChild(link);
    }
    link.href = url;
}   // set_favicon()

//------------------------------------------------------------------------

// Set source of image tag
function set_image( id, url ) {
    document.getElementById( id ).src = url;
}   // set_image()

//------------------------------------------------------------------------
