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

entity T_XOR_ENC is
end T_XOR_ENC;

architecture TEST of T_XOR_ENC is

    component xor_enc
        port(
            MESSAGE     : in  std_logic_vector(7 downto 0);
            KEY         : in  std_logic_vector(7 downto 0);
            OUT_MESSAGE : out std_logic_vector(7 downto 0)
        );
    end component xor_enc;
    
    constant KEY_TB         : std_logic_vector(7 downto 0) := "00010110";

    signal MESSAGE_REG : unsigned(7 downto 0)         := "00000000";
    signal MESSAGE_TB     : std_logic_vector(7 downto 0) := "00000000";
    signal OUT_MESSAGE_TB : std_logic_vector(7 downto 0);
begin
    UUT : xor_enc
        port map(
            MESSAGE     => MESSAGE_TB,
            KEY         => KEY_TB,
            OUT_MESSAGE => OUT_MESSAGE_TB
        );

    process
    begin
        -- waiting for a little so it doesn't check the validation right away
        wait for 10 ns;
        for i in 0 to 255 loop

            -- validating encryption and decryption
            assert OUT_MESSAGE_TB = (MESSAGE_TB xor KEY_TB)
            report "Encryption/Decryption incorrect"
            severity error;

            -- cycling through all of the values of an 8bit vector
            MESSAGE_REG <= MESSAGE_REG + 1;
            MESSAGE_TB     <= std_logic_vector(MESSAGE_REG);
            wait for 10 ns;

        end loop;
        wait;

    end process;
end TEST;