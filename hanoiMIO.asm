#autores: Fernanda Muñoz y luis Fernando 
#20/02/2018 - 25/02/2018

     						#NO FUNCIONA AUN 
  
  
.text
 
 	addi $s0, $0, 8 	 	#numero de discos
 	addi $s1, $0, 0x10010000 	#torre origen
 	addi $s2, $0, 0x10010020 	#torre auxiliar 
 	addi $s3, $0, 0x10010040 	#torre destino
 	
 
 #inicialización
 TORRES:
 
 	beq $s0,$0, HANOI 		#BRINCAR A HANOI SI YA ESTAN TODOS LOS DISCOS EN LA PRIMERA TORRE Y YA NO EN EL REGISTRO
 	sw $s0, ($s1)			# PONE LOS DISCOS DE N(que estan en el registro s0) EN LA TORRE ORIGEN s1 ((LOS PONE 1 A 1?)
	sub $s0, $s0, 1			# LE RESTA 1 AL REGISTRO DONDE ESÁN LOS DISCOS
	addi $s1, $s1, 4		# LE SUMA 4 A LA TORRE ORIGEN (DIRECCION DE MEMORIA) PARA HACER ESPACIO PARA EL SIGUIENTE DISCO.
	j TORRES			#CREA RECURSIVIDAD 
	j EXIT				#CUANDO SE CUMPLE TODO LO SIGUIENTE, SALE DEL PROGRAMA
 
 
 HANOI:
 
 	bne $s0, 1, ELSE		# INICIO DE RECURSUVIDAD/ si n es diferente de 1 saltar al else  
 	lw $t2, -4($s1) 		#guardar en temporal el disco de ariba que esta en n
	sw $0, -4($s1)			#borrar el disco guardado antes del registro n
		
	sw $t2, 0($s3) 			#mover el disco guardado en el temporal 2 a la torre destino
	addi $s3, $s3, 4 		#agrego un byte para pasar a la siguiente dirección de memoria en torre destino
	addi $s1, $s1, -4		#le quito un byte para acceder al siguiente disco.
	
	jr $ra				#salta a la dirección que estaba guardada en ra y sigue ejecutando 
 	
 	
 ELSE:
 

	lw $t0, ($s1)			# carga en un temporal el valor de la torre de inicio
 	addi $sp, $sp, -20 		#se le quita espacio al stack para poder trabajar ahí
	sw $ra, 20($sp) 		#guardamos 1 byte de espacio para ra en el stack
	sw $s0, 16($sp) 		#guardamos 1 byte de espacio para los discos en el stack
	sw $s1, 8($sp) 			#guardamos 1 byte de espacio para la torre origen en el stack
	sw $s2, 4($sp) 			#guardamos 1 byte de espacio para la torre auxiliar en el stack
	sw $s3, 0($sp) 			#guardamos 1 byte de espacio para la torre destino en el stack
	addi $s0, $s0, -1 		#le restamos 1 disco a la pila de n

 	
 	
 	add $t1, $s2, $0 		#para no perder el valor lo guardo en un temporal.
	add $s2, $s3, $0		#intercambio valores de torre auxiliar con torre destino
	add $s3, $t1, $0
	
	jal HANOI 			#jump and link a HANOI/ recursividad 

	add $t1, $s2, $0 		#repito proceso anterior
	add $s2, $s3, $0		
	add $s3, $t1, $0
	
	lw $t2, -4($s1) 		#le carga al temporal 2 el disco de arriba de la torre auziliar 
	sw $0, -4($s1) 			#borra el disco de arriba que cargamos en el temporal
	sw $t2, 0($s3) 			#guardamos el disco que estaba en el temporal en la torre destino
	addi $s3, $s3, 4 		#se cambia el apuntador del disco (se mueve un byte)
	addi $s1, $s1, -4		#se borra un disco de la torre origen.
	
	add $t1, $s2, $0		#guardo s2 en un temporal 
	add $s2, $s1, $0		#guardo en s2 lo que hay en s1
	add $s1, $t1, $0		#guardo en s1 el temporal donde guarde s2 (switcheo)

	jal HANOI
	
					#recupero entorno 
	add $t1, $s2, $0		#guardo s2 en el temporal 
	add $s2, $s1, $0		#guardo en s2 lo que esta en s1
	add $s1, $t1, $0		#guardo en s1 lo que esta en el temporal
	
	lw $ra, 20($sp) 		#carga lo que esta en el stack a ra (en la dirección con 4 bytes)
	lw $s0, 16($sp) 		#carga lo que esta en el stack al registo s0  (en la direccion con 0)
	lw $s1, 12($sp) 		#carga lo que esta en el stack al registro s1 (en la direccion con 0)
	lw $s2, 8($sp) 			#carga lo que esta en el stack al registro s2 (en la direccion con 0)
	lw $s3, 0($sp) 			#carga lo que esta en el stack al registro s3    (en la direccion con 0)
	addi $sp, $sp, 20		#libera la memoria del stack que utilizamos  	

	jr $ra
 
 EXIT: 
