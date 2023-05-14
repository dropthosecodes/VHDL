-------------------------------------------------------------------------------
--                                                                      
--                        adder_8bit task
--  
-------------------------------------------------------------------------------
--                                                                      
-- ENTITY:         adder_8bit
--
-- FILENAME:       adder_8bit_rtl.vhd
-- 
-- ARCHITECTURE:   rtl
-- 
-- ENGINEER:       Konstantin Haferl
--
-- DATE:           20.3.2023
--
-- VERSION:        1.0
--
-------------------------------------------------------------------------------
--                                                                      
-- DESCRIPTION:    This is the architecture rtl of the adder_8bit
--
-------------------------------------------------------------------------------
--
-- REFERENCES:     (none)
--
-------------------------------------------------------------------------------
--                                                                      
-- PACKAGES:       std_logic_1164 (IEEE library)
--                 std_logic_arith (IEEE library)
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
--use IEEE.numeric_std.all;

architecture rtl of adder_8bit is
  signal s_sum : unsigned(N downto 0);    --D-FF
  begin
    --s_sum <= conv_unsigned(unsigned(data0_i) + unsigned(data1_i), N+1); --cy_o verschwindet
    s_sum <= unsigned(data0_i) + conv_unsigned(unsigned(data1_i), N+1);
    cy_o <= s_sum(N);
    sum_o <= std_logic_vector(s_sum(N-1 downto 0));
end rtl;