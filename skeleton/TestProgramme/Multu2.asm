lui $1,0x1010
lui $2,0x1010
ori $1,0x0000
addiu $2, $2, 0x0001
multu $1, $2
mfhi $30
mflo $31