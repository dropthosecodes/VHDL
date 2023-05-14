-------------------------------------------------------------------------------
--                                                                      
--                        JK_FF task
--  
-------------------------------------------------------------------------------
--                                                                      
-- ENTITY:         JK_FF
--
-- FILENAME:       JK_FF_rtl.vhd
-- 
-- ARCHITECTURE:   rtl
-- 
-- ENGINEER:       Konstantin Haferl
--
-- DATE:           13.3.2023
--
-- VERSION:        1.0
--
-------------------------------------------------------------------------------
--                                                                      
-- DESCRIPTION:    This is the architecture rtl of the JK_FF
--
-------------------------------------------------------------------------------
--
-- REFERENCES:     (none)
--
-------------------------------------------------------------------------------
--                                                                      
-- PACKAGES:       std_logic_1164 (IEEE library)
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

architecture rtl of JK_FF is

  signal s_data_i : std_logic;    --nicht temporär --> in Hardware: D-FF

  begin
    p_JK_FF : process(clk_i, reset_i)
    begin
      if reset_i = '1' then
        s_data_i <= '0';
      elsif(clk_i'event and clk_i = '1') then
        if j_i = '0' and k_i = '0' then
          s_data_i <= s_data_i;
        elsif j_i = '0' and k_i = '1' then
          s_data_i <= '0';
        elsif j_i = '1' and k_i = '0' then
          s_data_i <= '1';
        else
          s_data_i <= not(s_data_i);
        end if;
      end if;
    end process p_JK_FF;
    q_o <= s_data_i;
  end rtl;