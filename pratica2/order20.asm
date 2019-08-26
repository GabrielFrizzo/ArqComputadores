		li $s0, 0x10010000
		li $s1 20

carrega:	sw $s1, ($s0)
		addi $s1, $s1, -1
		addi $s0, $s0, 4
		bne $s1, 0, carrega
		
		li $k0, 1
bubble:		beq $k0, 0, finish
		li $s0, 0x10010000
		li $k0, 0
loop:		add $s1, $s0, 4
		lw $t0, ($s0)
		lw $t1, ($s1)
		blt $t1, $t0, switch
		beq $s1, 0x1001004c, bubble
		addi $s0, $s0, 4
		j   loop
		
		
		
switch:		sw $t0, ($s1)
		sw $t1, ($s0)
		li $k0, 1
		j  loop
		
finish: