# Calcule a soma de todos os dados entre 0x1000 0000 e 0x1000 FFFC (inclusive).

		li $t0, 0x10000000
adiciona:	lw $t1, ($t0)
		addi $t0, $t0, 4
		bne $t0, 0x10010000, adiciona