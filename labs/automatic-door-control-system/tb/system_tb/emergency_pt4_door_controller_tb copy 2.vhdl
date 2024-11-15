------------------------------------------------------------------------
-- University  : University of Alberta
-- Course      : ECE 410: Advanced Digital Logic Design
-- Project     : Door Controller
-- Authors     : Abdul Bello, Alastair Cottier
-- Students ID : 1664803, 1668621
-- Date        : 11/08/2024
------------------------------------------------------------------------
-- Description : Testing Emergency Door operations.
------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity door_emergency_operation_tb is
end entity door_emergency_operation_tb;

architecture test of door_emergency_operation_tb is
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
        -- test 1: Emergency during opening
        report "Test 1: Emergency during opening";
        motion_sensor <= '1';
        wait_cycles(5);
        
        -- start opening but then emergency timer runs out
        wait_cycles(TIMER_CYCLES + 1); 
        
        -- check emergency state
        if motor = "00" then
            report "GOOD: Motor stopped in emergency state";
        else 
            assert false report "BAD: Motor should be stopped in emergency" severity error;
        end if;

        -- reset
        reset <= '1';
        wait_cycles(5);
        reset <= '0';
        wait_cycles(5);

        -------------------------------------------------------------------------------
        -- test 2: Emergency during closing
        report "Test 2: Emergency during closing";
        -- get to open state first
        motion_sensor <= '1';
        wait_cycles(20);

        
        fully_open <= '1';
        wait_cycles(5);
        motion_sensor <= '0';
        wait_cycles(TIMER_CYCLES);
        
        -- start closing but then emergency timer runs out
        fully_open <= '0';
        wait_cycles(TIMER_CYCLES + 1);
        
        -- check emergency state
        if motor = "00" then
            report "GOOD: Motor stopped in emergency state";
        else 
            assert false report "BAD: Motor should be stopped in emergency" severity error;
        end if;

        -------------------------------------------------------------------------------
        -- test 3: LED flashing in emergency
        report "Test 3: LED flashing in emergency";
        wait_cycles(10);
        
        -- check if LED is flashing (will alternate between "100" and "000")
        if door_rgb = "100" or door_rgb = "000" then
            report "GOOD: Emergency LED is flashing";
        else
            assert false report "BAD: Emergency LED should be flashing red" severity error;
        end if;

        -------------------------------------------------------------------------------
        -- test 4: Recovery from emergency
        report "Test 4: Recovery from emergency";
        reset <= '1';
        wait_cycles(5);
        
        if motor = "00" and door_rgb = "100" then
            report "GOOD: System is in closed state";
        else
            assert false report "BAD: System did not recover from emergency" severity error;
        end if;

        report "Done the emergency tests";
        wait;
    end process;

end architecture test;