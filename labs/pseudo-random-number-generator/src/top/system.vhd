----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/11/2024 04:02:37 PM
-- Design Name: 
-- Module Name: system - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity system is
    Port ( reset : in STD_LOGIC;
           clock : in STD_LOGIC;
           mode_sel : in STD_LOGIC;
           segments : out STD_LOGIC_VECTOR(6 DOWNTO 0);
           display_select : out STD_LOGIC);
end system;

architecture Behavioral of system is
    constant limit : INTEGER := 31_250_000;
    signal count : INTEGER RANGE 1 TO limit:= 1;
    signal clock_div : STD_LOGIC := '0';
    signal shift_out : STD_LOGIC_VECTOR(7 downto 0);
    
begin

	clock_divider : PROCESS (clock)
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

    lsfr_a : entity work.lsfr_a
        port map(
            enable => mode_sel,
            reset => reset,
            clock => clock_div,
            output => shift_out
        );
        
        
    display : entity work.display_controller
        port map(
            digits => shift_out,
            clock => clock,
            segments => segments,
            display_select => display_select
        );

end Behavioral;
