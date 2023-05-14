-------------------------------------------------------------------------------
--                                                                      
--                        vectorgates task
--  
-------------------------------------------------------------------------------
--                                                                      
-- ENTITY:         vectorgates
--
-- FILENAME:       vectorgates_rtl.vhd
-- 
-- ARCHITECTURE:   rtl
-- 
-- ENGINEER:       Konstantin Haferl
--
-- DATE:           27.2.2023
--
-- VERSION:        1.0
--
-------------------------------------------------------------------------------
--                                                                      
-- DESCRIPTION:    This is the architecture rtl of the vectorgates
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

architecture rtl of vectorgates is
  begin
  d_o(3 downto 2) <= a_i(3 downto 2) and b_i(3 downto 2);    -- generate the output d_o high word
  d_o(1 downto 0) <= a_i(1 downto 0) or b_i(1 downto 0);     -- generate the output d_o low word
  e_o <= c_i xor d_i;                                        -- generate the output e_o
  end rtl;