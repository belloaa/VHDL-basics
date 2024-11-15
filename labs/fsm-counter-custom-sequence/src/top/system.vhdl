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
    port( 
        reset : in STD_LOGIC;
        clock : in STD_LOGIC;
        enable : in STD_LOGIC;
        mode_sel : in STD_LOGIC;
        segments : out STD_LOGIC_VECTOR(6 DOWNTO 0);
        display_select : out STD_LOGIC
    );
end entity system;

architecture Behavioral of system is
    constant limit : INTEGER := 31_250_000;
    signal count : INTEGER RANGE 1 TO limit:= 1;
    signal clock_div : STD_LOGIC := '0';
    signal sig_out : STD_LOGIC_VECTOR(3 downto 0);

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

    counter : entity work.counter
        port map(
            clk => clock_div,
            enable => enable,
            reset => reset,
            mode_sel => mode_sel,
            sig_out => sig_out
        );
        
    display : entity work.display_controller
        port map(
            digits => sig_out,
            clock => clock,
            segments => segments,
            display_select => display_select
        );

end Behavioral;
