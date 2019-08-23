# Formas sencillas de implementar un servidor HTTP


## Con Node.js

Es la forma que más me gusta, es simple y visualmente atractiva.

```bash
sudo  npm  -g  install  http-server
http-server
```

## Con Python

Es parecida a la anterior, pero visualmente más simple.

```bash
python  -m  SimpleHTTPServer
```

## Con PHP

No crea indice de archivos de la carpeta. Es necesario que exista un index.php o index.html dentro de ella.

```bash
php  -S  localhost:8000
```

## En un proyecto PHP Laravel

```bash
php  artisan  serve
```
