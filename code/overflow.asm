	ORG 0x0000
	
	LOADIMM.LOWER 0xF2
	LOADIMM.UPPER 0xFF
	MOV R0, R7
	LOADIMM.LOWER 100
	LOADIMM.UPPER 6
	MOV R1, R7
	LOADIMM.LOWER 0xF0
	LOADIMM.UPPER 0xFF
	MOV R2, R7
	MUL R3, R2, R0
	NOP
	NOP
	NOP
	NOP
	NOP
	TEST2 R3
	BRR.z -14
	NOP
	NOP
	NOP
	NOP
	BRR 0
	NOP
	NOP
	NOP
	
	END