#autor: Fernanda Muñoz
#	Luis Fernando Rguez
#fecha: 25/02/2018
#clase: Arquitectura de computadoras
#profesor: Jose Luis Pizano

.text

	addi $s0, $0, 3 			#guardo el registro de discos n
	addi $s1, $0, 0x10010000 		#guardo la torre origen
	addi $s2, $0, 0x10010020		#guardo la torre auxiliar
	addi $s3, $0, 0x10010040		#guardo la torre destino 
	add $t0, $0, $s0 			# segunda opción creo un temporal para guardar el registro de discos y usarlo en la inicialización de torres

TORRES:						#Inicializo las torres
	sw $t0, ($s1) 				#guardo en s1 el temporal
	addi $t0, $t0, -1 			#le resto uno a los discos
	addi $s1, $s1, 4 			#le sumo 4 bytes a la direccion de la torre inicio
	bne $t0, $0, TORRES 			#si el temporal aun no esta vacio hago loop 
	jal HANOI				#si ya esta vacio jump and link hanoi
#	j EXIT					#cuando se ejecute todo lo de HANOI brinco a EXIT y termino.


HANOI:
	beq $s0, 1, Else 			#si la torre 1 tiene 1 disco brinca a else

	#inicialización del stack (todo bien hasta aquí)
	addi $sp, $sp, -8 			#le quito espacio al stack para trabajar ahí
	sw $ra, 4($sp) 			#guardo espacio para la dirección del registro
	sw $s0, 0($sp) 			#guardo espacio para el registro de discos
	
	addi $s0, $s0, -1 			#le resto 1 a los discos
		#hago un swap de torres 
	add $t1, $s3, $0 			#guardo torre dest en temporal
	add $s3, $s2, $0			#guardo aux en dest
	add $s2, $t1, $0      			#guardo temporal en aux
	
	jal HANOI               #mando llamar hanoi para que se vuelva a ejecutar
	
	lw $ra, 4($sp)
	lw $s0, 0($sp)
	
Else:
	lw $t0, ($s1) 		#carga el valor de init (T1) a la temporal
	bne $t0, $zero, init	
	addi $s1, $s1, -4			
	j Else
init:
	bne $t1,$0 ,trackByte
	addi $s1, $s1, -4
	lw $t1, ($s1)
	sw $0, ($s1)
	
trackByte:
	addi $s1, $s1, 4
	lw $v0, ($s1)
	bne $t1,$0 ,trackByte
	j init
Des:
	addi $s0, $s0, -1
	addi $t0, $s1, 0
	addi $s1, $s2, 0
	addi $s2, $t0, 0
	
	jal HANOI
	
	lw $ra, 0($sp)
	
	beq $ra, $0, End
	
	jr $ra
				
End:

	
	