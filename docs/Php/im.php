<?php

// https://stackoverflow.com/q/42783581 - Resize image and place in center of canvas

include_once( 'handleIptc.php' );

$source		= "poloroid.jpg";
$flag_path	= "flags/iso/png/128x128/flag-dk.png";
$im = new Imagick($source );

$size = getimagesize($source, $info);
if(isset($info['APP13']))
{
    $iptc_data = iptcparse($info['APP13']);
    //var_dump($iptc_data);
    //var_dump($iptc_data["2#100"][0]);
	
}

//setIptcTags( $iptc_tags );

//$iptc2	= getIptcTags( $iptc_tags, $iptc_data );
$iptc2	= parseIptc( $iptc_data );



//var_export( $iptc2 );
var_dump( $iptc2 );
print json_encode( $iptc2, JSON_PRETTY_PRINT );
//print_r( $iptc2 );
exit;

$iptc1['country']		= $iptc_data["2#101"][0] ?? "country?";
$iptc1['location']		= $iptc_data["2#092"][0] ?? "location?";
$iptc1['countrycode']	= $iptc_data["2#100"][0] ?? "countrycode?";
$iptc1['headline']		= $iptc_data["2#105"][0] ?? "headline?";
$iptc1['caption']		= $iptc_data["2#120"][0] ?? "caption?";

$flag_path	= "flags/".strtolower( $iptc1['countrycode'] ).".png";



$flag = new Imagick($flag_path);


