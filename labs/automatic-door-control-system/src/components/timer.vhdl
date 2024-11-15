------------------------------------------------------------------------
-- University  : University of Alberta
-- Course      : ECE 410: Advanced Digital Logic Design
-- Project     : Door Controller
-- Authors     : Abdul Bello, Alastair Cottier
-- Students ID : 1664803, 1668621
-- Date        : 11/08/2024
------------------------------------------------------------------------
-- Description : Timer, countrs to 5 seconds
------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity timer is
    port(
        clk   : in  std_logic;
        reset : in  std_logic;
        start : in  std_logic;
        done  : out std_logic           -- done signal that goes high after the set time is reached
    );
end entity timer;

architecture BEHAV of timer is
    constant CLK_FREQ      : integer := 125_000_000; -- zybo Z7 clock freq
    signal counter         : integer := 0; -- internal counter
    -- FOR SIMULATION
    --signal cycles_required : integer := 50; -- 100 us in simulation -- the number of clock cycles required for the desired time
    -- signal to control the desired time in seconds
    signal time_s : unsigned(31 downto 0) := to_unsigned(5, 32); -- default time set to 5 seconds
    signal cycles_required : integer := to_integer(time_s) * CLK_FREQ;

begin
    
    process(clk, reset)
    begin
        if reset = '1' then
            counter <= 0;
            done    <= '0';
        elsif rising_edge(clk) then
            if start = '1' then
                if counter < cycles_required - 1 then -- minus one because we start counting from 0 not 1
                    counter <= counter + 1;
                    done    <= '0';
                else
                    done <= '1';        -- signal that the timer is done
                end if;
            else
                counter <= 0;
                done    <= '0';
            end if;
        end if;
    end process;

end architecture BEHAV;
