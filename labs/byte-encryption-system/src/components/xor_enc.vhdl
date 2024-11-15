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

entity xor_enc is
    port(
        MESSAGE     : in  std_logic_vector(7 downto 0);
        KEY         : in  std_logic_vector(7 downto 0);
        OUT_MESSAGE : out std_logic_vector(7 downto 0)
    );
end entity xor_enc;

architecture BEHAV of xor_enc is
    
begin
    -- xor for encryption w/ key
    encrypt : process(MESSAGE, KEY)
    begin
            OUT_MESSAGE <= (MESSAGE xor KEY);
    end process encrypt;
	
end architecture BEHAV;
	