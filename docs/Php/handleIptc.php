<?php

/*
IPTC ApplicationRecord Tags
https://exiftool.org/TagNames.pdf

Tag ID Tag Name Writable
------ -------- --------
*/
$iptc_tags	= [
	"0"		=> "ApplicationRecordVersion"			// 0	ApplicationRecordVersion				int16u:
,	"3"		=> "ObjectTypeReference"				// 3	ObjectTypeReference						string[3,67]
,	"4"		=> "ObjectAttributeReference"			// 4	ObjectAttributeReference				string[4,68]+
,	"5"		=> "ObjectName"							// 5	ObjectName								string[0,64]
,	"7"		=> "EditStatus"							// 7	EditStatus								string[0,64]
,	"8"		=> "EditorialUpdate"					// 8	EditorialUpdate							digits[2]
,	"10"	=> "Urgency"							// 10	Urgency									digits[1]
,	"12"	=> "SubjectReference"					// 12	SubjectReference						string[13,236]+
,	"15"	=> "Category"							// 15	Category								string[0,3]
,	"20"	=> "SupplementalCategories"				// 20	SupplementalCategories					string[0,32]+
,	"22"	=> "FixtureIdentifier"					// 22	FixtureIdentifier						string[0,32]
,	"25"	=> "Keywords"							// 25	Keywords								string[0,64]+
,	"26"	=> "ContentLocationCode"				// 26	ContentLocationCode						string[3]+
,	"27"	=> "ContentLocationName"				// 27	ContentLocationName						string[0,64]+
,	"30"	=> "ReleaseDate"						// 30	ReleaseDate								digits[8]
,	"35"	=> "ReleaseTime"						// 35	ReleaseTime								string[11]
,	"37"	=> "ExpirationDate"						// 37	ExpirationDate							digits[8]
,	"38"	=> "ExpirationTime"						// 38	ExpirationTime							string[11]
,	"40"	=> "SpecialInstructions"				// 40	SpecialInstructions						string[0,256]
,	"42"	=> "ActionAdvised"						// 42	ActionAdvised							digits[2]
,	"45"	=> "ReferenceService"					// 45	ReferenceService						string[0,10]+
,	"47"	=> "ReferenceDate"						// 47	ReferenceDate							digits[8]+
,	"50"	=> "ReferenceNumber"					// 50	ReferenceNumber							digits[8]+
,	"55"	=> "DateCreated"						// 55	DateCreated								digits[8]
,	"60"	=> "TimeCreated"						// 60	TimeCreated								string[11]
,	"62"	=> "DigitalCreationDate"				// 62	DigitalCreationDate						digits[8]
,	"63"	=> "DigitalCreationTime"				// 63	DigitalCreationTime						string[11]
,	"65"	=> "OriginatingProgram"					// 65	OriginatingProgram						string[0,32]
,	"70"	=> "ProgramVersion"						// 70	ProgramVersion							string[0,10]
,	"75"	=> "ObjectCycle"						// 75	ObjectCycle								string[1]
,	"80"	=> "By-line"							// 80	By-line									string[0,32]+
,	"85"	=> "By-lineTitle"						// 85	By-lineTitle							string[0,32]+
,	"90"	=> "City"								// 90	City									string[0,32]
,	"92"	=> "Sub-location"						// 92	Sub-location							string[0,32]
,	"95"	=> "Province-State"						// 95	Province-State							string[0,32]
,	"100"	=> "Country-PrimaryLocationCode"		// 100	Country-PrimaryLocationCode				string[3]
,	"101"	=> "Country-PrimaryLocationName"		// 101	Country-PrimaryLocationName				string[0,64]
,	"103"	=> "OriginalTransmissionReference"		// 103	OriginalTransmissionReference			string[0,32]
,	"105"	=> "Headline"							// 105	Headline								string[0,256]
,	"110"	=> "Credit"								// 110	Credit									string[0,32]
,	"115"	=> "Source"								// 115	Source									string[0,32]
,	"116"	=> "CopyrightNotice"					// 116	CopyrightNotice							string[0,128]
,	"118"	=> "Contact"							// 118	Contact									string[0,128]+
,	"120"	=> "Caption-Abstract"					// 120	Caption-Abstract						string[0,2000]
,	"121"	=> "LocalCaption"						// 121	LocalCaption							string[0,256]
,	"122"	=> "Writer-Editor"						// 122	Writer-Editor							string[0,32]+
,	"125"	=> "RasterizedCaption"					// 125	RasterizedCaption						undef[7360]
,	"130"	=> "ImageType"							// 130	ImageType								string[2]
,	"131"	=> "ImageOrientation"					// 131	ImageOrientation						string[1]
,	"135"	=> "LanguageIdentifier"					// 135	LanguageIdentifier						string[2,3]
,	"150"	=> "AudioType"							// 150	AudioType								string[2]
,	"151"	=> "AudioSamplingRate"					// 151	AudioSamplingRate						digits[6]
,	"152"	=> "AudioSamplingResolution"			// 152	AudioSamplingResolution					digits[2]
,	"153"	=> "AudioDuration"						// 153	AudioDuration							digits[6]
,	"154"	=> "AudioOutcue"						// 154	AudioOutcue								string[0,64]
,	"184"	=> "JobID"								// 184	JobID									string[0,64]
,	"185"	=> "MasterDocumentID"					// 185	MasterDocumentID						string[0,256]
,	"186"	=> "ShortDocumentID"					// 186	ShortDocumentID							string[0,64]
,	"187"	=> "UniqueDocumentID"					// 187	UniqueDocumentID						string[0,128]
,	"188"	=> "OwnerID"							// 188	OwnerID									string[0,128]
,	"200"	=> "ObjectPreviewFileFormat"			// 200	ObjectPreviewFileFormat					int16u
,	"201"	=> "ObjectPreviewFileVersion"			// 201	ObjectPreviewFileVersion				int16u
,	"202"	=> "ObjectPreviewData"					// 202	ObjectPreviewData						undef[0,256000]
,	"221"	=> "Prefs"								// 221	Prefs									string[0,64]
,	"225"	=> "ClassifyState"						// 225	ClassifyState							string[0,64]
,	"228"	=> "SimilarityIndex"					// 228	SimilarityIndex							string[0,32]
,	"230"	=> "DocumentNotes"						// 230	DocumentNotes							string[0,1024]
,	"231"	=> "DocumentHistory"					// 231	DocumentHistory							string[0,256]
,	"232"	=> "ExifCameraInfo"						// 232	ExifCameraInfo							string[0,4096]
,	"255"	=> "CatalogSets"						// 255	CatalogSets								string[0,256]+
];


function parseIptc( $iptc_data )
{
	global $iptc_tags;
	$data	= [];
	foreach ( $iptc_tags as $key => $name )
	{
		$tag	= sprintf( "2#%03.3s", $key );
		if ( isset( $iptc_data[ $tag ] ) )
			$data[$name]	= $iptc_data[$tag];
	}
	return( $data );
}
