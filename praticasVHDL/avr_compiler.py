from sys import argv

def bindigits(n, bits):
    s = bin(n & int("1"*bits, 2))[2:]
    return ("{0:0>%s}" % (bits)).format(s)

def decode(instr, rest):
	if instr == 'nop':
		return "00000000000000"
	elif instr == 'ldi':
		return f"0010{bindigits(rest[0],3)}{bindigits(rest[1],7)}"
	elif instr == 'subi':
		return f"0011{bindigits(rest[0],3)}{bindigits(rest[1],7)}"
	elif instr == 'add':
		return f"0100{bindigits(rest[0],3)}0000{bindigits(rest[1],3)}"
	elif instr == 'sub':
		return f"0101{bindigits(rest[0],3)}0000{bindigits(rest[1],3)}"
	elif instr == 'mov':
		return f"0110{bindigits(rest[0],3)}0000{bindigits(rest[1],3)}"
	elif instr == 'jmp':
		return f"1000000{bindigits(rest[0],7)}"
	elif instr == 'breq':
		return f"1001000{bindigits(rest[0],7)}"
	elif instr == 'brlt':
		return f"1010000{bindigits(rest[0],7)}"
	elif instr == 'cp':
		return f"1100{bindigits(rest[0],3)}0000{bindigits(rest[1],3)}"
	elif instr == 'cpi':
		return f"1101{bindigits(rest[0],3)}{bindigits(rest[1],7)}"
	elif instr == 'st':
		return f"1110{bindigits(rest[0],3)}0000000"
	elif instr == 'ld':
		return f"1111{bindigits(rest[0],3)}0000000"

with open(argv[1], 'r') as inp, \
	 open('output.txt', 'w') as output:
	for line in inp.readlines():
		parts = line.split()
		instr = parts[0]
		rest = [int(x) for x in parts[1:]]

		output.write(decode(instr, rest) + '\n')