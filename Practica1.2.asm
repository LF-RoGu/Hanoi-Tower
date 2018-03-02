#autor: Fernanda Muñoz
#	Luis Fernando Rguez
#fecha: 25/02/2018
#clase: Arquitectura de computadoras
#profesor: Jose Luis Pizano

#aun no funciona
.text

	addi $s0, $0, 3 			#guardo el registro de discos n
	addi $s1, $0, 0x10010000 		#guardo la torre origen
	addi $s2, $0, 0x10010020		#guardo la torre auxiliar
	addi $s3, $0, 0x10010040		#guardo la torre destino 
	add $t0, $t0, $s0 			# segunda opción creo un temporal para guardar el registro de discos y usarlo en la inicialización de torres

TORRES:						#Inicializo las torres
	sw $t0, ($s1) 				#guardo en s1 el temporal
	addi $t0, $t0, -1 			#le resto uno a los discos
	addi $s1, $s1, 4 			#le sumo 4 bytes a la direccion de la torre inicio
	bne $t0, $0, TORRES 			#si el temporal aun no esta vacio hago loop 
	jal HANOI				#si ya esta vacio jump and link hanoi
#	j EXIT					#cuando se ejecute todo lo de HANOI brinco a EXIT y termino.
check:
	bne $s0, $0, HANOI
init:
	bne $t0, $0, FindByte			#if t0!= 0 j FindByte
	addi $s1, $s1, -4			# mueve la direccion de memoria un byte
	addi $t0, $s1, 0
#	lw $t0, ($s1)				#carga el valor de init en una temporal
	sw $0, ($s1)				#borra el valor de init
	
dest:
	addi $s4, $s3, 0
#	lw $s4, ($s3)				#carga el valor de dest a una temp s4
	beq $s4, $0, aux
	addi $s3, $s3, 4			#siguiente byte
	j dest
aux:
	addi $t0, $s3, 0
#	sw $t0, ($s3)
	jr $ra					#sale de subrutina para regresar a dest, ya que este invoco aux			

FindByte:
	addi $s1, $s1, 4
	lw $t0, ($s1)
	bne $t0, $0, FindByte
	j init
	

HANOI:
#	beq $s0, 1, Else 			#si la torre 1 tiene 1 disco brinca a else

	#inicialización del stack (todo bien hasta aquí)
	addi $sp, $sp, -8 			#le quito espacio al stack para trabajar ahí
	sw $ra, 4($sp) 			#guardo espacio para la dirección del registro
	sw $s0, 0($sp) 			#guardo espacio para el registro de discos
	
	addi $s0, $s0, -1 			#le resto 1 a los discos
		#hago un swap de torres 
	add $t1, $s3, $0 			#guardo torre dest en temporal
	add $s3, $s2, $0			#guardo aux en dest
	add $s2, $t1, $0      			#guardo temporal en aux
	
	jal check               #mando llamar hanoi para que se vuelva a ejecutar
	
	lw $ra, 4($sp)
	lw $s0, 0($sp)
next:
	addi $t0, $s1, 0
#	lw $t0, ($s1)
	bne $t0, $0, T1
	addi $t0, $s1, 0
#	lw $t0, ($s1)
	sw $0, ($s1)
T1:
	addi $s1, $s1, -4
	addi $t0, $s1, 0
#	lw $t0, ($s1)
	bne $t0, $0, trackAgain
T2:
	addi $s4, $s3, 0
#	lw $s4, ($s3)
	beq $s4, $0, T3
	addi $s3, $s3, 4
	j T2
T3:
	addi $t0, $s3, 0
#	sw $t0, ($s3)		#guardar lo que este en t3 para un ultimo swap
	
	addi $s0, $s0, -1 			#le resto 1 a los discos
		#hago un swap de torres 
	add $t1, $s1, $0 			#guardo torre dest en temporal
	add $s1, $s2, $0			#guardo aux en dest
	add $s2, $t1, $0      			#guardo temporal en aux
	
	jal check               #mando llamar hanoi para que se vuelva a ejecutar
	
	lw $ra, 4($sp)
	
	beq $ra, $0, End
	
	jr $ra
	
	
	
trackAgain:
	addi $s1, $s1, 4
	addi $t0, $s1, 0
#	lw $t0, ($s1)
	bne $t0, $0, trackAgain
	j T1			
End:

HANOI:
#	beq $s0, 1, Else 			#si la torre 1 tiene 1 disco brinca a else

	#inicialización del stack (todo bien hasta aquí)
	addi $sp, $sp, -8 			#le quito espacio al stack para trabajar ahí
	sw $ra, 4($sp) 			#guardo espacio para la dirección del registro
	sw $s0, 0($sp) 			#guardo espacio para el registro de discos
	
	addi $s0, $s0, -1 			#le resto 1 a los discos
		#hago un swap de torres 
	add $t1, $s3, $0 			#guardo torre dest en temporal
	add $s3, $s2, $0			#guardo aux en dest
	add $s2, $t1, $0      			#guardo temporal en aux
	
	jal check               #mando llamar hanoi para que se vuelva a ejecutar
	
	lw $ra, 4($sp)
	lw $s0, 0($sp)
next:
	lw $t0, ($s1)
	bne $t0, $0, T1
	lw $t0, ($s1)
	sw $0, ($s1)
T1:
	addi $s1, $s1, -4
	lw $t0, ($s1)
	bne $t0, $0, trackAgain
T2:
	lw $s4, ($s3)
	beq $s4, $0, T3
	addi $s3, $s3, 4
	j T2
T3:
	sw $t0, ($s3)		#guardar lo que este en t3 para un ultimo swap
	
	addi $s0, $s0, -1 			#le resto 1 a los discos
		#hago un swap de torres 
	add $t1, $s1, $0 			#guardo torre dest en temporal
	add $s1, $s2, $0			#guardo aux en dest
	add $s2, $t1, $0      			#guardo temporal en aux
	
	jal check               #mando llamar hanoi para que se vuelva a ejecutar
	
	lw $ra, 4($sp)
	
	beq $ra, $0, End
	
	jr $ra
	
	
	
trackAgain:
	addi $s1, $s1, 4
	lw $t0, ($s1)
	bne $t0, $0, trackAgain
	j T1			
End:

	
	
