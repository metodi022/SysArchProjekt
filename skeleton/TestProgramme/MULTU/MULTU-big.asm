lui $1, 0x7000  // 32'd1879076864
ori $1, 0x7000
lui $2, 0x7fff  // 32'd2147450879
ori $2, 0x7fff
multu $1, $2    // multiply $1 and $2
mfhi $3         // 0x37ffffff
mflo $4         // 0x57ff9000

// (2^31)*((3*2^30)-1) = 1879076864 * 2147450879 = 6917529025493598208
//                     = 0x70007000 * 0x7fff7fff = 0x37ffffff57ff9000
