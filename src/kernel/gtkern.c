/* Minimal GTechOS kernel - prints Hello World */

/* Multiboot header (GRUB requirement) */
__attribute__((section(".multiboot")))
const unsigned int multiboot_header[] = {
    0x1BADB002,                /* magic */
    0x00,                      /* flags */
    -(0x1BADB002)              /* checksum */
};

__attribute__((noreturn))
void kernel_main(void) {
    const char *str = "GTechOS is live!"; // This is the GTechOS traditional boot message
    char *vga = (char*)0xB8000;

    for (int i = 0; str[i] != '\0'; i++) {
        vga[i * 2] = str[i];   // character
        vga[i * 2 + 1] = 0x07; // light grey on black
    }

    for (;;); // hang
}