-------------------------------------------------------------------------------
--                                                                      
--                        D_FF task
--  
-------------------------------------------------------------------------------
--                                                                      
-- ENTITY:         tb_D_FF
--
-- FILENAME:       tb_D_FF_sim.vhd
-- 
-- ARCHITECTURE:   sim
-- 
-- ENGINEER:       Konstantin Haferl
--
-- DATE:           12.3.2023
--
-- VERSION:        1.0
--
-------------------------------------------------------------------------------
--                                                                      
-- DESCRIPTION:    This is the architecture of the D_FF testbench
--                 for the D_FF task.
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

architecture sim of tb_D_FF is

  component D_FF
    port (data_i :     in std_logic; 	  --data
          clk_i :      in std_logic;    --clock
          reset_i :    in std_logic;    --reset
          q_o :      out std_logic);  --data out
  end component;
  
  -- Declare the signals used stimulating the design's inputs.
  signal data_i :   std_logic;
  signal clk_i :    std_logic := '0';
  signal reset_i :  std_logic := '1';
  signal q_o :      std_logic;
  
begin

  clk_i <= not clk_i after 10 ns;
  reset_i <= '0' after 300 ns;

  -- Instantiate the tb_D_FF design for testing
  i_tb_D_FF : D_FF
  port map
    (data_i  => data_i,
     clk_i => clk_i,
     reset_i => reset_i,
     q_o => q_o);

  p_test : process
    begin
      data_i <= '0';
      wait for 100 ns;
      data_i <= '1';
      wait for 100 ns;
    end process p_test;

end sim;