#!/bin/bash

# Call this with two file names
Size=300
Style=" STYLE=\"max-width:$Size; max-height:$Size\""

(echo "<TABLE><TR><TD STYLE=\"width:100%; margin:0px auto;\"><IMG$Style
SRC=\"data:"
mimetype -b "$1"
echo -n ";base64,"
base64 "$1"
echo "\"></TD><TD><IMG$Style SRC=\"data:"
mimetype -b "$2"
echo -n ";base64,"
base64 "$2"
echo "\"></TD></TR></TABLE>" ) | zenity --ok-label=Identical --cancel-label=Different --width=$(($Size*2+50)) --height=$(($Size+100)) --title="Are those two images identical?" --text-info --html --filename=/dev/stdin 
