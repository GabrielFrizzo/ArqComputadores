		addi $s0,$zero,21
		addi $s1,$zero,1 #s1 = i
loop:		add  $s2,$zero,$s1
quadr:		addi  $s2,$s2,-1
		add  $s3,$s3,$s1
		bne  $s2,$zero,quadr
		addi $s1,$s1,1
		bne  $s1,$s0,loop