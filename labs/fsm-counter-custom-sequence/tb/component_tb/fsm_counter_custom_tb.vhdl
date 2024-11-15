library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter_tb is
end counter_tb;

architecture TEST of counter_tb is
    component counter
        port(
            clk      : in  std_logic;
            enable   : in  std_logic;
            reset    : in  std_logic;
            mode_sel : in  std_logic;
            sig_out  : out std_logic_vector(3 downto 0)
        );
    end component counter;

    signal clk      : std_logic := '0';
    signal enable   : std_logic := '1';
    signal reset    : std_logic := '0';
    signal mode_sel : std_logic := '1';
    signal sig_out  : std_logic_vector(3 downto 0);

    constant CLK_PERIOD : time := 10 ns;
    
    -- links the waits to the clock
    procedure wait_cycles(n: integer) is
    begin
        for i in 1 to n loop
            wait until rising_edge(clk);
        end loop;
    end procedure;
    

begin
    -- Clock generation
    clk <= not clk after CLK_PERIOD/2;

    -- DUT instantiation
    UUT : counter
        port map(
            clk      => clk,
            enable   => enable,
            reset    => reset,
            mode_sel => mode_sel,
            sig_out  => sig_out
        );

    process
    begin
        -------------------------------------------------------------------------------
        -- Test 1: Custom Sequence Mode
        report "Test 1: Starting custom sequence mode (mode_sel = 1)";
        mode_sel <= '1';
        enable <= '1';
        
        -- Let it run through all states
        wait_cycles(16);

        -------------------------------------------------------------------------------
        -- Test 2: Up Counter Mode
        report "Test 2: Starting up counter mode (mode_sel = 0)";
        mode_sel <= '0';
        
        -- Let it count up through all values
        wait_cycles(16);

        -------------------------------------------------------------------------------
        -- Test 3: Enable Control
        report "Test 3: Testing enable control";
        enable <= '0';
        wait_cycles(5);

        enable <= '1';
        wait_cycles(5);
        -------------------------------------------------------------------------------
        -- Test 4: Reset During Operation
        report "Test 4: Testing reset during operation";
        wait_cycles(5);
        reset <= '1';
        wait_cycles(5);
        reset <= '0';

        -------------------------------------------------------------------------------
        -- Test 5: Mode Switching
        report "Test 5: Testing mode switching";
        wait_cycles(10);
        mode_sel <= '1';
        report "Custom sequence mode";
        wait_cycles(10);
        mode_sel <= '0';
        report "Counter mode";
        wait_cycles(11);

        report "Done testing counter state transitions";
        wait;
    end process;

end architecture TEST;


