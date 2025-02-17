/**
 *   @file       frame_grabber.js
 *   @brief      $(Brief description)
 *   @details    $(More details)
 *   
 *   @copyright  http://www.gnu.org/licenses/lgpl.txt LGPL version 3
 *   @author     Erik Bachmann <ErikBachmann@ClicketyClick.dk>
 *   @since      2025-02-17T12:11:16 / ErBa
 *   @version    2025-02-17T12:11:16
 */

/**
 *   @fn         frame_grabber( frame_id )
 *   @brief      grab content from specified iframe
 *   
 *   @param [in]	frame_id	ID of frame
 *   @retval     Entire frame content
 *   
 *   @details    
 *   
 *   @code
 *   <iframe id='myFrame' src='..'></iframe>
 *   <script>doc = frame_grabber( 'myFrame' );</script>
 *   @endcode
@verbatim
@endverbatim
 *   
 *   @todo       
 *   @bug        
 *   @warning    
 *   
 *   @see        https://
 *   @since      2025-02-17T12:11:22
 */
function frame_grabber( frame_id ) {
	// Get frame object
	var iframe = document.getElementById( frame_id );
	// Get frame content
	var y = (iframe.contentWindow || iframe.contentDocument);

	if (y.document) {
		y = y.document;
	}
	
	y.body
	console.log("object", y.body);

	return y;
}	// frame_grabber()


/**
 *   @fn         grab( frame_id )
 *   @brief      grab body from frame content
 *   
 *   @param [in]    frame_id	ID of frame
 *   @retval        Body of html in frame
 *   
 *   @details    
 *   
 *   @code
 *   <iframe id='myFrame' src='..'></iframe>
 *   <script>body = grab( 'myFrame' );</script>
 *   @endcode
@verbatim
@endverbatim
 *   
 *   @todo       
 *   @bug        
 *   @warning    
 *   
 *   @see        https://
 *   @since      2025-02-17T13:00:24
 */
function grab( frame_id ) {
	content    = frame_grabber( frame_id );
	console.log( "frame content", content.body.innerHTML);
	return content.body.innerHTML;
}   // grab()


/**
 *   @fn         copyFrame( frame_id, target)
 *   @brief      Copy content of frame to target
 *   
 *   @param [in]	frame_id	ID of frame
 *   @param [in]	target      ID of target
 *   @retval     
 *   
 *   @details    
 *   
 *   @code
 *   <div id='myDiv'></div>
 *   <iframe id='myFrame' src='..'></iframe>
 *   <script>body = copyFrame( 'myFrame', 'myDiv' );</script>
 *   @endcode
@verbatim
@endverbatim
 *   
 *   @todo       
 *   @bug        
 *   @warning    
 *   
 *   @see        https://
 *   @since      2025-02-17T13:02:27
 */
function copyFrame( frame_id, target) {
	document.getElementById( target ).innerHTML = grab( frame_id);
}   // copyFrame()
