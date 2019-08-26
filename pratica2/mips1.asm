		addi $s1, $zero, 0
		addi $s2, $zero, 32
		addi $s7, $zero, 32
		
		slti $s0, $s1, 0
		beq $s0, $zero, skip
		addi $s3, $zero, 3

skip:		addi $s3, $s3, 1
		slt $s0, $s7, $s2
		bne $s0, $zero, skip2
		addi $s3, $s3, 1
		
		beq $s2, $s7, skip2
		addi $s3, $s3, 1

skip2: