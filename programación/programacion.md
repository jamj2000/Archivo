# Programación

## Creación de una biblioteca estática

- Compilar: __gcc -c objeto1.c__
- Compilar: __gcc -c objeto2.c__
- Combinar: __ar cr libreria.a objeto1.o objeto2.o__

## Creación de una biblioteca dinámica

- Compilar: __gcc -c _-fPIC_ objeto1.c__
- Compilar: __gcc -c _-fPIC_ objeto2.c__ 
- Combinar: __gcc _-shared -fPIC_ -o libreria.so objeto1.o objeto2.o__


## Enlazar con biblioteca en ensamblador

- __nasm -f elf -o archivo.o archivo.asm__ 
- __ar cr libarchivo.a archivo.o__ 
- __gcc -o programa programa.c -larchivo -L./__ 


## Crear programa en ensamblador

- __nasm -f elf archivo.asm__ 
- __ld -s -o archivo archivo.o__  	 	 	
