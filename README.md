# GTechOS ISO Implementation (PRE-RELEASE)  
Fully Free and Open-Source hobby project  
## What is GTechOS?  
GTechOS, or GDucpm GTechOS, is a fully FOSS operating system with a custom kernel (not Linux). It's focused on six core philosophies:  
 - **Privacy**: Users aren't prisoners. We don't want to spy on them.  
 - **Customization**: Tweak your system in different ways.  
 - **Modernization**: Features try to be as modern as possible to make it feel like 2050.  
 - **Freedom**: Do anything you want, even if it means `:(){:|:&};:`.  
 - **Transparency**: Come on, the EFI System Partition is not a government secret.  
 - **Empowerment**: Teach users instead of leaving them in the dark.  
## Basic info  
**License**: GPLv3  
**Original Maintainer** (please **DO NOT change**): GDucpm  
**Current Maintainer**: GDucpm  
**Current Version**: PreRelease pv1.0.1  
## Dependencies (in Arch Linux package names)  
 - **Compile-time**:  
     - `grub`  
     - `make`  
     - `i686-elf-gcc-bin` (AUR)  
     - `i686-elf-binutils-bin` (AUR)  
     - `nasm`  
     - `mtools`  
     - `xorriso`  
     - `efibootmgr` (Optional)  
     - `less` (Optional)  
     - Base packages
 - **Runtime**:
     - `qemu-full`
     - Base packages
## Quickstart
 - Clone this GitHub repository:  
     - SSH: `git clone "git@github.com:gducpm/gtechos-iso.git"` (if you have set it up)  
     - HTTPS: `git clone "https://github.com/gducpm/gtechos-iso"` (if you haven't set up GitHub SSH)  
 - **Run `./b` in the project directory to start making and running.** `b` is a bash script that stands for `build`, which runs `make` and `make run`. It's designed to minimize keystrokes; though it's not a common approach.  
## Dirtree (Updated 01/10/2025 DD/MM/YYYY) 
```tree
.
├── b
├── build
│   ├── gdt_flush.o
│   ├── gdt.o
│   ├── gtechos.iso
│   ├── gtkern.bin
│   ├── gtkern.o
│   ├── idt_stubs.o
│   ├── isr_common_stub.o
│   ├── isr.o
│   └── start.o
├── etc
│   └── KERNEL.checklist
├── girootfs
│   └── boot
│       ├── grub
│       │   └── grub.cfg
│       ├── gtkern.bin
│       └── kernel.bin
├── LICENSE
├── Makefile
├── README.md
└── src
    ├── bootloader
    │   └── grub.cfg
    └── kernel
        ├── gdt
        │   ├── gdt.c
        │   ├── gdt_flush.asm
        │   └── gdt.h
        ├── gtkern.c
        ├── isr
        │   ├── idt_stubs.asm
        │   ├── isr.c
        │   ├── isr_common_stub.asm
        │   └── isr.h
        ├── linker.ld
        └── start.asm
11 directories, 28 files
```  
## Compile and run  
 - **To compile**: run `make`  
 - **To run the compiled ISO**: run `make run`  
## Contribution  
To **contribute code** please start a new issue  
## Final notes
Thanks for viewing my project! It definitely makes me happy that my OS is getting recognized. I make these OSes because I have always wished that one day, people will be using more FOSS. 
Go to ./etc/KERNEL.checklist for my current implementation stage.  