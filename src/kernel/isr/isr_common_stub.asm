[bits 32]

global isr_common_stub
extern isr_handler        ; our C function

isr_common_stub:
    pusha                 ; save general-purpose registers
    push ds
    push es
    push fs
    push gs

    mov ax, 0x10          ; kernel data segment selector (0x10 = second GDT entry, usually data)
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    push esp              ; push pointer to struct isr_regs_t
    call isr_handler
    add esp, 4            ; clean stack (remove argument)

    pop gs
    pop fs
    pop es
    pop ds
    popa

    add esp, 8            ; drop error code + int_no that were pushed in stub
    sti
    iretd                 ; return from interrupt
