# ---- Variables ----
CC       ?= i686-elf-gcc
LD       ?= i686-elf-ld

CFLAGS   := -m32 -ffreestanding -O2 -Wall -Wextra -fno-builtin -fno-exceptions
LDFLAGS  := -m elf_i386 -T

KERNEL_NAME := gtkern.bin
GRUB_NAME   := grub.cfg
LINKER_NAME := linker.ld
ISO_NAME    := gtechos.iso

SRCDIR   := src
BUILDDIR := build
ISO_DIR  := girootfs
BOOT_DIR := $(ISO_DIR)/boot
GRUB_DIR := $(BOOT_DIR)/grub

KERNEL_SRCDIR := $(SRCDIR)/kernel
BOOTLOADER_SRCDIR := $(SRCDIR)/bootloader

KERNEL   := $(BUILDDIR)/$(KERNEL_NAME)
ISO      := $(BUILDDIR)/$(ISO_NAME)

KERNEL_ISO_FILE := $(BOOT_DIR)/$(KERNEL_NAME)
GRUB_ISO_FILE   := $(GRUB_DIR)/$(GRUB_NAME)

KERNEL_SRC := $(KERNEL_SRCDIR)/gtkern.c
GRUB_SRC   := $(BOOTLOADER_SRCDIR)/grub.cfg
LINKER_SRC := $(KERNEL_SRCDIR)/$(LINKER_NAME)
OBJ        := $(BUILDDIR)/gtkern.o

README   := README.md
MAKEFILE := Makefile
LICENSE  := LICENSE

# ---- Targets ----
# I don't like a linked list of targets, really hard to trace.
all: $(OBJ) $(KERNEL) prepare $(ISO)

$(OBJ): $(KERNEL_SRC)
	@mkdir -p $(BUILDDIR)
	@$(CC) $(CFLAGS) -c $< -o $@

$(KERNEL): $(OBJ) $(LINKER_SRC)
	@$(LD) $(LDFLAGS) $(LINKER_SRC) $(OBJ) -o $@

prepare: $(KERNEL) $(GRUB_SRC)
	@mkdir -p $(GRUB_DIR)
	@cp $(KERNEL) $(KERNEL_ISO_FILE)
	@cp $(GRUB_SRC) $(GRUB_ISO_FILE)

$(ISO): prepare
	@mkdir -p $(BUILDDIR)
	@grub-mkrescue -o $(ISO) $(ISO_DIR)

run: $(ISO)
	@qemu-system-i386 -cdrom $(ISO) -m 512

clean:
	@rm -rf $(BUILDDIR) $(KERNEL_ISO_FILE) $(GRUB_ISO_FILE)

help:
	@less $(README)||more $(README)

showmakefile:
	@less $(MAKEFILE)||more $(MAKEFILE)

license:
	@less $(LICENSE)||more $(LICENSE)

.PHONY: all clean run prepare help showmakefile license