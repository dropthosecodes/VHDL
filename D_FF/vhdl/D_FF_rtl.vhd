-------------------------------------------------------------------------------
--                                                                      
--                        D_FF task
--  
-------------------------------------------------------------------------------
--                                                                      
-- ENTITY:         D_FF
--
-- FILENAME:       D_FF_rtl.vhd
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
-- DESCRIPTION:    This is the architecture rtl of the D_FF
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

architecture rtl of D_FF is
  begin
    p_D_FF : process(clk_i, reset_i)
    begin
      if reset_i = '1' then
        q_o <= '0';
      elsif(clk_i'event and clk_i = '1') then
        q_o <= data_i;
      end if;
    end process p_D_FF;
  end rtl;