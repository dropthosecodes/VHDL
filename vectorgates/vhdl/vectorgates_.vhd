-------------------------------------------------------------------------------
--                                                                      
--                        vectorgates task
--  
-------------------------------------------------------------------------------
--                                                                      
-- ENTITY:         vectorgates
--
-- FILENAME:       vectorgates_.vhd
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
-- DESCRIPTION:    This is the entity declaration of the vectorgates
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

entity vectorgates is
  port (a_i :   in std_logic_vector(3 downto 0);       -- operand a
        b_i :   in std_logic_vector(3 downto 0);       -- operand b
        c_i :   in std_logic;                          -- operand c
        d_i :   in std_logic;                          -- operand d
        d_o :   out std_logic_vector(3 downto 0);      -- output d
        e_o :   out std_logic);                        -- output e
end vectorgates;

