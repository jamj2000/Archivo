#!/bin/bash
#
# Ejemplo de DIÁLOGO (válido para consola y entorno gráfico)
# * Para comprobar en consola pulsar Ctrl+Alt+F1 y ejecutar script.
# * Para comprobar en interfaz gráfica pulsar Ctrl+Alt+F7 y ejecutar script.
#
# Es necesario tener instalados en el sistema los siguientes paquetes:
# - zenity   (para diálogo tipo gdialog)
# - mc       (para trabajar con archivos en consola)
# - nautilus (para trabajar con archivos en interfaz gráfica)
# - fbi      (para visualizar imágenes en consola)
# - viewnior (para visualizar imágenes en interfaz gráfica)
# - elinks   (para navegar por internet en consola)
# - firefox  (para navegar por internet en interfaz gráfica)
# - gpm      (para soporte de ratón en consola)
#
# Para instalar en Ubuntu estos paquetes, ejecutar:
# sudo apt-get install zenity mc nautilus fbi viewnior elinks firefox gpm
#
# NOTA: El visor de imágenes fbi hace uso del FrameBuffer. Para que funcione este programa debe ejecutarse el script como administrador desde consola.
#
# Mas info acerca de dialog al estilo antiguo:
# http://www.linuxjournal.com/article/2807
#
# Mas info acerca de zenity:
# https://help.gnome.org/users/zenity/stable/index.html.es
#
#=============================================================================================


if [ -z $DISPLAY ]; then
  # Programas para consola
  DIALOG=dialog
  EXPLORADOR=mc
  VISORIMAGENES=fbi
  NAVEGADOR=elinks
else
  # Programas para entorno gráfico
  DIALOG=gdialog
  EXPLORADOR=nautilus
  VISORIMAGENES=viewnior
  NAVEGADOR=firefox
fi


for ((;1;))
do
    $DIALOG \
    --backtitle "Diálogo de menú" --title "Menú principal" \
    --menu      "Pulsa [UP][DOWN],[Enter] para seleccionar" 15 60 4 \
    Archivos    "Trabajar con archivos y carpetas" \
    Imágenes    "Ver imágenes" \
    Navegar     "Navegar por la web" \
    Salir       "Salir de la aplicación" \
    2>/tmp/menuitem.$$


    menuitem=`cat /tmp/menuitem.$$`
    opt=$?

    case $menuitem in
            Archivos) $EXPLORADOR ~ 
            ;;
            Imágenes) $VISORIMAGENES /usr/share/pixmaps/* 
            ;;
            Navegar) $NAVEGADOR www.google.es 
            ;;
            Salir) exit 0 
            ;;
    esac
done 
