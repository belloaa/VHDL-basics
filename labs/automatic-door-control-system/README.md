## Automatic Door Controller
A finite state machine implementation of an automatic door control system with emergency features.

### States

- DOOR_CLOSED
- DOOR_OPENING
- DOOR_OPEN
- DOOR_CLOSING
- EMERGENCY

### Features

- Motion sensor detection
- Emergency state for stuck door scenarios
- Force open override capability
- LED status indication
- Motor control signals
- Fully open/closed position detection
- 5-second timer for door open state
- Emergency trigger after 5 seconds in opening/closing states
- 1Hz LED flashing in emergency state

### RGB LED Color Codes

- Red: Door Closed
- Blue: Door Opening
- Green: Door Open
- Yellow: Door Closing
- Flashing Red: Emergency

### Motor Control Signals

- 00: Motor Off
- 01: Opening
- 10: Closing
- 11: Not Used

### Getting Started

#### Prerequisites

- Vivado Design Suite
- Zybo Z7-10 FPGA Board
- Pmod SSD (Seven-Segment Display)
- Analog Discovery 2 (for testing)

#### Files Structure

├── src/
│   ├── lfsr/
│   │   ├── lfsr.vhd
│   │   └── lfsr_tb.vhd
│   ├── counter/
│   │   ├── fsm_counter.vhd
│   │   └── fsm_counter_tb.vhd
│   └── door/
│       ├── door_controller.vhd
│       ├── timer.vhd
│       └── door_controller_tb.vhd
├── constraints/
│   └── Zybo-Z7-Master.xdc
└── display/
    └── display_driver.vhd

#### Constraint File Setup

- Modify the Zybo-Z7-Master.xdc file to match your pin assignments
- For the seven-segment display, ensure pins are correctly mapped according to the Pmod SSD datasheet
- Note: SSD pin mappings may need to be reflected about the x-axis depending on your setup

#### Building and Testing

- Create a new Vivado project
- Add source files for the desired component
- Add testbench files
- Add constraints file
- Run simulation
- Generate bitstream
- Program the Zybo board

#### Testing

Each component includes testbenches that verify:

- Basic functionality
- Edge cases
- Timing requirements
- Input/output behavior
- State transitions
- Emergency scenarios (door controller)

