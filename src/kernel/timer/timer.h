#ifndef TIMER_H
#define TIMER_H

// The default frequency for the Programmable Interval Timer (PIT).
// The PIT's clock runs at a base frequency of 1,193,182 Hz.
// A divisor of 11932 gives us approximately 100 Hz.
#define PIT_FREQUENCY 100

/*
 * Initializes the Programmable Interval Timer (PIT) to fire at a specific frequency.
 * This function sets up the PIT to generate IRQ0 at the given frequency, and registers
 * a handler for it.
 */
void init_timer();

#endif /* TIMER_H */