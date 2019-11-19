# Trucos (para terminal de Linux)


## Como conectar a una red wifi desde el terminal

```bash
nmcli device wifi connect SSID-Name password wireless-password
```

## Como cambiar un texto en todos los archivos jsp

```bash
sed  -i  's/foo/bar/g'  *.jsp
```

## Como extraer texto de un archivo

```bash   
        cat  archivo | grep -o iniciotexto.*finaltexto
```


## Como ver PDF o PS en maquinas con poquisimos recursos (mejor que xpdf) 

```bash
        # Lanzar desde consola en X-Window
	gs -r120 -g1200x1600 archivo.pdf      
``` 

``` 
       -r: Puntos Por Pulgada
       -g: Tamaño en pixeles
``` 

Para mover pagina por la pantalla, mantener tecla ALT pulsada y mover con el raton.


## Como unir varios archivos PDF en uno solo

```bash
	gs -sDEVICE=pdfwrite -sOutputFile=archivo-final.pdf \
	   -dNOPAUSE  -dBATCH \  
	   archivo1.pdf archivo2.pdf archivo3.pdf 
``` 

## Como grabar desde consola una ISO de forma sencilla

```bash
        # Con emulacion SCSI
	cdrecord  dev=0,1,0  driveropts=burnfree  NombreImagen.iso
       
	# Sin emulacion SCSI
        cdrecord  dev=/dev/hdd  driveropts=burnfree  NombreImagen.iso
```

## Como cambiar codificación de ISO-8859-1 a UTF-8</h2>

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
  	
		

## Como convertir un video .avi a .mpg para grabar un VCD

```bash
	ffmpeg  -i  video.avi  -target  vcd  video.mpg 
```

	
## Como implementar un chat para dos en consola

```bash
	# Servidor?
	netcat  -l  -p  puerto
	
        # Cliente?
	netcat  ip-servidor  puerto
```
	
## Como pasar varios .WMA a .MP3

```bash 
	# Convertir WMA a WAV 
	for i in *wma; do mplayer "$i" -ao pcm:file="`echo $i | sed s/wma/wav/g`"; done

	# Convertir WAV a MP3 con Autor, Album y Titulo
	for i in *wav; do lame "$i" --ta "Autor" --tl "Album" --tt "`echo $i | sed s/\.wav//g`"; done
``` 
	
## Como recuperar gestor de arranque GRUB

Supongamos que acabamos de instalar Windows, y obviamente este se ha cargado a GRUB.
Si teniamos la partición linux en /dev/hda2 arrancamos con un CD de linux y escribimos en consola:

```
	grub
	root (hd0,1)
	setup (hd0)
	quit</b>
``` 

## Como sincronizar archivos entre dos carpetas

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

 	 	 	 	 	 	 	 	 	 	 	
