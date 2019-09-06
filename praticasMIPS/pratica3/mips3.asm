		li $s1, 5
loop1:		addi $s1, $a0, 1
		move $a0, $s1
		j factorial

#recebe s1 retorna s0
factorial:	
		li $s0,1
loop:		move $s2,$s1
		move $s3,$s0
multi:		addu $s0,$s0,$s3
		blt $s0, 0, quebrou
		addi $s2,$s2,-1
		bne  $s2,$zero,multi
		addi $s1,$s1,-1
		bne  $s1,$zero,loop
		j loop1

quebrou:
		addi $a0, $a0, 1
		li $v0, 1
		syscall
		
