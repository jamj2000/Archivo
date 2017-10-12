# Programación en C - Teoría

## Creación de una biblioteca estática

- Compilar: __gcc -c objeto1.c__
- Compilar: __gcc -c objeto2.c__
- Combinar: __ar cr libreria.a objeto1.o objeto2.o__

## Creación de una biblioteca dinámica

- Compilar: __gcc -c _-fPIC_ objeto1.c__
- Compilar: __gcc -c _-fPIC_ objeto2.c__ 
- Combinar: __gcc _-shared -fPIC_ -o libreria.so objeto1.o objeto2.o__

--- 

# Programación en C - Ejemplo

```c
// aritmetica.h
int suma (int sumando1, int sumando2);

int resta  (int minuendo, int sustraendo);

int multiplicacion (int  numero1, int numero2);

float division (int dividendo, int divisor);
```

```c
// aritmetica.c
int suma (int sumando1, int sumando2) {
  return (sumando1+sumando2);
}

int resta  (int minuendo, int sustraendo) {
  return (minuendo-sustraendo);
}

int multiplicacion (int  numero1, int numero2) {
  return (numero1*numero2);
}

float division (int dividendo, int divisor) {
  return (dividendo/divisor);
}
```

```c
// main.c
#include <stdio.h>
#include "aritmetica.h"

#define NUM1    5
#define NUM2    2


int main (){
  printf ("Dados los números %d y %d\n", NUM1, NUM2);
  printf ("La suma es %d\n", suma (NUM1, NUM2));
  printf ("La resta es %d\n", resta (NUM1, NUM2));
  printf ("La multiplicación es %d\n", multiplicacion (NUM1, NUM2));
  printf ("La división es %f\n", division (NUM1, NUM2));
  return 0;
}
```

```c
// plug.c
#include <dlfcn.h>
#include <stdio.h>

#define NUM1    5
#define NUM2    2


int main (){
  void *h = dlopen("./libaritmetica.so", RTLD_LAZY);
  printf ("Dados los números %d y %d\n", NUM1, NUM2);

  int (*test)() = dlsym (h, "suma");
  printf ("La suma es %d\n", (*test)(NUM1, NUM2));

  test = dlsym (h, "resta");
  printf ("La resta es %d\n", (*test)(NUM1, NUM2));

  test = dlsym (h, "multiplicacion");
  printf ("La multiplicación es %d\n", (*test)(NUM1, NUM2));

  float (*test2)() = dlsym (h, "division");
  printf ("La división es %f\n", (*test2)(NUM1, NUM2));
  
  return 0;
}
```

# Crear biblioteca estática

gcc -c aritmetica.c
ar cr __libaritmetica.a__ aritmetica.o 


# Crear biblioteca dinámica

gcc -c -fPIC aritmetica.c
gcc -shared -fPIC -o __libaritmetica.so__ aritmetica.o


# Utilizar biblioteca dinámica como plugin

gcc -o __plug__ plug.c  __-ldl__
./plug


# Crear ejecutable con enlace estático

gcc -o __main__  main.c libaritmetica.a 
ldd main


# Crear ejecutable con enlace dinámico

gcc -o __main__  main.c libaritmetica.so 
ldd main

> Para el correcto funcionamiento deberemos copiar libaritmetica.so  a /lib
> `cp libaritmetica.so  /lib`


# Distribución de binario junto a biblioteca en la misma carpeta

gcc -L. -Wl,-rpath=. -Wall -o __main__ main.c -laritmetica
ldd main


# Distribución de binario junto a biblioteca en una subcarpeta

mkdir libs
mv libaritmetica.so libs
gcc -L./libs -Wl,-rpath=libs -Wall -o __main__ main.c -laritmetica
ldd main

--- 


# Programación en ensamblador (nasm)

## Enlazar con biblioteca en ensamblador

- __nasm -f elf64 -o archivo.o archivo.asm__ 
- __ar cr libarchivo.a archivo.o__ 
- __gcc -o programa programa.c -larchivo -L./__ 


## Crear programa en ensamblador

- __nasm -f elf64 archivo.asm__ 
- __ld -s -o archivo archivo.o__  	 	 	
