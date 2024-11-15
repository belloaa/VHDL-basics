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

entity T_CASE_MODIFIER is
end T_CASE_MODIFIER;

architecture TEST of T_CASE_MODIFIER is

    component case_modifier
        port(
            MESSAGE      : in  std_logic_vector(7 downto 0);
            OUT_MESSAGE      : out std_logic_vector(7 downto 0)
        );
    end component case_modifier;
    
    signal MESSAGE_TB     : std_logic_vector(7 downto 0) := "01000001";
    signal MESSAGE_REG : unsigned(7 downto 0) := "01000001";
    signal OUT_MESSAGE_TB : std_logic_vector(7 downto 0);
    
 begin
     UUT : case_modifier
            port map(
                MESSAGE     => MESSAGE_TB,
                OUT_MESSAGE => OUT_MESSAGE_TB
            );
        process
        begin
        -- waiting for a little so it doesn't check the validation right away
        -- checking only capital letters
        for i in 0 to 25 loop
        wait for 5 ns;
            
            -- cycling through all of the relevant of the 8bit vector
            MESSAGE_REG <= MESSAGE_REG + 1;
            MESSAGE_TB     <= std_logic_vector(MESSAGE_REG);
            
        end loop;
        wait;

    end process;    
end TEST;