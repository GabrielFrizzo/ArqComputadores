.data
	dados: .word
.text			
		li $t0, 0
		
		la $s0, dados
	carrega:
		li $v0, 5
		syscall
		sw $v0, ($s0)
		addi $t0, $t0, 1
		addi $s0, $s0, 4
		bne $t0, 20, carrega
		
		
	imprime:
		addi $s0, $s0, -4
		lw $a0, ($s0)
		li $v0, 1
		syscall
		addi $t0, $t0, -1
		bne $t0, 0, imprime