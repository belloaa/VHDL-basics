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

entity case_modifier is
  port(
    MESSAGE     : in  std_logic_vector(7 downto 0);
    OUT_MESSAGE : out std_logic_vector(7 downto 0)
  );
end entity case_modifier;

architecture BEHAV of case_modifier is
begin
  process(MESSAGE)
  begin
    -- changing the case of the character by inverting one bit only if we have a valid character input
    if MESSAGE /= "00000000" then
      OUT_MESSAGE <= MESSAGE(7 downto 6) & not MESSAGE(5) & MESSAGE(4 downto 0);
    else
      OUT_MESSAGE <= "00000000";
    end if;
  end process;
end architecture BEHAV;
