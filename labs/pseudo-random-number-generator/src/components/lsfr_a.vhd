library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity lsfr_a is
    Port ( reset : in STD_LOGIC;
           clock : in STD_LOGIC;
           enable : in STD_LOGIC;
           output : out STD_LOGIC_VECTOR(7 downto 0));
end lsfr_a;

architecture Behavioral of lsfr_a is

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
                num(6) <= num(7) xor num(0);
                num(5) <= num(6);
                num(4) <= num(5);
                num(3) <= num(4);
                num(2) <= num(3) xor num(0);
                num(1) <= num(2) xor num(0);
                num(0) <= num(1) xor num(0);
                output <= num;
            end if;
        else
        end if;
    end process;
            

end Behavioral;
