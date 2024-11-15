library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity door_cont is
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
end entity door_cont;
architecture BEHAV of door_cont is

    type state_type is (door_closed, door_opening, door_open, door_closing, emergency);
    signal current_state, next_state : state_type;

    --signal for door open time
    signal timer_done  : std_logic;
    signal timer_start : std_logic;
    signal reset_timer : std_logic;

    --flashing the emergency state
    constant limit   : INTEGER                  := 62_500_000;
    signal count     : INTEGER RANGE 1 TO limit := 1;
    signal clock_div : STD_LOGIC                := '0';

    --emergency 
    signal emergency_timer_done  : std_logic;
    signal emergency_timer_start : std_logic;
    signal emergency_timer_reset : std_logic;

begin

    timer : entity work.timer
        port map(
            clk   => clk,
            reset => reset_timer,
            start => timer_start,
            done  => timer_done
        );

    emergency_timer : entity work.timer
        port map(
            clk   => clk,
            reset => emergency_timer_reset,
            start => emergency_timer_start,
            done  => emergency_timer_done
        );

    -- clock divider from code given in class
    clock_divider : PROCESS(clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF count < limit THEN
                count <= count + 1;
            ELSE
                count     <= 1;
                clock_div <= NOT clock_div;
            END IF;
        END IF;
    END PROCESS;

    process(clk, reset, force_open)
    begin
        if reset = '1' then
            current_state <= door_closed;
        elsif rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process;

    process(current_state, fully_closed, fully_open, motion_sensor, timer_done, clock_div, reset, emergency_timer_done, force_open)
    begin
        -- resets the flags for the timers between each state (for the state transitions that do not update timer flags)
        timer_start           <= '0';
        reset_timer           <= '0';
        emergency_timer_start <= '0';
        emergency_timer_reset <= '0';
        
        case current_state is
            when door_closed =>
                -- red led on
                door_rgb <= "100";
                -- motor stopped
                motor <= "00";
               
                
                if motion_sensor = '1' or force_open = '1' then
                    next_state <= door_opening;
                    emergency_timer_reset <= '1'; -- resetting emergency timer in closed state (not used here)     
                else
                    next_state <= door_closed;
                end if;

            when door_opening =>

                -- blue led on
                door_rgb <= "001";
                -- motor opening
                motor    <= "01";

                -- starting emergency timer when the door opens 
                emergency_timer_start <= '1';
                
                -- fix and make an or statement
                
                if emergency_timer_done = '1' then
                    next_state            <= emergency;
                elsif fully_open = '1' then
                    next_state  <= door_open;
                    reset_timer <= '1'; -- timer resets once we change state
                else
                    next_state <= door_opening;
                end if;

            when door_open =>

                -- green led on
                door_rgb    <= "010";
                --motor stopped
                motor       <= "00";
                timer_start <= '1';

                         
                if timer_done = '1' and motion_sensor = '0' and force_open = '0' then
                    next_state <= door_closing;
                    emergency_timer_reset <= '1';   -- reset emergency timer when in open state(not used here)
                else
                    next_state <= door_open;
                end if;

            when door_closing =>

                -- yellow led on
                door_rgb <= "110";
                -- motor closing
                motor    <= "10";

                --start the timer in this state
                emergency_timer_start <= '1';
                
                if motion_sensor = '1' or force_open = '1' then
                    next_state            <= door_opening; -- if the motion starts happening, the door is opening
                    emergency_timer_reset <= '1'; -- we need the emergency timer in door_closed
                elsif emergency_timer_done = '1' then -- emergency condition
                    next_state <= emergency;
                elsif fully_closed = '1' then -- if the door is fully closed move over to the next state
                    next_state <= door_closed;
                else
                    next_state <= door_closing;
                end if;

            when emergency =>
                door_rgb <= clock_div & "00"; -- flash the red led at 1Hz
                motor    <= "00";
                
                next_state <= emergency;
        end case;
    end process;

end architecture BEHAV;
