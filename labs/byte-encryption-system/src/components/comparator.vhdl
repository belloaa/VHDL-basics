------------------------------------------------------------------------
-- University  : University of Alberta
-- Course      : ECE 410: Advanced Digital Logic Design
-- Project     : Byte Encryption System
-- Authors     : Abdul Bello, Alastair Cottier
-- Students ID : 1664803, 1668621
-- Date        : 10/11/2024
------------------------------------------------------------------------
-- Description : Encryption-decryption system that processes an 8-bit message.
------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity comparator is
    port(
        MESSAGE     : in  std_logic_vector(7 downto 0);
        OUT_MESSAGE : out std_logic_vector(7 downto 0);
        RED_LED     : out std_logic;
        GREEN_LED   : out std_logic
    );
    
end entity comparator;

architecture BEHAV of comparator is
    signal FIVEBIT_CHECK : std_logic;
    signal THREEBIT_CHECK : std_logic;
    
begin 
    comp : process(MESSAGE)
        
        variable A, B, C, D, E, F, G, H : std_logic;

        begin
        --assigns the five bits to variables for boolean expression from 5 variable kmap
        A := MESSAGE(7);
        B := MESSAGE(6);
        C := MESSAGE(5);
        D := MESSAGE(4);
        E := MESSAGE(3);  
        F := MESSAGE(2);
        G := MESSAGE(1);
        H := MESSAGE(0);
        
        -- boolean expression from kmap addressing only capital ASCII alphabet characters
        THREEBIT_CHECK <= (not A and B and not C);
        FIVEBIT_CHECK <= ((D or E or F or G or H) and (not D or not E or not G or not H) and (not D or not E or not F));
        
    end process comp;
    
    flip_led : process(FIVEBIT_CHECK, THREEBIT_CHECK, MESSAGE)
        begin
        
        -- LED circuit output logic, green LED if all the checks go well
        if (FIVEBIT_CHECK = '1' and THREEBIT_CHECK = '1') then
            GREEN_LED <= '1';
            RED_LED <= '0';
            OUT_MESSAGE <= MESSAGE;
        else
            -- red LED on if checks fail, output message is set to 0
            GREEN_LED <= '0';
            RED_LED <= '1';
            OUT_MESSAGE <= (others=>'0');
         end if;
         
     end process flip_led;
    
end architecture BEHAV;