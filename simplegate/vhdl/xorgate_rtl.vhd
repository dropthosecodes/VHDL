-------------------------------------------------------------------------------
--                                                                      
--                        simplegate task
--  
-------------------------------------------------------------------------------
--                                                                      
-- ENTITY:         xorgate
--
-- FILENAME:       xorgate_rtl.vhd
-- 
-- ARCHITECTURE:   rtl
-- 
-- ENGINEER:       Konstantin Haferl
--
-- DATE:           20.2.2023
--
-- VERSION:        1.0
--
-------------------------------------------------------------------------------
--                                                                      
-- DESCRIPTION:    This is the architecture rtl of the xorgate
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
--                                                                      
-- CHANGES:        Version 1.0 - KH - 20.2.2023
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

architecture rtl of xorgate is
  begin
  d_o <= a_i xor b_i;     -- generate the output d_o
  end rtl;