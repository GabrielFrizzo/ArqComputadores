# Armazene uma sequência crescente de 1000 valores na memória a partir do endereço 0x1001 1234.

		addi $s1, $zero, 1000
		li $t0, 0x10011234
adiciona:	addi $s0, $s0, 1
		sw $s0, ($t0)
		addi $t0, $t0, 4
		add $s1, $s1, -1
		bgez $s1, adiciona