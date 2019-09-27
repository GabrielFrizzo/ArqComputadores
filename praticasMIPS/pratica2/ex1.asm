# Usando apenas instru›es nativas do assembly MIPS, 
# faa um programa que classifica $s1 e $s2 em seis diferentes possibilidades, 
# indicadas por $s3 ao final, de acordo com o seguinte:	
# $s1>=0 e $s2>32  ----- s3 = 1
# $s1>=0 e $s2==32  ----- s3 = 2
# $s1>=0 e $s2<32  ----- s3 = 3
# $s1<0 e $s2>32  ----- s3 = 4
# $s1<0 e $s2==32  ----- s3 = 5
# $s1<0 e $s2<32  ----- s3 = 6


		
		addi $s1, $zero, -1
		addi $s2, $zero, 31
		addi $s3, $zero, 0 
		addi $s4, $zero, 32   # constante 32 parea fazer comparacoes
		
		bgez $s1, maiorquezero
		bltz $s1, menorquezero
		
		
maiorquezero:   beq $s2, $s4, dois  	# se s2 = 32
		sub $s2, $s2, $s4   	# faz s2 - 32  
		bltz $s2, tres	     	# se resultado menor que zero (ou seja s2 < 32) 
		bgtz $s2, um		# se resultado maior que zero (ou seja s2 > 32)

menorquezero:	beq $s2, $s4, cinco 	# se s2 = 32
		sub $s2, $s2, $s4   	# faz s2 - 32  
		bltz $s2, seis	     	# se resultado menor que zero (ou seja s2 < 32) 
		bgtz $s2, quatro	# se resultado maior que zero (ou seja s2 > 32)


seis:		add $s3, $s3, 1
cinco:		add $s3, $s3, 1
quatro:		add $s3, $s3, 1
tres:		add $s3, $s3, 1 	
dois:		add $s3, $s3, 1		
um:		add $s3, $s3, 1
