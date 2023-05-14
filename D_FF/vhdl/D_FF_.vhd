-------------------------------------------------------------------------------
--                                                                      
--                        D_FF task
--  
-------------------------------------------------------------------------------
--                                                                      
-- ENTITY:         D_FF
--
-- FILENAME:       D_FF.vhd
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
-- DESCRIPTION:    This is the entity declaration of the D_FF
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

entity D_FF is
  port (data_i :     in std_logic; 	  --data
        clk_i :      in std_logic;    --clock
        reset_i :    in std_logic;    --reset
        q_o :      out std_logic);  --data out
end D_FF;

