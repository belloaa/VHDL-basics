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

entity T_BARREL_MUX is
end T_BARREL_MUX;

architecture TEST of T_BARREL_MUX is

    component barrel_mux
        port(
            SHIFT_AMOUNT : in  std_logic_vector(2 downto 0);
            MESSAGE      : in  std_logic_vector(7 downto 0);
            DIRECTION    : in  std_logic;
            OUT_MESSAGE      : out std_logic_vector(7 downto 0)
        );
    end component barrel_mux;
    
    signal SHIFT_AMOUNT_REG : unsigned(2 downto 0) := "000";
    signal SHIFT_AMOUNT_TB :std_logic_vector(2 downto 0);
    signal MESSAGE_TB     : std_logic_vector(7 downto 0) := "11110000";
    signal OUT_MESSAGE_TB : std_logic_vector(7 downto 0);
    signal DIRECTION_TB   : std_logic := '1';
    
begin
    UUT : barrel_mux
        port map(
            SHIFT_AMOUNT     => SHIFT_AMOUNT_TB,
            MESSAGE => MESSAGE_TB,
            DIRECTION => DIRECTION_TB,
            OUT_MESSAGE => OUT_MESSAGE_TB
        );

    process
    begin
        -- waiting for a little so it doesn't check the validation right away
            for i in 0 to 7 loop
            wait for 5 ns;
            -- cycling through all of the values of an 8bit vector
            SHIFT_AMOUNT_REG <= SHIFT_AMOUNT_REG + 1;
            SHIFT_AMOUNT_TB  <= std_logic_vector(SHIFT_AMOUNT_REG);
      
        end loop;
        wait;

    end process;
end TEST;