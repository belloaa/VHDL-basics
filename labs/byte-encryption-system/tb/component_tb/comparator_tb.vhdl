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

entity T_COMPARATOR is
end T_COMPARATOR;

architecture TEST of T_COMPARATOR is

    component comparator
        port(
            MESSAGE     : in  std_logic_vector(7 downto 0);
            OUT_MESSAGE : out std_logic_vector(7 downto 0);
            RED_LED     : out std_logic;
            GREEN_LED   : out std_logic
        );
    end component comparator;
    
    signal MESSAGE_REG : unsigned(7 downto 0)         := "01000000";
    signal MESSAGE_TB     : std_logic_vector(7 downto 0) := "01000000";
    signal OUT_MESSAGE_TB : std_logic_vector(7 downto 0);
    signal RED_LED_TB     : std_logic;
    signal GREEN_LED_TB   : std_logic;
begin
    UUT : comparator
        port map(
            MESSAGE     => MESSAGE_TB,
            OUT_MESSAGE => OUT_MESSAGE_TB,
            RED_LED => RED_LED_TB,
            GREEN_LED => GREEN_LED_TB
        );

    process
    begin
        -- waiting for a little so it doesn't check the validation right away
        wait for 10 ns;
        for i in 0 to 30 loop
            
            -- assertions for the LED circuit
            wait for 5 ns;
            assert GREEN_LED_TB = '1'
            report "Invalid Character"
            severity error;

            wait for 5 ns;
            assert RED_LED_TB = '1'
            report "Valid Character"
            severity error;
            
            -- cycling through all of the values of an 8bit vector
            MESSAGE_REG <= MESSAGE_REG + 1;
            MESSAGE_TB     <= std_logic_vector(MESSAGE_REG);
            
        end loop;
        wait;

    end process;
end TEST;