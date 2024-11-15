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

entity barrel_mux is
  port(
    SHIFT_AMOUNT : in  std_logic_vector(2 downto 0);
    MESSAGE      : in  std_logic_vector(7 downto 0);
    DIRECTION    : in  std_logic;
    OUT_MESSAGE      : out std_logic_vector(7 downto 0)
  );
end entity barrel_mux;

architecture BEHAV of barrel_mux is
begin
  process(SHIFT_AMOUNT, DIRECTION, MESSAGE)
  begin
    if DIRECTION = '0' then -- left shift
      case SHIFT_AMOUNT is
        when "000"  => OUT_MESSAGE <= MESSAGE;
        when "001"  => OUT_MESSAGE <= MESSAGE(6 downto 0) & MESSAGE(7);
        when "010"  => OUT_MESSAGE <= MESSAGE(5 downto 0) & MESSAGE(7 downto 6);
        when "011"  => OUT_MESSAGE <= MESSAGE(4 downto 0) & MESSAGE(7 downto 5);
        when "100"  => OUT_MESSAGE <= MESSAGE(3 downto 0) & MESSAGE(7 downto 4);
        when "101"  => OUT_MESSAGE <= MESSAGE(2 downto 0) & MESSAGE(7 downto 3);
        when "110"  => OUT_MESSAGE <= MESSAGE(1 downto 0) & MESSAGE(7 downto 2);
        when "111"  => OUT_MESSAGE <= MESSAGE(0) & MESSAGE(7 downto 1);
        when others => OUT_MESSAGE <= MESSAGE;
      end case;
    elsif DIRECTION = '1' then -- right shift
      case SHIFT_AMOUNT is
        when "000"  => OUT_MESSAGE <= MESSAGE;
        when "001"  => OUT_MESSAGE <= MESSAGE(0) & MESSAGE(7 downto 1);
        when "010"  => OUT_MESSAGE <= MESSAGE(1 downto 0) & MESSAGE(7 downto 2);
        when "011"  => OUT_MESSAGE <= MESSAGE(2 downto 0) & MESSAGE(7 downto 3);
        when "100"  => OUT_MESSAGE <= MESSAGE(3 downto 0) & MESSAGE(7 downto 4);
        when "101"  => OUT_MESSAGE <= MESSAGE(4 downto 0) & MESSAGE(7 downto 5);
        when "110"  => OUT_MESSAGE <= MESSAGE(5 downto 0) & MESSAGE(7 downto 6);
        when "111"  => OUT_MESSAGE <= MESSAGE(6 downto 0) & MESSAGE(7);
        when others => OUT_MESSAGE <= MESSAGE;
      end case;
    end if;
  end process;
end architecture BEHAV;