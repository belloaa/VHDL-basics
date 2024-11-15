## Pseudo Random Number Generator (LFSR)

An 8-bit Galois Linear Feedback Shift Register implementation for generating pseudo-random numbers.

### Features

- 8-bit output sequence
- Configurable feedback taps
- Asynchronous reset
- Enable signal
- 2Hz clock frequency for visualization
- Seven-segment display output

### Implementation
Two LFSR configurations are provided:

- Taps at positions 1, 2, 3, and 7
- Taps at positions 1, 4, 5, and 6

Each configuration produces different sequence lengths and randomness characteristics.

### Hardware Requirements

- Zybo Z7-10 FPGA Board
- Pmod Seven-Segment Display