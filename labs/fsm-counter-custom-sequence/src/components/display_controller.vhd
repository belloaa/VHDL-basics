----------------------------------------------------------------------------------
-- Filename : display_driver.vhdl
-- Author : Antonio Alejandro Andara Lara
-- Date : 02-Oct-10-2024
-- Design Name: display driver
-- Description : This file implements a design that can read two 4 bit (hex)
-- characters from a register and show it on a seven segments display
-- Additional Comments:
-- Copyright : University of Alberta, 2024
-- License : CC0 1.0 Universal
----------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY display_controller IS
	PORT (
		-- read in digits, the 4 MSBs represent the first digit
		-- the last LSBs represent, the sencond digit
		digits : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		clock  : IN STD_LOGIC;
		-- Controls which of the seven segment displays is active
		display_select : OUT STD_LOGIC;
		--controls which digit to display
		segments : OUT STD_LOGIC_VECTOR (6 DOWNTO 0)
	);
END display_controller;

ARCHITECTURE Behavioral OF display_controller IS

	SIGNAL digit : STD_LOGIC_VECTOR (3 DOWNTO 0); -- character to display
    CONSTANT limit : INTEGER := 1_250_000;

    SIGNAL count        : INTEGER RANGE 1 TO limit:= 1; -- set the counter range
    SIGNAL clock_div: STD_LOGIC := '0';

BEGIN
	clock_divider: PROCESS (clock)
    BEGIN
        IF rising_edge(clock) THEN
            IF count < limit THEN
                count <= count + 1;
            ELSE
                count        <= 1;
                clock_div <= NOT clock_div;
            END IF;
        END IF;
    END PROCESS;
    
	display_select <= '1';
    digit <= digits(3 DOWNTO 0);
    
    -- The Zybo Z7 Pmod SSD: Seven Segment Display is connected to the board in such a way
    -- that the displayed characters will appear upside down if we follow the default pin mapping
    -- provided in the Pmod SSD reference manual. To solve this issue, the constraint file must be
    -- updated by inverting the pin assignments. Specifically, the values assigned to the segments 
    -- (A, B, C, D, E, F, G) should be reversed to ensure the characters are displayed correctly. 
    -- Please refer to the Pmod SSD reference manual for the original mapping, and make sure 
    -- to adjust it accordingly in the constraint file.
	WITH digit SELECT -- segments "ABCDEFG" 
		segments <= "1111110" WHEN "0000", --0
					"0000110" WHEN "0001", --1
					"1101101" WHEN "0010", --2
					"1001111" WHEN "0011", --3
					"0010111" WHEN "0100", --4
					"1011011" WHEN "0101", --5
					"1111011" WHEN "0110", --6
					"0001110" WHEN "0111", --7
					"1111111" WHEN "1000", --8
					"1011111" WHEN "1001", --9
					"0111111" WHEN "1010", --A
					"1110011" WHEN "1011", --B
					"1111000" WHEN "1100", --C
					"1100111" WHEN "1101", --D
					"1111001" WHEN "1110", --E
					"0111001" WHEN "1111", --F
					"0000000" WHEN OTHERS;
END Behavioral;