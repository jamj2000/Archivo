# Programación

	<h4> Creación de una biblioteca estática</h4>
	<ul>
	<li> Compilar: <strong> gcc -c objeto1.c </strong></li>
	<li> Compilar: <strong> gcc -c objeto2.c </strong></li>
	<li> Combinar: <strong> ar cr libreria.a objeto1.o objeto2.o </strong></li>
	</ul>
	<h4> Creación de una biblioteca dinámica </H4>
	<ul>
	<li> Compilar: <strong> gcc -c <em>-fPIC</em> objeto1.c </strong></li>
	<li> Compilar: <strong> gcc -c <em>-fPIC</em> objeto2.c </strong></li>
	<li> Combinar: <strong> gcc <em>-shared -fPIC</em> -o libreria.so objeto1.o objeto2.o </strong></li>
	</ul>
	<h4> Enlazar con biblioteca en ensamblador </h4>
	<ul>
	<li> <strong> nasm -f elf -o archivo.o archivo.asm </strong></li>
	<li> <strong> ar cr libarchivo.a archivo.o </strong></li>
	<li> <strong> gcc -o programa programa.c -larchivo -L./</strong></li>
	</ul>
	<h4> Crear programa en ensamblador </h4>
	<ul>
	<li> <strong> nasm -f elf archivo.asm </strong></li>
	<li> <strong> ld -s -o archivo archivo.o</strong></li>
	</ul>
 	 	 	
