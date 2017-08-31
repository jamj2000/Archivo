;----------------------------------------------------------------------------------------------------------------
;                            PROGRAMA DE ARRANQUE DEL DISCO DURO           
;                               SITUADO EN EL PRIMER SECTOR
;
;     A grandes rasgos el programa realiza las siguientes acciones  
;         
;  1. Se mueve a si mismo a otra zona de memoria
;  2. Averigua que partición está activa
;  3. Carga el sector de arranque de esa partición y le cede el procesador
;
;                                                                                  (c) José Antonio Muñoz Jiménez
;                                                                                                    8-JULIO-1999
;----------------------------------------------------------------------------------------------------------------


PROGRAMA SEGMENT
         ASSUME CS:PROGRAMA, DS:PROGRAMA, ES:PROGRAMA, SS:PROGRAMA



; Este programa es cargado por la BIOS en la posición de memoria 0000:7C00 y ejecutado desde ahí

; Se establece la dirección de la pila a SS:SP = 0000:7C00
	CLI
	MOV 	AX, 0000H
	MOV 	SS, AX
	MOV 	SP, 7C00H
	STI

	CLD

; Se establece la dirección de origen a DS:SI = 0000:7C00
	MOV 	DS, AX
	MOV 	SI, SP

; Se establece la dirección de destino a ES:DI = 0000:0600
	MOV 	ES, AX
	MOV 	DI, 0600H

; mueve 512 bytes de dirección origen a dirección destino,
; es decir, mueve este mismo programa a la dirección 0000:0600
; esto es necesario pues el sector de arranque del sistema operativo
; deberá cargarse posteriormente en 0000:7C00
	MOV 	CX, 0100H
	REPZ 	MOVSW

; empieza a ejecutarse la siguiente instrucción
; esta vez en 0000:061E que equivale a 0000:7C1E
	DB 	0EAH                        ; JMP
        DD 	0000061EH                   ; 0000:061E   
; MASM no admite una instrucción de salto fuera del segmento actual
; por eso escribimos el código binario correspondiente 


; se comprueba si la primera partición está activa (es arrancable)
; si lo es se procede a Cargar_sector_de_arranque
; sino comprueba si está inactiva
; sino está activa ni inactiva se muestra el mensaje de error
; (Tabla de Partición Inválida) y se ejecuta un bucle infinito
; si está inactiva vuelve a realizar los mismos pasos anteriores
; para las otras tres entradas de partición
; en el caso de que ninguna de ellas esté activa da el mensaje de
; error (No hay Partición Activa) y llama al programa ROM-BASIC
	MOV 	BP, OFFSET Autor+600H                ; Firma
	CALL 	Rutina_Tratamiento_de_Errores        ; añadida

	MOV	DI, 07BEH                   ; dirección en memoria de entradas de partición
			                    ; 07BE, 07CE, 07DE, 07EE

Comprueba_si_activa:
	CMP	BYTE PTR[DI], 80H           ; 80H : Partición activa
	JZ	Cargar_sector_de_arranque

Comprueba_si_inactiva:
	CMP	BYTE PTR[DI], 00H           ; 00H: Partición inactiva
	JNZ	Error_1
	CMP	DI, 07EEH
	JZ	Error_4
	ADD	DI, +10H                    ; siguiente entrada
	JMP	Comprueba_si_activa

; Tabla de Partición Inválida
Error_1:
	MOV 	BP, OFFSET Mensaje1+600H  	
Llamada_a_rutina:
	CALL	Rutina_Tratamiento_de_Errores
Bucle_infinito:
	JMP 	Bucle_infinito

; No hay Partición Activa
Error_4:
	MOV 	BP, OFFSET Mensaje4+600H
	CALL	Rutina_Tratamiento_de_Errores
	INT 	18H

; se establece la cantidad de veces (16) que se leerá el sector de arranque
Cargar_sector_de_arranque:
	MOV  	SI, 0010H
; se establece ES:BX a 0000:7C00
Repetir_intento:
	XOR	AX, AX
	MOV	ES, AX
	MOV	BX, 7C00H
; se lee sector del disco duro (DI=1BE o 1CE o 1DE o 1EE)
	MOV 	AX, 0201H
	MOV	CX, [DI+02]                 ; Número de cilindro y sector
	MOV 	DX, [DI]                    ; Número de unidad y cabeza
	PUSH	SI
	INT	13H
	POP	SI
	JNB	Ver_si_es_ejecutable
