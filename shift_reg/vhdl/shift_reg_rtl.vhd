library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

architecture rtl of shift_reg is

  signal s_q_o : std_logic_vector(3 downto 0);

  begin
    p_shift_reg : process(clk_i, reset_i)
    begin
      if reset_i = '1' then
        s_q_o <= "0000";
      elsif clk_i'event and clk_i = '1' then
        if en_i = '1' then
          if sh_i = '1' then
            s_q_o <= std_logic_vector(shift_left(unsigned(s_q_o), 1));
          else
            s_q_o <= d_i;
          end if;
        else s_q_o <= s_q_o;
        end if;
      end if;
    end process p_shift_reg;
    q_o <= s_q_o;
  end rtl;