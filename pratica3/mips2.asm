	start:	j final
		beq $zero, $zero, final
		la $t6, final
		jr $t6
	final:	bne $0, $0, final
		