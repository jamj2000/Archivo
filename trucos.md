# Trucos (para terminal de Linux)

## Realizar fetch desde Nodejs en servidor

> Esta característica es experimental y puede fallar a veces.

```
node  --experimental-fetch 


const res = await fetch('https://api.github.com/users/jamj2000')
const data = await res.json()

fetch ('https://api.github.com/users/jamj2000').then( res => res.json()).then( data => console.log(data))
```


## Comprobar velocidad de un disco duro

```
sudo hdparm -tT /dev/sda
```

## Habilitar altavoces en Ubuntu 20.04 en Dell Latitude 3510

En `/etc/default/grub` poner:

```
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash snd_hda_intel.dmic_detect=0"
```

## Ver contenido de archivos binarios (útil para examinar archivos de FIRMWARE)
```
binwalk  archivo.bin
```

## Conectar a una red wifi desde el terminal

```bash
nmcli device wifi connect SSID-Name password wireless-password
```

## Cambiar un texto en todos los archivos jsp

```bash
sed  -i  's/foo/bar/g'  *.jsp
```

## Extraer texto de un archivo

```bash   
cat  archivo | grep -o iniciotexto.*finaltexto
```


## Ver PDF o PS en maquinas con poquisimos recursos (mejor que xpdf) 

```bash
# Lanzar desde consola en X-Window
gs -r120 -g1200x1600 archivo.pdf      
``` 

``` 
-r: Puntos Por Pulgada
-g: Tamaño en pixeles
``` 

Para mover pagina por la pantalla, mantener tecla ALT pulsada y mover con el raton.


## Unir varios archivos PDF en uno solo

```bash
gs -sDEVICE=pdfwrite -sOutputFile=archivo-final.pdf \
   -dNOPAUSE  -dBATCH \  
   archivo1.pdf archivo2.pdf archivo3.pdf 
``` 


## Extraer páginas individuales de un documento PDF multipágina 

```bash
gs  -o pagina-%02d.pdf -sDEVICE=pdfwrite \
    -dPDFSETTINGS=/prepress \
    documento-multi-pagina.pdf
```

```
-dPDFSETTINGS=/prepress: Alta calidad
```

### Crear certificado digital autofirmado

```bash
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout nombre.key -out nombre.crt
```


## Grabar desde consola una ISO de forma sencilla

```bash
# Con emulacion SCSI
cdrecord  dev=0,1,0  driveropts=burnfree  NombreImagen.iso
       
# Sin emulacion SCSI
cdrecord  dev=/dev/hdd  driveropts=burnfree  NombreImagen.iso
```

## Cambiar codificación de ISO-8859-1 a UTF-8</h2>

```bash
iconv  -f  ISO-8859-1  -t  UTF-8  -o  archivo-final  archivo-inicial
```	


## Como ver todas las imágenes .jpg desde una consola de texto

```bash
fbi  *.jpg
```	

## Como ver videos desde una consola de texto
      
```bash
# Primera forma
ffplay  video.avi
        
#  Segunda forma
mplayer  video.avi 
```
  	
		

## Convertir un video .avi a .mpg para grabar un VCD

```bash
ffmpeg  -i  video.avi  -target  vcd  video.mpg 
```

	
## Implementar un chat para dos en consola

```bash
# Servidor?
netcat  -l  -p  puerto
	
# Cliente?
netcat  ip-servidor  puerto
```
	
## Pasar varios .WMA a .MP3

```bash 
# Convertir WMA a WAV 
for i in *wma; do mplayer "$i" -ao pcm:file="`echo $i | sed s/wma/wav/g`"; done

# Convertir WAV a MP3 con Autor, Album y Titulo
for i in *wav; do lame "$i" --ta "Autor" --tl "Album" --tt "`echo $i | sed s/\.wav//g`"; done
``` 
	
## Recuperar gestor de arranque GRUB

Supongamos que acabamos de instalar Windows, y obviamente este se ha cargado a GRUB.
Si teniamos la partición linux en /dev/hda2 arrancamos con un CD de linux y escribimos en consola:

```
grub
root (hd0,1)
setup (hd0)
quit</b>
``` 

## Sincronizar archivos entre dos carpetas

Supongamos que tenemos un directorio fuente con archivos más actualizados que el directorio destino.

```bash
rsync  -ravnz  fuente/  destino --del        # Vemos archivos a actualizar
rsync  -ravuz  fuente/  destino --del        # Actualizamos
```

``` 
NOTA: Poner / al final de fuente. 
-n            ver cambios a realizar
-u            actualiza
-h (human)    muestra información de forma más legible
--del         si deseamos borrar en destino archivos borrados en la fuente.
--progress    para ver el progreso
``` 
	
## Copiar y pegar con VIM (v, y, p)

Poner el cursor al inicio o final de bloque y pulsar v (visual). Ir al otro extremo y pulsar y. 
Ir a donde queremos pegar. Pulsar p.

 	 	 	 	 	 	 	 	 	 	 	
