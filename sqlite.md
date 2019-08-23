# Trabajar con SQLite

## Introducción

SQLite es un motor de bases de datos relacional. 

Lo que hace a SQLite interesante frente a otros SGBDR es la opción de integrar el almacenamiento local/cliente en el software de aplicación.
La biblioteca SQLite se vincula y, por lo tanto, se convierte en una parte integral del programa de aplicación.

Debido a su pequeño tamaño, SQLite es muy adecuado para los sistemas integrados.

SQLite almacena la base de datos completa (definiciones, tablas, índices y los datos en sí) como un único archivo multiplataforma en una máquina host.
Existen dos programas independientes para consultar y gestionar los ficheros de base de datos SQLite. En Ubuntu pueden instalarse con:

```console
sudo  apt  install  sqlite3  sqlitebrowser
```
El primero es CLI y el segundo GUI.


## Instalación 

SQLite tiene enlaces a muchos lenguajes de programación. Por ejemplo, para PHP y Nodejs: 

```console
 sudo  apt  install  php-sqlite3
 sudo  apt  install  node-sqlite3
  ```
 
 Opcionalmente, podemos instalar las utilidades para el manejo de archivos sqlite y la biblioteca de desarrollo.
 
 ```console
  sudo  apt  install  sqlite3  sqlitebrowser  libsqlite3-dev 
 ```
 
 ## Referencias

- [Sitio web oficial](https://www.sqlite.org)
- [Wikipedia en inglés acerca de SQLite](https://en.wikipedia.org/wiki/SQLite)
