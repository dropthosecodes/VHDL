-------------------------------------------------------------------------------
--                                                                      
--                        JK_FF task
--  
-------------------------------------------------------------------------------
--                                                                      
-- ENTITY:         JK_FF
--
-- FILENAME:       JK_FF.vhd
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
-- DESCRIPTION:    This is the entity declaration of the JK_FF
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

entity JK_FF is
  port (j_i :       in std_logic;    --j_data
        k_i :       in std_logic; 	 --k_data
        clk_i :     in std_logic;    --clock
        reset_i :   in std_logic;    --reset
        q_o :       out std_logic);  --data out
end JK_FF;

