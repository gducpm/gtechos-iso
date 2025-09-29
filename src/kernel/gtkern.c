#include <stdint.h>
#include "isr/isr.h"
#include "gdt/gdt.h"

/* Minimal GTechOS kernel - prints Hello World */

/* Multiboot header (GRUB requirement) */
__attribute__((section(".multiboot")))
const unsigned int multiboot_header[] = {
    0x1BADB002,                /* magic */
    0x00,                      /* flags */
    -(0x1BADB002)              /* checksum */
};

struct IDTEntry {
    uint16_t offset_low;
    uint16_t selector;
    uint8_t  zero;
    uint8_t  type_attr;
    uint16_t offset_high;
} __attribute__((packed));
struct IDTEntry idt[256];
struct IDTPointer {
    uint16_t limit;
    uint32_t base;
} __attribute__((packed));

struct IDTPointer idt_ptr;

void set_idt_entry(int n, uint32_t handler_addr) {
    idt[n].offset_low  = handler_addr & 0xFFFF;
    idt[n].selector    = 0x08; // code segment in GDT
    idt[n].zero        = 0;
    idt[n].type_attr   = 0x8E; // interrupt gate, present
    idt[n].offset_high = (handler_addr >> 16) & 0xFFFF;
}

__attribute__((noreturn))
void kernel_main(void) {
    gdt_install();

    const char *str = "GTechOS is live!"; // This is the GTechOS traditional boot message
    char *vga = (char*)0xB8000;

    for (int i = 0; str[i] != '\0'; i++) {
        vga[i * 2] = str[i];   // character
        vga[i * 2 + 1] = 0x07; // light grey on black
    }

    idt_ptr.limit = sizeof(idt) - 1;
    idt_ptr.base  = (uint32_t)&idt;

    set_idt_entry(0, (uint32_t)isr0);
    set_idt_entry(1, (uint32_t)isr1);
    set_idt_entry(2, (uint32_t)isr2);
    set_idt_entry(3, (uint32_t)isr3);
    set_idt_entry(4, (uint32_t)isr4);
    set_idt_entry(5, (uint32_t)isr5);
    set_idt_entry(6, (uint32_t)isr6);
    set_idt_entry(7, (uint32_t)isr7);

    asm volatile("lidt %0" : : "m"(idt_ptr));
    asm volatile("int $0");
    for (;;); // hang
}