from sys import argv

opcodes = {
	'nop' : '0000',
	'ldi' : '0010',
	'subi': '0011',
	'add' : '0100',
	'sub' : '0101',
	'mov' : '0110',
	'jmp' : '1000',
	'breq': '1001',
	'brlt': '1010',
	'cp'  : '1100',
	'cpi' : '1101',
	'st'  : '1110',
	'ld'  : '1111',
}

def bindigits(n, bits):
    s = bin(int(n) & int("1"*bits, 2))[2:]
    return ("{0:0>%s}" % (bits)).format(s)

def decode(instr, rest):
	op = opcodes[instr]

	if instr == 'nop':
		return '00000000000000'
	elif instr in ('ldi', 'subi', 'cpi'):
		R = bindigits(rest[0][2:],3)
		cte = bindigits(rest[1],7)
		return op+R+cte
	elif instr in ('add', 'sub', 'mov', 'cp'):
		R = bindigits(rest[0][2:],3)
		r = bindigits(rest[1][2:],3)
		return op+R+'0'*4+r
	elif instr in ('jmp', 'breq', 'brlt'):
		cte = bindigits(rest[0],7)
		return op+'0'*3+cte
	elif instr in ('st', 'ld'):
		R = bindigits(rest[0][2:],3)
		return op+R+'0'*7
	elif instr == 'ld':
		return f"1111{bindigits(rest[0],3)}0000000"

with open(argv[1], 'r') as inp, \
	 open('output.txt', 'w') as output:
	for line in inp.readlines():
		parts = line.split()
		instr = parts[0]

		output.write(decode(instr, parts[1:]) + '\n')