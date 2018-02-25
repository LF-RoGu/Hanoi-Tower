
 TORRES:
 
 	beq $s0,$0, HANOI 		#BRINCAR A HANOI SI YA ESTAN TODOS LOS DISCOS EN LA PRIMERA TORRE Y YA NO EN EL REGISTRO
 	sw $s0, ($s1)			# PONE LOS DISCOS DE N(que estan en el registro s0) EN LA TORRE ORIGEN s1 ((LOS PONE 1 A 1?)
	sub $s0, $s0, 1			# LE RESTA 1 AL REGISTRO DONDE ESÁN LOS DISCOS
	addi $s1, $s1, 4		# LE SUMA 4 A LA TORRE ORIGEN (DIRECCION DE MEMORIA) PARA HACER ESPACIO PARA EL SIGUIENTE DISCO.
	j TORRES			#CREA RECURSIVIDAD 
	j EXIT				#CUANDO SE CUMPLE TODO LO SIGUIENTE, SALE DEL PROGRAMA
 
 HANOI:
 
 	bne $s0, 1, ELSE		# INICIO DE RECURSUVIDAD/ si n es diferente de 1 saltar al else  
 	lw $t2, -4($s1) 	
	sw $0, -4($s1)		
	
	sw $t2, 0($s3) 		
	addi $s3, $s3, 4 	
	addi $s1, $s1, -4
	
	jr $ra
 	
 	
 ELSE:
 
 
 
	lw $t0, ($s1)			# carga en un temporal el valor de la torre de inicio
 	addi $sp, $sp, -8 		#se le quita espacio al stack para poder trabajar ahí
	sw $ra, 4($sp) 			#guardamos espacio para ra en el stack
	sw $s0, 0($sp) 			#guardamos espacio para los discos en el stack
	addi $s0, $s0, -1 		#le restamos 1 disco a la pila de s0

 	
 	
 	add $t1, $s2, $0 		#para no perder el valor lo guardo en un temporal.
	add $s2, $s3, $0		#intercambio valores de torre auxiliar con torre destino
	add $s3, $t1, $0
	
	jal HANOI 			#llamamos a HANOI/ recursividad 

	add $t1, $s2, $0 		#repito proceso anterior
	add $s2, $s3, $0
	add $s3, $t1, $0
	
	lw $t2, -4($s1) 		
	sw $0, -4($s1) 			
	sw $t2, 0($s3) 			
	addi $s3, $s3, 4 		
	addi $s1, $s1, -4
	
	add $t1, $s2, $0
	add $s2, $s1, $0
	add $s1, $t1, $0

	jal HANOI
	
	add $t1, $s2, $0
	add $s2, $s1, $0
	add $s1, $t1, $0
	
	lw $ra, 4($sp) 		
	lw $s0, 0($sp) 		
	addi $sp, $sp, 8 	

	jr $ra
 	
 	

 
 EXIT: 
