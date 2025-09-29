SECTIONS
{
  /* Load the kernel at 1MB */
  . = 1M;

  .text ALIGN(4K) : {
    *(.multiboot)   /* multiboot header must come first */
    *(.text*)
  }

  .rodata ALIGN(4K) : {
    *(.rodata*)
  }

  .data ALIGN(4K) : {
    *(.data*)
  }

  .bss ALIGN(4K) : {
    *(COMMON)
    *(.bss*)
  }
}
