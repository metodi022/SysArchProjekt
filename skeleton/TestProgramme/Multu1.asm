lui $1,0x0000
lui $2,0x0000
ori $1,0x000a
addiu $2, $2, 0x0003
multu $1, $2
mflo $31
mfhi $30