		addi $s2,$zero,40
		addi $s3,$zero,1
loop:		add  $s1,$s1,$s3
		addi $s3,$s3,2
		addi $s2,$s2,-1
		bne  $s2,$zero,loop