#ifndef ISR_H
#define ISR_H

#include <stdint.h>

// Structure for interrupt registers
typedef struct {
    uint32_t gs, fs, es, ds;
    uint32_t edi, esi, ebp, esp_dummy, ebx, edx, ecx, eax;
    uint32_t int_no, err_code;
    uint32_t eip, cs, eflags, useresp, ss;
} isr_regs_t;

// ISR handler function
void isr_handler(isr_regs_t* regs);

// ISR stubs
extern void isr0();
extern void isr1();
extern void isr2();
extern void isr3();
extern void isr4();
extern void isr5();
extern void isr6();
extern void isr7();

#endif // ISR_H
