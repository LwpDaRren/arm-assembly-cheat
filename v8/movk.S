#include "common.h"

ENTRY
    movk x0, 0x4444, lsl 0
    movk x0, 0x3333, lsl 16
    movk x0, 0x2222, lsl 32
    movk x0, 0x1111, lsl 48
    ldr x1, =0x1111222233334444
    cmp x0, x1
    ASSERT(beq)
EXIT
