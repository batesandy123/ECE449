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
	
	STORE R0, R1
	LOAD R3, R2
	STORE R0, R3
	
	BRR 0
	NOP
	NOP
	NOP
	
	END