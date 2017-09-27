#!/bin/bash

Size=300
(echo "<h1>Is this the right image?</h1><a href=\"www.google.es\" ><img STYLE=\"max-width:$Size; max-height:$Size\" src=\"data:"
 mimetype -b "$1"
 echo -n ";base64,"
 base64 "$1"
 echo "\"></a>") | zenity --text-info --html --filename=/dev/stdin 
