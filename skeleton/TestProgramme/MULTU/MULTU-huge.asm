lui $1, 0x8000  // 32'd2147483648
ori $1, 0x0000
lui $2, 0xbfff  // 32'd3221225471
ori $2, 0xffff
multu $1, $2    // multiply $1 and $2
mfhi $3         // 0x5fffffff
mflo $4         // 0x80000000

// (2^31)*((3*2^30)-1) = 2147483648 * 3221225471 = 6917529025493598208
//                     = 0x80000000 * 0xbfffffff = 0x5fffffff80000000
// expected: 0x5fffffff
