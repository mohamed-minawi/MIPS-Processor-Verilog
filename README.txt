MIPS Single Cycle Implementation using Verilog
-----------------------------------------------

Design:
-------

1) The Instruction and Data Memory are both word addressable (32-bit). The instruction memory is loaded 
   with the instructions from a file called "memfile.txt".

2) The Processor supports Jump and Branch Operations.

3) The Supported Instructions are: 

	ADD
	ADDU
	ADDI
	ADDIU
	SUB
	SUBU
	AND
	ANDI
	OR
	ORI
	XOR
	XORI
	NOR
	SLT
	SLTI
	SLTU
	SLTIU
	SLL
	SRL
	SRA
	SLLV
	SRLV
	SRAV
	LW
	SW
	BEQ
	BNE
	J
	LUI

Further versions will support:
1) JAL,JR
2) Change memory to byte addressable to support LB,LH,LHU,SB,SH
3) Mult, div
