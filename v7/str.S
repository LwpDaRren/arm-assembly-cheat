/* https://github.com/cirosantilli/arm-assembly-cheat#load-and-store-instructions */

#include "common.h"

.data;
    /* Must be in the .data section, since we want to modify it. */
myvar:
    .word 0x12345678

ENTRY
    /* r0 will contain the address. */
    ldr r0, =myvar

    /* Sanity check. */
    ldr r1, [r0]
    movw r2, #0x5678
    movt r2, #0x1234
    cmp r1, r2

    /* Modify the value. */
    movw r1, #0xDEF0
    movt r1, #0x9ABC
    str r1, [r0]

    /* Check that it changed. */
    ldr r1, [r0]
    movw r2, #0xDEF0
    movt r2, #0x9ABC
    cmp r1, r2

    /* Cannot use PC relative addressing to a different segment,
     * or else it fails with:
     *
     * ....
     * Error: internal_relocation (type: OFFSET_IMM) not fixed up
     * ....
     *
     * https://stackoverflow.com/questions/10094282/internal-relocation-not-fixed-up
     */
    /*ldr r0, myvar*/

    /* We could in theory write this to set the address of myvar,
     * but it will always segfault under Linux because the text segment is read-only. */
    /*
    str r1, var_in_same_section
var_in_same_section:
    */

    /* = sign just doesn't make sense for str, you can't set the
     * address of a variable. */
    /*str r1, =myvar */

EXIT
