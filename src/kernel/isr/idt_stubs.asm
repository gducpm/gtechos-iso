[bits 32]

extern isr_common_stub

global isr0
isr0:
    cli
    push dword 0
    push dword 0
    jmp isr_common_stub

%macro ISR 1
global isr%1
isr%1:
    cli
    push dword 0        ; dummy error code
    push dword %1       ; push interrupt number (argument)
    jmp isr_common_stub
%endmacro

ISR 1    ; Debug
ISR 2    ; Non-maskable interrupt
ISR 3    ; Breakpoint
ISR 4    ; Overflow
ISR 5    ; Bound range exceeded
ISR 6    ; Invalid opcode
ISR 7    ; Device not available