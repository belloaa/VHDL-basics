library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
    port(
        clk      : in  std_logic;
        enable   : in  std_logic;
        reset    : in  std_logic;
        mode_sel : in  std_logic;
        sig_out  : out std_logic_vector(3 downto 0)
    );
end entity counter;

architecture BEHAV of counter is

    signal count : unsigned(3 downto 0) := "0000";

    type state_type is (state_0, state_1, state_2, state_3, state_4, state_5, state_6, state_7, state_8, state_9, state_10, state_11, state_12, state_13, state_14, state_15);
    signal current_state, next_state : state_type;

begin
    process(clk, reset)
    begin
        if reset = '1' then
            
            current_state <= state_0;
            count         <= (others => '0');
            sig_out <= (others => '0');

        elsif rising_edge(clk) then

            current_state <= next_state;
            sig_out <= std_logic_vector(count);

            if mode_sel = '1' then
                case next_state is
                    when state_0 =>
                        count <= "0000";
                    when state_1 =>
                        count <= "0111";
                    when state_2 =>
                        count <= "1100";
                    when state_3 =>
                        count <= "1011";
                    when state_4 =>
                        count <= "0110";
                    when state_5 =>
                        count <= "0001";
                    when state_6 =>
                        count <= "1111";
                    when state_7 =>
                        count <= "1000";
                    when state_8 =>
                        count <= "0011";
                    when state_9 =>
                        count <= "1101";
                    when state_10 =>
                        count <= "1010";
                    when state_11 =>
                        count <= "0100";
                    when state_12 =>
                        count <= "1001";
                    when state_13 =>
                        count <= "0010";
                    when state_14 =>
                        count <= "0101";
                    when state_15 =>
                        count <= "1110";
                end case;
            else
                if enable = '1' then
                    count <= count + 1;
                end if;
            end if;
        end if;
    end process;

    process(current_state, enable, mode_sel)
    begin
        case current_state is
            when state_0 =>
                if enable = '1' and mode_sel = '1' then
                    next_state <= state_1;
                else
                    next_state <= state_0;
                end if;

            when state_1 =>
                if enable = '1' and mode_sel = '1' then
                    next_state <= state_2;
                else
                    next_state <= state_1;
                end if;

            when state_2 =>
                if enable = '1' and mode_sel = '1' then
                    next_state <= state_3;
                else
                    next_state <= state_2;
                end if;

            when state_3 =>
                if enable = '1' and mode_sel = '1' then
                    next_state <= state_4;
                else
                    next_state <= state_3;
                end if;

            when state_4 =>
                if enable = '1' and mode_sel = '1' then
                    next_state <= state_5;
                else
                    next_state <= state_4;
                end if;

            when state_5 =>
                if enable = '1' and mode_sel = '1' then
                    next_state <= state_6;
                else
                    next_state <= state_5;
                end if;

            when state_6 =>
                if enable = '1' and mode_sel = '1' then
                    next_state <= state_7;
                else
                    next_state <= state_6;
                end if;

            when state_7 =>
                if enable = '1' and mode_sel = '1' then
                    next_state <= state_8;
                else
                    next_state <= state_7;
                end if;

            when state_8 =>
                if enable = '1' and mode_sel = '1' then
                    next_state <= state_9;
                else
                    next_state <= state_8;
                end if;

            when state_9 =>
                if enable = '1' and mode_sel = '1' then
                    next_state <= state_10;
                else
                    next_state <= state_9;
                end if;

            when state_10 =>
                if enable = '1' and mode_sel = '1' then
                    next_state <= state_11;
                else
                    next_state <= state_10;
                end if;

            when state_11 =>
                if enable = '1' and mode_sel = '1' then
                    next_state <= state_12;
                else
                    next_state <= state_11;
                end if;

            when state_12 =>
                if enable = '1' and mode_sel = '1' then
                    next_state <= state_13;
                else
                    next_state <= state_12;
                end if;

            when state_13 =>
                if enable = '1' and mode_sel = '1' then
                    next_state <= state_14;
                else
                    next_state <= state_13;
                end if;

            when state_14 =>
                if enable = '1' and mode_sel = '1' then
                    next_state <= state_15;
                else
                    next_state <= state_14;
                end if;

            when state_15 =>
                if enable = '1' and mode_sel = '1' then
                    next_state <= state_0;
                else
                    next_state <= state_15;
                end if;
        end case;
    end process;

end architecture BEHAV;