------------------------------------------------------------------------
-- University  : University of Alberta
-- Course      : ECE 410: Advanced Digital Logic Design
-- Project     : Door Controller
-- Authors     : Abdul Bello, Alastair Cottier
-- Students ID : 1664803, 1668621
-- Date        : 11/08/2024
------------------------------------------------------------------------
-- Description : Testing Basic Door operations.
------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity door_basic_operation_tb is
end entity door_basic_operation_tb;

architecture test of door_basic_operation_tb is
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
        -- Initial reset
        reset <= '1';
        wait_cycles(5);
        reset <= '0';
        wait_cycles(5);

        -------------------------------------------------------------------------------
        -- test 1: normal opening
        report "Test 1: Normal opening sequence";
        motion_sensor <= '1';
        wait_cycles(5);
        
        -- assert statements to check normal opening sequence
        if motor = "01" then
            report "GOOD: Motor is opening";
        else 
            assert false report "BAD: Motor should be opening" severity error;
        end if;

        if door_rgb = "001" then
            report "GOOD: RGB is blue";
        else 
            assert false report "BAD: RGB is the wrong color" severity error;
        end if;
        
        wait_cycles(20); 
        fully_open <= '1'; -- heading into open state
        wait_cycles(5); 
        
        -- assert statements to check open state
        if motor = "00" then 
            report "GOOD: Motor is stopped";
        else 
            assert false report "BAD: Motor is still on" severity error;
        end if;

        if door_rgb = "010" then
            report "GOOD: RGB is green";
        else 
            assert false report "BAD: RGB is the wrong color" severity error;
        end if;

        -------------------------------------------------------------------------------
        -- test case 2: closing
        report "Test Case 2: Normal closing sequence";
        motion_sensor <= '0'; 
        wait_cycles(50);  -- wait for timer

        -- should be heading into door closing
        fully_open <= '0';
        wait_cycles(20);
        
        -- door should be closing
        if motor = "10" then 
            report "GOOD: Motor is closing";
        else 
            assert false report "BAD: Motor should be closing" severity error;
        end if;

        if door_rgb = "110" then
            report "GOOD: RGB is yellow";
        else 
            assert false report "BAD: RGB is the wrong color" severity error;
        end if;
        
        fully_closed <= '1'; --heading into door closed state
        wait_cycles(5);
        
        -- door should be closed
        if motor = "00" then 
            report "GOOD: Motor is off";
        else 
            assert false report "BAD: Motor should be off" severity error;
        end if;

        if door_rgb = "100" then
            report "GOOD: RGB is yellow";
        else 
            assert false report "BAD: RGB is the wrong color" severity error;
        end if;

        report "Done the basic tests";
        wait;
    end process;

end architecture test;