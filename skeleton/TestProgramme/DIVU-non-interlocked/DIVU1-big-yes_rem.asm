lui $1 0x0000
lui $2 0x0000	        # divident
lui $3 0x0000	        # dividor
addiu $2 $1 0xc0000000  # 3221225472
addiu $3 $1 123
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
mfhi $2                 # remainder should be 120
mflo $3		            # quotient shuold be 26188824
# 3221225472 / 123 = 26188824 R 120
