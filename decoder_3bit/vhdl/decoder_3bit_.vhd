-------------------------------------------------------------------------------
--                                                                      
--                        decoder_3bit task
--  
-------------------------------------------------------------------------------
--                                                                      
-- ENTITY:         decoder_3bit
--
-- FILENAME:       decoder_3bit.vhd
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
-- DESCRIPTION:    This is the entity declaration of the decoder_3bit
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

entity decoder_3bit is
  port (data_i :   in std_logic_vector(2 downto 0); 	    --data in
        data_o :   out std_logic_vector(7 downto 0));     --data out
end decoder_3bit;

