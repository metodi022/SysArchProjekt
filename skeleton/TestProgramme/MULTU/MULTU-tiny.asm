lui $1, 0x0000  // 32'd5
ori $1, 0x0005
lui $2, 0x0000  // 32'd10
ori $2, 0x000a
multu $1, $2    // multiply $1 and $2
mfhi $3         // 0x00000000
mflo $4         // 0x00000032

// 5*10 = 0x5 * 0xA = 0x32
// expected: 0x5fffffff
