library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity door_force_open_operation_tb is
end entity door_force_open_operation_tb;

architecture test of door_force_open_operation_tb is
    -- Component declaration
    component door_cont is
        port(
            clk           : in  std_logic;
            motion_sensor : in  std_logic;
            reset         : in  std_logic;
            force_open    : in  std_logic;
            fully_open    : in  std_logic;
            fully_closed  : in  std_logic;
            door_rgb      : out std_logic_vector(2 downto 0);
            motor         : out std_logic_vector(1 downto 0)
        );
    end component;

    -- Signal declarations
    signal clk           : std_logic := '0';
    signal motion_sensor : std_logic := '0';
    signal reset         : std_logic := '0';
    signal force_open    : std_logic := '0';
    signal fully_open    : std_logic := '0';
    signal fully_closed  : std_logic := '0';
    signal door_rgb      : std_logic_vector(2 downto 0);
    signal motor         : std_logic_vector(1 downto 0);

    constant CLK_PERIOD : time := 8 ns;
    constant TIMER_CYCLES : integer := 50;
    
    -- links the waits to the clock
    procedure wait_cycles(n: integer) is
    begin
        for i in 1 to n loop
            wait until rising_edge(clk);
        end loop;
    end procedure;

begin
    -- Clock generation
    clock_gen: process
    begin
        clk <= '0';
        wait for CLK_PERIOD/2;
        clk <= '1';
        wait for CLK_PERIOD/2;
    end process;

    -- DUT instantiation
    DUT: door_cont
    port map (
        clk           => clk,
        motion_sensor => motion_sensor,
        reset         => reset,
        force_open    => force_open,
        fully_open    => fully_open,
        fully_closed  => fully_closed,
        door_rgb      => door_rgb,
        motor         => motor
    );

    -- Test process
    process
    begin
        -- initial reset
        reset <= '1';
        wait_cycles(5);
        reset <= '0';
        wait_cycles(5);

        -------------------------------------------------------------------------------
        -- test 1: force open from closed state
        report "Test 1: Force open from closed state";
        fully_closed <= '1';
        wait_cycles(5);
        force_open <= '1';
        wait_cycles(5);
        
        if motor = "01" then
            report "GOOD: Motor is opening";
        else 
            assert false report "BAD: Motor should be opening" severity error;
        end if;

        if door_rgb = "001" then
            report "GOOD: RGB is blue during forced opening";
        else 
            assert false report "BAD: RGB should be blue during forced opening" severity error;
        end if;
        
        fully_closed <= '0';
        wait_cycles(20);
        fully_open <= '1';
        wait_cycles(5);

        -------------------------------------------------------------------------------
        -- test 2: Force open  during closing
        report "Test 2: Force open  during closing";
        force_open <= '0';
        wait_cycles(TIMER_CYCLES);
        fully_open <= '0';
        wait_cycles(10);
        
        -- force open during closing
        force_open <= '1';
        wait_cycles(5);
        
        if motor = "01" then
            report "GOOD: Motor is opening";
        else 
            assert false report "BAD: Motor should be opening" severity error;
        end if;

        -------------------------------------------------------------------------------
        -- Test 3: Maintain open state with force open
        report "Test 3: Maintain open state with force open";
        fully_open <= '1';
        wait_cycles(TIMER_CYCLES * 2);
        
        if motor = "00" then
            report "GOOD: Motor remains stopped when forced open";
        else 
            assert false report "BAD: Motor should remain stopped with force open" severity error;
        end if;

        if door_rgb = "010" then
            report "GOOD: RGB stays green in open";
        else 
            assert false report "BAD: RGB should stay green with force open" severity error;
        end if;

        -------------------------------------------------------------------------------
        -- Test 4: Release force open
        report "Test 4: Release force open";
        force_open <= '0';
        wait_cycles(TIMER_CYCLES);
        
        if motor = "10" then
            report "GOOD: Motor starts closing after force open release";
        else 
            assert false report "BAD: Motor should start closing after force open release" severity error;
        end if;

        report "Done the force open tests";
        wait;
    end process;

end architecture test;