$draw = new ImagickDraw();
$imageprops = $im->getImageGeometry();
$width = $imageprops['width'];
$height = $imageprops['height'];
if($height > '3900'){
$newHeight = 390;
$newWidth = (390 / $height) * $width;
}else{/**
 *  @file      im.php
 *  @brief     $(Brief description)
 *  
 *  @details   $(More details)
 *  
 *  @copyright http://www.gnu.org/licenses/lgpl.txt LGPL version 3
 *  @author    Erik Bachmann <ErikBachmann@ClicketyClick.dk>
 *  @since     2024-01-11T12:02:32 / erba
 *  @version   2024-01-11T12:02:32
 *  
 */

$im->resizeImage($newWidth,$newHeight, Imagick::FILTER_LANCZOS, 0.9, true);

$canvas = new Imagick();
$finalWidth 		= 4000;
$finalHeight 		= 3000;
$backgroundColor	= 'black';
$outputType			= 'jpg';
$canvas->newImage($finalWidth, $finalHeight, $backgroundColor, $outputType );
$offsetX = (int)($finalWidth  / 2) - (int)($newWidth  / 2);
$offsetY = (int)($finalHeight / 2) - (int)($newHeight / 2);

print $offsetX;
print "\n";
print $offsetY;

$offsetX = 20;
$offsetY = 0;
$canvas->compositeImage( $im, imagick::COMPOSITE_OVER, $offsetX, $offsetY );
$canvas->compositeImage( $flag, imagick::COMPOSITE_OVER, 3800, 2800 );

$draw->setFillColor('yellow');
$draw->setFontSize( 50 );
$draw->setTextAlignment(\Imagick::ALIGN_RIGHT);
//$canvas->annotateImage($draw, $finalWidth - 500, 45, 0, 'The quick brown fox jumps over the lazy dog');
//$canvas->annotateImage($draw, $finalWidth - 10, 450, 0, 'The quick brown fox jumps over the lazy dog');
$canvas->annotateImage($draw, $finalWidth - 10, 450, 0, $iptc1['headline']);


$draw->setFillColor('white');
$draw->setFontSize( 50 );

//$canvas->annotateImage($draw, $finalWidth - 10, 850, 0, $iptc1['caption']);


$bbox = imageftbbox(12, 0, 'Arial.ttf', 'This is a test');
$width_of_text = $bbox[2] - $bbox[0];

$msg	= "An awfull long line filled with a blody noncence";

$xpos		= 3400;
$xpos		= $finalWidth;
$ypos		= 600;
$boxwidth	= 800;

list($lines, $lineHeight) = wordWrapAnnotation($canvas, $draw, $iptc1['caption'], $boxwidth);
for($i = 0; $i < count($lines); $i++)
    $canvas->annotateImage($draw, $xpos, $ypos + $i*$lineHeight, 0, $lines[$i]);



$path	= "test-1.jpg";
$path2	= "test-2.jpg";
$canvas->writeImage( "test-1.jpg" );



// Convert the IPTC tags into binary code
$data = '';

foreach($iptc_data as $tag => $string)
{
    $tag = substr($tag, 2);
	//$data .= iptc_make_tag(2, $tag, implode( ", ", $string ) );
	// Single elements OR lists (Keywords)
	foreach ( $string as $element )
		$data .= iptc_make_tag(2, $tag, $element );
}


// Embed the IPTC data
$content = iptcembed($data, $path);

// Write the new image data out to the file.
$fp = fopen($path2, "wb");
fwrite($fp, $content);
fclose($fp);



var_export( $info['APP13'] );

//---------------------------------------------------------------------

// iptc_make_tag() function by Thies C. Arntzen
function iptc_make_tag($rec, $data, $value)
{
    $length = strlen($value);
    $retval = chr(0x1C) . chr($rec) . chr($data);

    if($length < 0x8000)
    {
        $retval .= chr($length >> 8) .  chr($length & 0xFF);
    }
    else
    {
        $retval .= chr(0x80) . 
                   chr(0x04) . 
                   chr(($length >> 24) & 0xFF) . 
                   chr(($length >> 16) & 0xFF) . 
                   chr(($length >> 8) & 0xFF) . 
                   chr($length & 0xFF);
    }

    return $retval . $value;
}


//---------------------------------------------------------------------

/* Implement word wrapping... Ughhh... why is this NOT done for me!!!
    OK... I know the algorithm sucks at efficiency, but it's for short messages, okay?

    Make sure to set the font on the ImagickDraw Object first!
    @param image the Imagick Image Object
    @param draw the ImagickDraw Object
    @param text the text you want to wrap
    @param maxWidth the maximum width in pixels for your wrapped "virtual" text box
    @return an array of lines and line heights
*/


/**
 *				
 *  @fn        	myFunction
 *  @brief      $(Brief description)
 *  
 *   @param image		the Imagick Image Object
 *   @param draw 		the ImagickDraw Object
 *   @param text 		the text you want to wrap
 *   @param maxWidth	the maximum width in pixels for your wrapped "virtual" text box
 *   @return an array of lines and line heights
 *  
 *  @details    $(More details)
 *  
 *  @example   
 *  
 *  @todo      
 *  @bug       
 *  @warning   
 *  
 *  @see       https://
 *  @since     2024-01-11T11:47:46 / erba
 */
function wordWrapAnnotation(&$image, &$draw, $text, $maxWidth) 
{
    $words = explode(" ", $text);
    $lines = array();
    $i = 0;
    $lineHeight = 0;
    while($i < count($words) )
    {
        $currentLine = $words[$i];
        if($i+1 >= count($words))
        {
            $lines[] = $currentLine;
            break;
        }
        //Check to see if we can add another word to this line
        $metrics = $image->queryFontMetrics($draw, $currentLine . ' ' . $words[$i+1]);
        while($metrics['textWidth'] <= $maxWidth)
        {
            //If so, do it and keep doing it!
            $currentLine .= ' ' . $words[++$i];
            if($i+1 >= count($words))
                break;
            $metrics = $image->queryFontMetrics($draw, $currentLine . ' ' . $words[$i+1]);
        }
        //We can't add the next word to this line, so loop to the next line
        $lines[] = $currentLine;
        $i++;
        //Finally, update line height
        if($metrics['textHeight'] > $lineHeight)
            $lineHeight = $metrics['textHeight'];
    }
    return array($lines, $lineHeight);
}	// wordWrapAnnotation()



//---------------------------------------------------------------------
?>