-------------------------------------------------------------------------------
--                                                                      
--                        adder_8bit task
--  
-------------------------------------------------------------------------------
--                                                                      
-- ENTITY:         adder_8bit
--
-- FILENAME:       adder_8bit.vhd
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
-- DESCRIPTION:    This is the entity declaration of the adder_8bit
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

entity adder_8bit is
  generic (N : natural := 8);
  port (data0_i :   in std_logic_vector(N-1 downto 0);    --data0
        data1_i :   in std_logic_vector(N-1 downto 0);    --data1
        sum_o :     out std_logic_vector(N-1 downto 0);   --sum
        cy_o :      out std_logic);                       --carry out
end adder_8bit;

