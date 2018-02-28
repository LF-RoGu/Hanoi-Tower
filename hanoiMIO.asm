
.text

	addi $s0, $0, 8 			#guardo el registro de discos n
	addi $s1, $0, 0x10010000 		#guardo la torre origen
	addi $s2, $0, 0x10010020		#guardo la torre auxiliar
	addi $s3, $0, 0x10010040		#guardo la torre destino 
	add $t0, $0, $s0 			# segunda opción creo un temporal para guardar el registro de discos y usarlo en la inicialización de torres

TORRES:						#Inicializo las torres
	sw $t0, 0($s1) 				#guardo en s1 el temporal
	addi $t0, $t0, -1 			#le resto uno a los discos
	addi $s1, $s1, 4 			#le sumo 4 bytes a la direccion de la torre inicio
	bne $t0, $0, TORRES 			#si el temporal aun no esta vacio hago loop 
	jal HANOI				#si ya esta vacio jump and link hanoi
	j EXIT					#cuando se ejecute todo lo de HANOI brinco a EXIT y termino
	
	#no funciona con esta manera, llena las torres cuando quiere 
	
 	#beq $s0,$0, HANOI 		#BRINCAR A HANOI SI YA ESTAN TODOS LOS DISCOS EN LA PRIMERA TORRE Y YA NO EN EL REGISTRO
 	#sw $s0, ($s1)			# PONE LOS DISCOS DE N(que estan en el registro s0) EN LA TORRE ORIGEN s1 ((LOS PONE 1 A 1?)
	#sub $s0, $s0, 1		# LE RESTA 1 AL REGISTRO DONDE ESÁN LOS DISCOS
	#addi $s1, $s1, 4		# LE SUMA 4 A LA TORRE ORIGEN (DIRECCION DE MEMORIA) PARA HACER ESPACIO PARA EL SIGUIENTE DISCO.
	#j TORRES			#CREA RECURSIVIDAD 
	#j EXIT				#CUANDO SE CUMPLE TODO LO SIGUIENTE, SALE DEL PROGRAMA
 

HANOI:
	beq $s0, 1, ELSE 			#si la torre 1 tiene 1 disco brinca a else

	#inicialización del stack (todo bien hasta aquí)
	addi $sp, $sp, -20 			#le quito espacio al stack para trabajar ahí
	sw $ra, 16($sp) 			#guardo espacio para la dirección del registro
	sw $s0, 12($sp) 			#guardo espacio para el registro de discos
	sw $s1, 8($sp)				#guardo espacio para la torre origen
	sw $s2, 4($sp)				#guardo espacio para la torre auxiliar
	sw $s3, 0($sp)				#guardo espacio para la torre destino
	
	addi $s0, $s0, -1 			#le resto 1 a los discos

	#hago un swap de torres 
	add $t1, $s2, $0 			#guardo torre auxiliar en temporal
	add $s2, $s3, $0			#guardo destino en auxiliar
	add $s3, $t1, $0      #guardo temporal en destino

jal HANOI               #mando llamar hanoi para que se vuelva a ejecutar



	#PROFESOR: EN ESTA PARTE QUIERO RECUPER EL ENTORNO CARGANDO LOS REGISTROS QUE GUARDE EN EL STACK! PERO ES 
	#	   EN ESTA PARTE DONDE SE ROMPE

#recupero el entorno en el que estaba trabajando
	lw $s3, 0($sp)        #cargo los registros guardados en el stack
	lw $s2, 4($sp)        
	lw $s1, 8($sp)
	lw $s0, 12($sp)
	lw $ra, 16($sp)
	addi $sp, $sp, 20     #le regreso al stack el espacio que le quite



#aquí se rompe en la primera línea
	lw $t2, -4($s1)       #le carga al temporal 2 el disco de arriba de la torre auziliar 
	sw $0, -4($s1)        #borra el disco de arriba que cargamos en el temporal
	sw $t2, 0($s3)        ##guardamos el disco que estaba en el temporal en la torre destino
	addi $s3, $s3, 4      ##se cambia el apuntador del disco (se mueve un byte)
	addi $s1, $s1, -4     #se borra un disco de la torre origen.
	
  
  #swap pero ahora torre detino con origen
	add $t3, $s3, $0
	add $s3, $s1, $0
	add $s1, $t3, $0


jal HANOI

		#CLARAMENTE ESTA PARTE NO LLEGA PERO ES IGUAL A LA PASADA ENTONCES SUPONGO QUE TAMBIEN SE ROMPERÍA
	#vuelvo a recuperar el entorno
	lw $s3, 0($sp)
	lw $s2, 4($sp)
	lw $s1, 8($sp)
	lw $s0, 12($sp) 
	lw $ra, 16($sp) 
	addi $sp, $sp, 20 

	jr $ra	



ELSE:

	lw $t2, -4($s1) 
	sw $0, -4($s1)
	
	sw $t2, 0($s3) 
	addi $s3, $s3, 4 
	addi $s1, $s1, -4
	jr $ra

EXIT:

