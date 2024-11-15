# FSM Counter with Custom Sequence
A 4-bit counter implemented as a Moore Finite State Machine with two counting modes.

## Features

Standard binary up-counter (0-15)
- Custom sequence mode with 3-bit transitions between states
- Mode selection input
- Asynchronous reset
- Enable signal
- Seven-segment display output

## Custom Sequence
The custom sequence ensures exactly three bits change between consecutive states, providing the following transitions:
0000 -> 0111 -> 1100 -> 1011 -> 0110 -> 0001 -> 1111 -> 1000 -> 0011 -> 1101 -> 1010 -> 0100 -> 1001 -> 0010 -> 0101 -> 1110 -> 0000