		li $s0, 0x10010100
		li $s1, 0x10011100
		li $k0, 0
		
loop:		lw $t0, ($s0)
		sw $t0, ($s1)
		addi $s0, $s0, 4
		addi $s1, $s1, 4
		addi $k0, $k0, 1
		bne $k0, 400, loop