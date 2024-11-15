----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/11/2024 02:38:59 PM
-- Design Name: 
-- Module Name: lsfr_a - Behavioral
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

entity lsfr_b is
    Port ( reset : in STD_LOGIC;
           clock : in STD_LOGIC;
           enable : in STD_LOGIC;
           output : out STD_LOGIC_VECTOR(7 downto 0));
end lsfr_b;

architecture Behavioral of lsfr_b is

    signal num : STD_LOGIC_VECTOR(7 downto 0) := "11111111";

begin

    process(clock, reset)
    begin 
        if enable = '0' then 
            if reset = '1' then
                num <= "11111111";
                output <= num;
            elsif rising_edge(clock) then
                num(7) <= num(0);
                num(6) <= num(7);
                num(5) <= num(6) xor num(0);
                num(4) <= num(5) xor num(0);
                num(3) <= num(4) xor num(0);
                num(2) <= num(3);
                num(1) <= num(2);
                num(0) <= num(1) xor num(0);
                output <= num;
            end if;
            
       else
       end if;
    end process;
            

end Behavioral;
