#include <stdint.h>
#include "isr.h"

void isr_handler(isr_regs_t* regs) {
    char *msg = "Interrupt received: ";
    char *vga = (char*)0xB8000;

    for (int i = 0; msg[i] != '\0'; i++) {
        vga[i * 2] = msg[i];
        vga[i * 2 + 1] = 0x07;
    }

    /* Print interrupt number (simple, not fancy yet) */
    vga[40] = '0' + regs->int_no; // crude: only works for 0-9
    vga[41] = 0x07;

    for (;;); // hang to observe
}
