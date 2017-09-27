 #!/bin/sh

if [ -z $DISPLAY ]
then
   DIALOG=dialog
else
   DIALOG=zenity #Xdialog
fi
 

zenity --question --title=”Pregunta” --text=”¿No es divertido?”
#$DIALOG --yesno "Is this fun" 0 0  
