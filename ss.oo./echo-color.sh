#!/bin/bash
#
# Colores en el terminal. 
#
# 
# Mas info:
# http://misc.flogisoft.com/bash/tip_colors_and_formatting
#==================================================================



function mostrar () {

mensaje="$1"
fin="\e[0m"


case $2 in
    negro)        color="\e[30m" ;;
    gris)         color="\e[90m" ;;
    rojo)         color="\e[31m" ;;
    rojoclaro)    color="\e[91m" ;;
    verde)        color="\e[32m" ;;
    verdeclaro)   color="\e[92m" ;;
    amarillo)     color="\e[33m" ;;
    amarilloclaro)color="\e[93m" ;;
    azul)         color="\e[34m" ;;
    azulclaro)    color="\e[94m" ;;
    magenta)      color="\e[35m" ;;
    magentaclaro) color="\e[95m" ;;
    cian)         color="\e[36m" ;;
    cianclaro)    color="\e[96m" ;;
    grisclaro)    color="\e[37m" ;;
    blanco)       color="\e[97m" ;;
    *)            ;;
esac

case $3 in
    negro)        fondo="\e[40m" ;;
    gris)         fondo="\e[100m" ;;
    rojo)         fondo="\e[41m" ;;
    rojoclaro)    fondo="\e[101m" ;;
    verde)        fondo="\e[42m" ;;
    verdeclaro)   fondo="\e[102m" ;;
    amarillo)     fondo="\e[43m" ;;
    amarilloclaro)fondo="\e[103m" ;;
    azul)         fondo="\e[44m" ;;
    azulclaro)    fondo="\e[104m" ;;
    magenta)      fondo="\e[45m" ;;
    magentaclaro) fondo="\e[105m" ;;
    cian)         fondo="\e[46m" ;;
    cianclaro)    fondo="\e[106m" ;;
    grisclaro)    fondo="\e[47m" ;;
    blanco)       fondo="\e[107m" ;;
    *)            ;; 
esac


echo -en "$color$fondo$mensaje$fin"

}




if [ ! -z "$1" ]; then
  mensaje="$1"
  fin="\e[0m"
  mostrar "$1" $2 $3   ####### Llamamos a la función mostrar
  echo                 ####### Salto de línea
else
  echo
  echo 'Modo de uso:'
  echo   $0  '  " Texto "   [colordeletra]   [colordefondo]'
  echo 
  for i in negro gris rojo rojoclaro verde verdeclaro amarillo amarilloclaro azul azulclaro magenta magentaclaro cian cianclaro grisclaro blanco; do
    for j in negro gris rojo rojoclaro verde verdeclaro amarillo amarilloclaro azul azulclaro magenta magentaclaro cian cianclaro grisclaro blanco; do
        mostrar " Texto " $i $j
    done
    echo
  done
  echo
  echo 'A continuación tienes la lista de colores permitidos:'
  for i in negro gris rojo rojoclaro verde verdeclaro amarillo amarilloclaro azul azulclaro magenta magentaclaro cian cianclaro grisclaro blanco; do
    echo  " $i "
  done
  echo
  exit 0
fi