; reset de la controladora de disco después de error de lectura
	XOR	AX, AX
	INT	13H
; decrementa el índice y vuelve a probar
; en caso de que el índice llegue a 0 da el mensaje de error
; (Error de Disco al Leer SO)
	DEC 	SI
	JNZ	Repetir_intento

; Error de Disco al Leer SO
Error_2:
	MOV 	BP, OFFSET Mensaje2+0600H
	JMP	Llamada_a_rutina

; si todo ha ido bien comprueba si el sector leido es ejecutable
Ver_si_es_ejecutable:
	MOV	SI, DI
	MOV	DI, 7DFEH
	CMP	WORD PTR[DI], 0AA55H        ; marca final de sector ejecutable	
; sino lo es da el mensaje de error (No hay Sistema Operativo)
; si lo es empieza a ejecutar directamente en 0000:7C000
	JNZ	Error_3
	DB	0EAH                        ; JMP
	DD	00007C00H                   ; 0000:7C00

; No hay Sistema Operativo
Error_3:
	MOV	BP, OFFSET Mensaje3+600H
	JMP	Llamada a rutina
	

;##########################################
Imprime_Caracter PROC
	CMP	AL, 0AH
	JZ	imprime_caracter_especial
	CMP	AL, 0DH
	JZ	imprime_caracter_especial
	MOV	AH, 09
	PUSH	AX
	MOV 	AL, 20H
	INT	10H
	POP	AX
imprime_caracter_especial:
	MOV	AH, 0EH
otro_caracter:
	INT	10H
	LOOP	otro_caracter
	RET
Imprime_Caracter ENDP
;##########################################




;##########################################
Rutina_Tratamiento_de_Errores PROC
	PUSH	AX
	PUSH	BX
	PUSH	CX
	PUSH	SI
	MOV	SI, BP
	MOV	BH, 00                      ; página
	MOV	BL, BYTE PTR Color+600H     ; color
leer_caracter:
	LODSB
	OR	AL, AL                      ; si carácter leido es nulo
	JZ	fin_rutina                  ; termina imprimir cadena
	MOV	CX, 0001                    ; número de repeticiones
	CALL 	Imprime_Caracter
	JMP	leer_caracter
fin_rutina:
	POP	SI
	POP	CX
	POP	BX
	POP	AX
	RET
Rutina_Tratamiento_de_Errores ENDP
;##########################################




;############## DATOS #####################
Color		DB	158                 ; Fondo azul, letras amarillas e intermitentes
Mensaje1	DB	13,10, 'Tabla de Partición Inválida', 0
Mensaje2	DB	13,10, 'Error de Disco al Leer SO',   0
Mensaje3	DB	13,10, 'No hay Sistema Operativo',    0
Mensaje4	DB	13,10, 'No hay Partición Activa',     0
Autor 		DB	13,10, '    # Primer sector de disco modificado por JAMJ -- 8/JULIO/1999 #    ', 13,10,0
;##########################################




; A continuación vienen las cuatro entradas de la tabla de particiones
; cada entrada son 16 bytes

; Para calcular el tamaño absoluto desde el inicio de disco se aplica 
; esta fórmula:    Tamaño = (Cabeza_fin+1) * (Cilindro_fin+1) * Sector_fin
;
; En el caso de que Sector_fin sea menor de 63 se deberá restar al valor
; de Tamaño obtenido los sectores que faltan hasta 63.
;
; Rango de valores:
;	CABEZAS  : 0 ..  255
;	CILINDROS: 0 .. 1023
;	SECTORES : 1 ..   63
;
; Cuando se toman valores lineales el número de cilindros puede pasar de 1023,
; por ejemplo en la segunda entrada donde pone que el cilindro final es igual a 20
; es porque ya se ha dado una vuelta al "marcardor" de cilindro, por tanto 
; el valor real sería 1024 cilindros de antes más 20 de ahora, 1044.
;
; ¡ Los cilindros siempre se llenan de menos a más !
; ####### TABLA DE PARTICIONES ############
ORG	1BEH

