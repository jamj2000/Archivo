#!/bin/bash

echo
echo
echo
echo "SCRIPT PARA BAJAR FONDOS DE PANTALLA DESDE WALLHAVEN.CC"
echo

if [ -z $1 ]; then
  echo "Por favor, introduce tema de fondo de pantalla, preferiblemente en inglés"
  echo "Ejemplos: tiger landscape city bird animal"
  echo -n "Tema a descargar: "
  read tema
  echo -n "Número de páginas (p.ej: 2): "
  read numPaginas
else
  tema=$1
  if [ -z $2 ]; then numPaginas=1; else numPaginas=$2; fi
fi


echo
echo "Creando lista de fondos cuyo tema es $tema"
echo

declare -a listaPaginas
declare -a listaImagenes

for (( i=1; i<=numPaginas; i++ )); do
  listaPaginas+=(`wget -O - -nv  http://alpha.wallhaven.cc/search?q=$tema\&page=$i | grep -Eo "\"http://alpha.wallhaven.cc/wallpaper/[0-9]{6}\""  | sed s/\"//g`)
done 

for i in ${listaPaginas[*]}; do
  listaImagenes+=(`wget -O - -nv $i | grep -Eo //wallpapers.wallhaven.cc/wallpapers/full/wallhaven-[0-9]{6}\.\(jpg\|png\) | head -1`)
done

echo
echo "Descargando fondos en carpeta $tema "
echo


for i in ${listaImagenes[*]}; do
  wget -nv http:$i -P $tema   --show-progress
done

echo
echo "Resumen. Imágenes descargadas y su tamaño"
echo

file $tema/* |  sed -nr 's/^(.*)(wallhaven-[0-9]{6}.jpg)(.*)([0-9]{4}x[0-9]{3,})(.*)/\2 ... \4/p'

