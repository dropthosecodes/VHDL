-------------------------------------------------------------------------------
--                                                                      
--                        decoder_3bit task
--  
-------------------------------------------------------------------------------
--                                                                      
-- ENTITY:         tb_decoder_3bit
--
-- FILENAME:       tb_decoder_3bit_sim.vhd
-- 
-- ARCHITECTURE:   sim
-- 
-- ENGINEER:       Konstantin Haferl
--
-- DATE:           27.2.2023
--
-- VERSION:        1.0
--
-------------------------------------------------------------------------------
--                                                                      
-- DESCRIPTION:    This is the architecture of the decoder_3bit testbench
--                 for the decoder_3bit task.
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

architecture sim of tb_decoder_3bit is

  component decoder_3bit
    port (data_i :   in std_logic_vector(2 downto 0); 	    --data in
          data_o :   out std_logic_vector(7 downto 0));     --data out
  end component;
  
  -- Declare the signals used stimulating the design's inputs.
  signal data_i : std_logic_vector(2 downto 0);
  signal data_o : std_logic_vector(7 downto 0);
  
begin

  -- Instantiate the tb_decoder_3bit design for testing
  i_tb_decoder_3bit : decoder_3bit
  port map
    (data_i  => data_i,
     data_o => data_o);

  p_test : process
    begin
      data_i <= "000";
      wait for 100 ns;
      data_i <= "001";
      wait for 100 ns;
      data_i <= "010";
      wait for 100 ns;
      data_i <= "011";
      wait for 100 ns;
      data_i <= "100";
      wait for 100 ns;
      data_i <= "101";
      wait for 100 ns;
      data_i <= "110";
      wait for 100 ns;
      data_i <= "111";
      wait for 100 ns;
    end process p_test;

end sim;