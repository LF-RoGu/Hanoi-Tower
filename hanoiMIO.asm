 .text
 
 	addi $s0, $0, 8 #numero de discos
 	addi $a0, $0, 0x10010000 #torre origen
 	addi $a1, $0, 0x10010020 #torre auxiliar 
 	addi $a2, $0, 0x10010040 #torre destino
 	
 
 
 TORRES:
 
 	beq $s0,$0, HANOI 	#BRINCAR A HANOI SI YA ESTAN TODOS LOS DISCOS EN LA PRIMERA TORRE Y YA NO EN EL REGISTRO
 	sw $s0, ($s1)		# PONE LOS DISCOS DE N(que estan en el registro s0) EN LA TORRE ORIGEN s1 ((LOS PONE 1 A 1?)
	sub $s0, $s0, 1		# LE RESTA 1 AL REGISTRO DONDE ESÁN LOS DISCOS
	addi $s1, $s1, 4	# LE SUMA 4 A LA TORRE ORIGEN (DIRECCION DE MEMORIA) PARA HACER ESPACIO PARA EL SIGUIENTE DISCO.
	j TORRES		#CREA RECURSIVIDAD 
 
 HANOI:
 	#GUARDAR ENTORNO 
 	bne $s0, 1, else		# INICIO DE RECURSUVIDAD/ si n es diferente de 0 saltar al else k 
	lw $v0, ($s1)			# load tower1's(init) value to v0
 	JAL HANOI
 	
 
 ELSE:
 
 EXIT: 