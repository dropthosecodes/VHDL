-------------------------------------------------------------------------------
--                                                                      
--                        adder_8bit task
--  
-------------------------------------------------------------------------------
--                                                                      
-- ENTITY:         tb_adder_8bit
--
-- FILENAME:       tb_adder_8bit_sim.vhd
-- 
-- ARCHITECTURE:   sim
-- 
-- ENGINEER:       Konstantin Haferl
--
-- DATE:           20.3.2023
--
-- VERSION:        1.0
--
-------------------------------------------------------------------------------
--                                                                      
-- DESCRIPTION:    This is the architecture of the adder_8bit testbench
--                 for the adder_8bit task.
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

architecture sim of tb_adder_8bit is

  constant L : integer := 8;

  component adder_8bit
    generic (N : natural := L);
    port (data0_i :   in std_logic_vector(N-1 downto 0);    --data0
          data1_i :   in std_logic_vector(N-1 downto 0);    --data1
          sum_o :     out std_logic_vector(N-1 downto 0);   --sum
          cy_o :      out std_logic);                       --carry out
  end component;
  
  -- Declare the signals used stimulating the design's inputs.
  signal data0_i:     std_logic_vector(L-1 downto 0) := "00000000";
  signal data1_i:     std_logic_vector(L-1 downto 0) := "00000000";
  signal sum_o :      std_logic_vector(L-1 downto 0) := "00000000";
  signal cy_o :       std_logic;
  
begin

  -- Instantiate the tb_adder_8bit design for testing
  i_tb_adder_8bit : adder_8bit
  port map
    (data0_i  => data0_i,
     data1_i => data1_i,
     sum_o => sum_o,
     cy_o => cy_o);

  p_test : process
    begin
      data0_i <= "00000000";
      data1_i <= "00000000";
      wait for 100 ns;
      data0_i <= "00000001";
      data1_i <= "11111111";
      wait for 100 ns;
      data0_i <= "00010000";
      data1_i <= "11111111";
      wait for 100 ns;
      data0_i <= "11111111";
      data1_i <= "00000000";
      wait for 100 ns;
      data0_i <= "11111111";
      data1_i <= "11111111";
      wait for 100 ns;
    end process p_test;

end sim;