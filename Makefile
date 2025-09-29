# ---- Variables ----
CC       ?= i686-elf-gcc
LD       ?= i686-elf-ld
AS       = nasm

CFLAGS   := -m32 -ffreestanding -Wall -Wextra -O2 -Isrc/kernel
LDFLAGS  := -T src/kernel/linker.ld -m elf_i386

BUILDDIR := build
ISO      := $(BUILDDIR)/gtechos.iso
KERNEL   := $(BUILDDIR)/gtkern.bin

# Object files
OBJ      := $(BUILDDIR)/start.o $(BUILDDIR)/gtkern.o $(BUILDDIR)/gdt.o $(BUILDDIR)/gdt_flush.o $(BUILDDIR)/isr.o $(BUILDDIR)/idt_stubs.o $(BUILDDIR)/isr_common_stub.o

GRUBCFG  := src/bootloader/grub.cfg
GIROOTFS := girootfs

README   := README.md
LICENSE  := LICENSE
MAKEFILE := Makefile


# ---- Rules ----
all: $(ISO)

$(ISO): $(KERNEL) $(GIROOTFS)/boot/grub/grub.cfg
	@grub-mkrescue -o $(ISO) $(GIROOTFS)

$(KERNEL): $(OBJ)
	@$(LD) $(LDFLAGS) -o $(KERNEL) $(OBJ)
	@cp $(KERNEL) $(GIROOTFS)/boot/gtkern.bin
	@cp $(KERNEL) $(GIROOTFS)/boot/kernel.bin

$(GIROOTFS)/boot/grub/grub.cfg:
	@mkdir -p $(GIROOTFS)/boot/grub
	@cp $(GRUBCFG) $@

$(BUILDDIR)/start.o: src/kernel/start.asm
	@mkdir -p $(BUILDDIR)
	@$(AS) -f elf32 $< -o $@

$(BUILDDIR)/gtkern.o: src/kernel/gtkern.c
	@mkdir -p $(BUILDDIR)
	@$(CC) $(CFLAGS) -c $< -o $@

$(BUILDDIR)/gdt.o: src/kernel/gdt/gdt.c
	@mkdir -p $(BUILDDIR)
	@$(CC) $(CFLAGS) -c $< -o $@

$(BUILDDIR)/gdt_flush.o: src/kernel/gdt/gdt_flush.asm
	@mkdir -p $(BUILDDIR)
	@$(AS) -f elf32 $< -o $@

$(BUILDDIR)/isr.o: src/kernel/isr/isr.c
	@mkdir -p $(BUILDDIR)
	@$(CC) $(CFLAGS) -c $< -o $@

$(BUILDDIR)/idt_stubs.o: src/kernel/isr/idt_stubs.asm
	@mkdir -p $(BUILDDIR)
	@$(AS) -f elf32 $< -o $@

$(BUILDDIR)/isr_common_stub.o: src/kernel/isr/isr_common_stub.asm
	@mkdir -p $(BUILDDIR)
	@$(AS) -f elf32 $< -o $@

run:
	@qemu-system-i386 -cdrom $(ISO)


clean:
	@rm -rf $(BUILDDIR)


help:
	@less $(README) || more $(README)


showmakefile:
	@less $(MAKEFILE) || more $(MAKEFILE)


license:
	@less $(LICENSE) || more $(LICENSE)