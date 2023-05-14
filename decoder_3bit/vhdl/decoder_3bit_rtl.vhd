-------------------------------------------------------------------------------
--                                                                      
--                        decoder_3bit task
--  
-------------------------------------------------------------------------------
--                                                                      
-- ENTITY:         decoder_3bit
--
-- FILENAME:       decoder_3bit_rtl.vhd
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
-- DESCRIPTION:    This is the architecture rtl of the decoder_3bit
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

architecture rtl of decoder_3bit is
  begin
    p_decoder_3bit : process(data_i)
    begin
      case data_i is
        when "000" => data_o <= "00000001";
        when "001" => data_o <= "00000010";
        when "010" => data_o <= "00000100";
        when "011" => data_o <= "00001000";
        when "100" => data_o <= "00010000";
        when "101" => data_o <= "00100000";
        when "110" => data_o <= "01000000";
        when "111" => data_o <= "10000000";
        when others => data_o <= "00000000";
      end case;
    end process p_decoder_3bit;
  end rtl;