library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

architecture rtl of led_fsm is

  type t_state is (IDLE, BLINK, SHIFT_R, SHIFT_L);
  signal s_state : t_state;
  signal s_led_o : std_logic_vector(7 downto 0);

  begin
    p_led_fsm : process(clk_i, reset_i, en_i, start_i)
    begin
      if reset_i = '1' then
        s_state <= IDLE;
        s_led_o <= (others => '0');
      elsif clk_i'event and clk_i = '1' then
        case s_state is
          when IDLE =>
            s_led_o <= (others => '0');

            if start_i = '1' then
              if en_i = '1' then
                if fwd_bwd_i = '0' then
                  s_led_o <= "10000000";
                  s_state <= SHIFT_R;
                else
                  s_led_o <= "00000001";
                  s_state <= SHIFT_L;
                end if;
              else
                if fwd_bwd_i = '1' then
                  s_led_o <= (others => '1');
                  s_state <= BLINK;
                else
                  s_state <= IDLE;
                end if;
              end if; 
            else
              s_state <= IDLE;
            end if;

          when SHIFT_R =>
            if(s_led_o /= "00000000") then
              s_led_o <= std_logic_vector(shift_right(unsigned(s_led_o), 1));
            else
              s_state <= IDLE;
            end if;
              
          when SHIFT_L =>
            if(s_led_o /= "00000000") then
              s_led_o <= std_logic_vector(shift_left(unsigned(s_led_o), 1));
            else
              s_state <= IDLE;
            end if;
          
          when BLINK =>
            s_led_o <= (others => '0');
            s_state <= IDLE;

          when others => 
            s_state <= IDLE;
        end case;
      end if;
    end process p_led_fsm;
    led_o <= s_led_o;
end rtl;