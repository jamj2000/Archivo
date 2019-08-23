# Formas sencillas de implementar un servidor HTTP


## Con Node.js

Es la forma que más me gusta, es simple y visualmente atractiva.

```console
sudo  npm  -g  install  http-server
http-server
```

## Con Python

Es parecida a la anterior, pero visualmente más simple.

```console
python  -m  SimpleHTTPServer
```

## Con PHP

No crea indice de archivos de la carpeta. Es necesario que exista un index.php o index.html dentro de ella.

```console
php  -S  localhost:8000
```

## En un proyecto PHP Laravel

```console
php  artisan  serve
```
