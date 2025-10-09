#include "timer.h"
#include "isr/isr.h"

// A simple function to write a byte to a specific I/O port.
// In a larger kernel, this would be in a separate "ports.c" file.
// The "volatile" keyword prevents the compiler from optimizing this away.
static inline void port_byte_out(unsigned short port, unsigned char data) {
    __asm__ __volatile__("outb %0, %1" : : "a"(data), "Nd"(port));
}

// This will keep track of how many ticks have occurred.
volatile unsigned int timer_ticks = 0;

/*
 * The handler for the timer interrupt (IRQ0).
 * This function is called by the CPU at the frequency we set in init_timer().
 * The 'volatile' keyword on timer_ticks is important because this function
 * modifies it, and other parts of the kernel might read it. It tells the
 * compiler that the value can change at any time.
 */
void timer_handler(struct registers *regs) {
    timer_ticks++;

    // This is where you would put code that needs to run periodically.
    // For example, you could update a clock display or, in a multitasking
    // OS, this is where the scheduler would decide to switch tasks.
    // For now, we'll just increment our counter.
}

/*
 * Initializes the PIT and sets up the timer handler.
 */
void init_timer() {
    // First, register our timer handler for IRQ0.
    register_interrupt_handler(IRQ0, timer_handler);

    // The PIT's base frequency is 1,193,182 Hz.
    // We divide this by our desired frequency (100 Hz) to get the divisor.
    unsigned int divisor = 1193182 / PIT_FREQUENCY;

    // Send the command byte to the PIT's command register.
    // Command 0x36 means:
    // - Channel 0
    // - Access mode: low byte/high byte (send divisor in two 8-bit parts)
    // - Mode 3: square wave generator (for a repeating interrupt)
    port_byte_out(0x43, 0x36);

    // Send the divisor value to the Channel 0 data port.
    // We have to send it in two parts, low byte first.
    unsigned char low = (unsigned char)(divisor & 0xFF);
    unsigned char high = (unsigned char)((divisor >> 8) & 0xFF);

    port_byte_out(0x40, low);
    port_byte_out(0x40, high);
}
