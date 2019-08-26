		addi $s1,$zero,7
		addi $s0,$zero,1
loop:		add $s2,$zero,$s1
		add $s3,$zero,$s0
multi:		add $s0,$s0,$s3
		addi $s2,$s2,-1
		bne  $s2,$zero,multi
		addi $s1,$s1,-1
		bne  $s1,$zero,loop