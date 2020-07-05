lui $1 0x0000
lui $2 0x0000	# divident
lui $3 0x0000	# dividor
addiu $2 $1 9
addiu $3 $1 3
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
divu $2 $3
mfhi $2		# remainder should be 0
mflo $3		# quotient shuold be 3