;; Primera entrada
;             CABEZA    CILINDRO      SECTOR	
; Inicio           1           0           1    
; Fin            254         255          63
; Sector lineal inicio :                  63
; Tamaño               :           4.112.577  sectores de 512 bytes
_1_Estado                        DB 80H        ; Unidad activa   
_1_Cabeza_comienzo               DB 01H        ; cabeza=1
_1_Cilindro_y_sector_comienzo    DW 0001H      ; cilindro=0, sector=1
_1_Tipo_particion                DB 0EH
_1_Cabeza_final                  DB 0FEH       ; cabeza=254
_1_Cilindro_y_sector_final       DW 0FFEFH     ; cilindro=255, sector=63
_1_Distancia_a_particion         DD 0000003FH  ;         63 sectores	  
_1_Tamano_de_particion           DD 003EC0C1H  ;  4.112.577 sectores 

  
;; Segunda entrada
;             CABEZA    CILINDRO      SECTOR	
; Inicio           0         256           1    
; Fin            254          20          63
; Sector lineal inicio :           4.112.640
; Tamaño               :          12.675.285 sectores de 512 bytes
_2_Estado                        DB 00  
_2_Cabeza_comienzo               DB 00         ; cabeza=0
_2_Cilindro_y_sector_comienzo    DW 0041H      ; cilindro=256, sector=1
_2_Tipo_particion                DB 0FH
_2_Cabeza_final                  DB 0FEH       ; cabeza=254
_2_Cilindro_y_sector_final       DW 143FH      ; cilindro=20, sector=63
_2_Distancia_a_particion         DD 003EC100H  ;  4.112.640 sectores 
_2_Tamano_de_particion           DD 00C168D5H  ; 12.675.285 sectores 


;; Tercera entrada
_3_Estado                        DB 00  
_3_Cabeza_comienzo               DB 00
_3_Cilindro_y_sector_comienzo    DW 0000
_3_Tipo_particion                DB 00
_3_Cabeza_final                  DB 00
_3_Cilindro_y_sector_final       DW 0000
_3_Distancia_a_particion         DD 00000000   ; en sectores   
_3_Tamano_de_particion           DD 00000000   ; en sectores


;; Cuarta entrada
_4_Estado                        DB 00  
_4_Cabeza_comienzo               DB 00
_4_Cilindro_y_sector_comienzo    DW 0000
_4_Tipo_particion                DB 00
_4_Cabeza_final                  DB 00
_4_Cilindro_y_sector_final       DW 0000
_4_Distancia_a_particion         DD 00000000   ; en sectores   
_4_Tamano_de_particion           DD 00000000   ; en sectores
; #########################################
DW	0AA55H                              ; significa que este sector es ejecutable
                                            ; al encender el ordenador la BIOS lee esta signatura
                                            ; si existe ejecuta el código que hemos visto

PROGRAMA ENDS
END




;----------------------------------------------------------------------------------------------------------------
;        INTERRUPCIONES DE LA BIOS UTILIZADAS
;
; (Imprime todo tipo de caracteres sin mover cursor)
; INT 10
;     AH= 09  
;     AL= Código de carácter
;     CX= Factor de repetición (en este caso 1)
;     BL= Atributo de color
;
;
; 
; (Imprime caracteres normales e interpreta los especiales; mueve el cursor)
; INT 10
;     AH= 0E
;     AL= Código de carácter
;
;
;
; (Leer sectores de disco)
; INT 13
;     AH= 02
;     AL= Número de sectores a leer (en este caso 1)
;     DH= Número de cabeza
;     DL= Unidad (80H(1er disco) o 81H(2o disco) -- en este caso 80H)  
;     CH= Número de cilindro
;     CL= Número de sector
;     ES:BX= Buffer en memoria donde se guardará el sector
; Esta interrupción pone el CF (Carry Flag - Señalizador de acarreo) a 1
; si no ha podido leerse el sector
;
;
;
; (Reset de la controladora de disco)
; INT 13
;     AX= 00
;     DL= Unidad (80H(1er disco) o 81H(2o disco) -- en este caso 80H)  
;
;
;
; (Cargar el interprete de BASIC que posee la ROM   )
; (En caso de no existir se mostrará un mensaje como)
; (  "NO ROM BASIC"                                 ) 
; (  "SYSTEM HALTED"                                ) 
; INT 18
;
;
;----------------------------------------------------------------------------------------------------------------