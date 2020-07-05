lui $1, 0x0000  // 32'd40965
ori $1, 0xa005
lui $2, 0x0000  // 32'd40970
ori $2, 0xa00a
multu $1, $2    // multiply $1 and $2
mfhi $3         // 0x00000000
mflo $4         // 0x64096032

// 1678336050 = 0x64096032
