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

entity system_barrel is
    port(
        MESSAGE     : in  std_logic_vector(7 downto 0);
        KEY         : in  std_logic_vector(7 downto 0);
        DIRECTION   : in  std_logic;
        RED_LED     : out std_logic;
        GREEN_LED   : out std_logic;
        OUT_MESSAGE : out std_logic_vector(7 downto 0)
    );
end entity system_barrel;

architecture BEHAV of system_barrel is
    signal COMP_MESSAGE  : std_logic_vector(7 downto 0);
    signal SHIFT_AMOUNT  : std_logic_vector(2 downto 0);
    signal ROT_MESSAGE   : std_logic_vector(7 downto 0);
    signal UNROT_MESSAGE : std_logic_vector(7 downto 0);
    signal ENC_MESSAGE   : std_logic_vector(7 downto 0);
    signal DEC_MESSAGE   : std_logic_vector(7 downto 0);
    signal REV_DIRECTION : std_logic;

begin
    
    --intializing signals, rev direction for decrypting
    REV_DIRECTION <= not DIRECTION;
    -- taking the last 3 bits for the shift amount
    SHIFT_AMOUNT <= KEY(2 downto 0);

    comparator : entity work.comparator
        port map(
            MESSAGE     => MESSAGE,
            OUT_MESSAGE => COMP_MESSAGE,
            RED_LED     => RED_LED,
            GREEN_LED   => GREEN_LED
        );
    
    barrelshift1 : entity work.barrel_mux
        port map(
            SHIFT_AMOUNT => SHIFT_AMOUNT,
            MESSAGE      => COMP_MESSAGE,
            DIRECTION    => DIRECTION,
            OUT_MESSAGE  => ROT_MESSAGE
        );

    encrypt_xor : entity work.xor_enc
        port map(
            MESSAGE     => ROT_MESSAGE,
            KEY         => KEY,
            OUT_MESSAGE => ENC_MESSAGE
        );

    decrypt_xor : entity work.xor_enc
        port map(
            MESSAGE     => ENC_MESSAGE,
            KEY         => KEY,
            OUT_MESSAGE => DEC_MESSAGE
        );

    barrelshift2 : entity work.barrel_mux
        port map(
            SHIFT_AMOUNT => SHIFT_AMOUNT,
            MESSAGE      => DEC_MESSAGE,
            DIRECTION    => REV_DIRECTION,
            OUT_MESSAGE  => OUT_MESSAGE
        );

end architecture BEHAV;
