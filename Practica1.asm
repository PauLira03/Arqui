.eqv n 15
.text
.globl main

main:
	addi s1,zero,3 #La segunda variable que almacenara mi numero de discos
	addi a1,zero,0x1
	slli a1,a1,28
	addi t0,zero,0x1
	slli t0,t0,16
	add a1,a1,t0  # Dirección de mi primer torre
	addi t0,zero,n # Variable temporal de mi numero de discos
	add t1,zero,a1 # Variable temporal de mi primera torre
	jal ini_torre
	sw zero, 0(sp)
	addi sp,sp,4
	addi a3,a3,4
	addi t0,zero,n
	addi t5,t0,-1
	
	slli t5,t5,2
	
	add a2,a2,t5
	addi a2,a2,4
	add a3,a3,t5
	addi a3,a3,4
	add t1,zero,a1 # Guardo en temporal mis direcciones 
	add t2,zero,a2
	add t3,zero,a3
    	jal hanoi        
	jal fin
	
ini_torre: 			
	beq t0,zero,torre_2
	addi sp,sp,-4
	sw ra, 0(sp)
	addi t2,t2,1         	# Mi torre origen con el valor del primer dato
    	sw t2, 0(t1)           	# Se guarda el valor de esta torre
    	addi t1,t1,4         	# Se mueve a nuesra direccion de memoria	
	addi t0,t0,-1
	jal ini_torre
	
exit_ini:
	lw ra, 4(sp)
	addi t1,t1,4
	add a3,zero,t1		# Se usa para almacenar la direción de la tercer torre
	add t5,zero,zero
	sw t5, 0(sp)
	addi sp,sp,4
	jalr ra
	
torre_2:   
	add a2, zero, t1      				
    	addi t1,t1,4	# Se mueve al inicio de la segunda torre y se pone la direccion
    	lw ra, 4(sp)
    	add t5,zero,zero
	sw t5, 0(sp)
    	sw t5, 4(sp)
    	addi sp,sp, 4
	jalr ra
	
hanoi:
	bne t0,zero,loop_hanoi #Usamos un else para entrar al loop y si llegamos a eso ir a ra
	jalr ra
	
loop_hanoi:
	#//////////////////////////////// Primera recursion
	addi sp, sp, -8 #Se busca generar la primera recursion del codigo
	sw ra, 4(sp)	# Guardamos en el sp el numero de disco y el ra
	sw t0, 0(sp)
	addi t0,t0,-1
	
	add t4,zero,t2
	add t2,zero,t3
	add t3,zero,t4
	
	jal hanoi
	
	#Mover disco
	lw t0, 0(sp) # Cragamos los valores de nuestro numero de discos y el ra
	lw ra, 4(sp)
	
	sw zero,0(sp) # Borramos estos datos del sp para limpiar la memoria
	sw zero,4(sp)
	
	addi sp,sp,8
	
	add t4,zero,t2 # Hacemos el movimiento una vez mas del cambio para regresar a mi contexto anterior
	add t2,zero,t3
	add t3,zero,t4
	
	addi t3,t3,-4 #Realizo el movimiento en la memoria
	lw t4,0(t1)
	sw t4,0(t3)
	sw zero,0(t1)
	addi t1,t1,4
	
	#////////////////////////////////
	addi sp, sp, -8 #Guardo los valores en el sp
	sw ra, 4(sp)
	sw t0, 0(sp)
	addi t0,t0,-1
	
	add t4,zero,t2 #Se hace el cambio para poder retornar a los valores anteriores de nuestras direcciones
	add t2,zero,t1
	add t1,zero,t4
	
	jal hanoi # Se busca retornar a la recursion por segunda vez
	#//////////////////////////////////
	lw t0, 0(sp)
	lw ra, 4(sp)
	
	sw zero,0(sp)
	sw zero,4(sp)
	
	addi sp,sp,8
	
	add t4,zero,t2 # Vuelvo hacer un cambio de contexto con el movimiento de la segunda recursion
	add t2,zero,t1
	add t1,zero,t4
	
	jalr ra
	
fin:
	add zero,zero,zero
