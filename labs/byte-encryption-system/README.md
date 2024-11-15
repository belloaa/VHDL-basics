# Byte Encryption System

## Overview
An 8-bit encryption/decryption system implemented in VHDL that processes uppercase ASCII characters. The system encrypts valid input characters using barrel shifting and XOR encryption, then converts the decrypted output to lowercase.

## Components

### 1. ASCII Comparator
- Validates input characters (A-Z only)
- Output:
  - Valid input: Original message + Green LED
  - Invalid input: Zero byte + Red LED
- Valid ASCII range: 01000001 - 01011010

### 2. Barrel Shifter
- Bi-directional 8-bit shifter
- 4-bit input controls:
  - Direction (1 bit)
  - Shift magnitude (3 bits)
- Provides protection against man-in-the-middle attacks

### 3. XOR Encryption/Decryption
- Uses 8-bit encryption key
- Symmetric encryption: (message ⊕ key) ⊕ key = message
- Two blocks in series for encryption and decryption

### 4. Case Modifier
- Converts successful decrypted uppercase letters to lowercase
- Modifies 3rd MSB of ASCII character

## Files
- `comparator.vhd`: ASCII character validator
- `barrel_mux.vhd`: Barrel shifter implementation
- `xor_enc.vhd`: XOR encryption block
- `case_modifier.vhd`: Uppercase to lowercase converter
- `system.vhd`: Top-level system integration

## Simulation
Test cases validate:
- XOR blocks: All 256 possible 8-bit values
- Comparator: 32 test cases covering valid/invalid characters
- Barrel Shifter: 8 different shift amounts
- Case Modifier: All 26 uppercase letters

## Hardware Implementation
- Target: Zybo Z7-10 FPGA
- Input: ASCII characters via GPIO pins 0-7
- Output: Decrypted lowercase characters via GPIO pins 8-15

## Setup
1. Connect Zybo Z7-10 FPGA
2. Configure GPIO pins for input (0-7) and output (8-15)
3. Run test script to validate functionality
4. Monitor output through WaveForms logic window
