-------------------------------------------------------------------------------
--                                                                      
--                        simplegate task
--  
-------------------------------------------------------------------------------
--                                                                      
-- ENTITY:         xorgate
--
-- FILENAME:       xorgate_.vhd
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
-- DESCRIPTION:    This is the entity declaration of the xorgate
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

entity xorgate is
  port (a_i :   in std_logic;       -- operand a
        b_i :   in std_logic;       -- operand b
        d_o :   out std_logic);     -- output d
end xorgate;

