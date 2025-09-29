[bits 32]

section .bss
    resb 8192
stack_top:

section .text
global _start
extern kernel_main

_start:
    mov esp, stack_top
    call kernel_main
    cli
    hlt
