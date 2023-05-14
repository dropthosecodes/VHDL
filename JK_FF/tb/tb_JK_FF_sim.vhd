-------------------------------------------------------------------------------
--                                                                      
--                        JK_FF task
--  
-------------------------------------------------------------------------------
--                                                                      
-- ENTITY:         tb_JK_FF
--
-- FILENAME:       tb_JK_FF_sim.vhd
-- 
-- ARCHITECTURE:   sim
-- 
-- ENGINEER:       Konstantin Haferl
--
-- DATE:           13.3.2023
--
-- VERSION:        1.0
--
-------------------------------------------------------------------------------
--                                                                      
-- DESCRIPTION:    This is the architecture of the JK_FF testbench
--                 for the JK_FF task.
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

architecture sim of tb_JK_FF is

  component JK_FF
  port (j_i :       in std_logic;    --j_data
        k_i :       in std_logic; 	 --k_data
        clk_i :     in std_logic;    --clock
        reset_i :   in std_logic;    --reset
        q_o :       out std_logic);  --data out
  end component;
  
  -- Declare the signals used stimulating the design's inputs.
  signal j_i:       std_logic;
  signal k_i:       std_logic;
  signal clk_i :    std_logic := '0';   --default value
  signal reset_i :  std_logic := '1';   --default value
  signal q_o :      std_logic;
  
begin

  clk_i <= not clk_i after 10 ns;
  reset_i <= '0' after 300 ns;

  -- Instantiate the tb_D_FF design for testing
  i_tb_JK_FF : JK_FF
  port map
    (j_i  => j_i,
     k_i => k_i,
     clk_i => clk_i,
     reset_i => reset_i,
     q_o => q_o);

  p_test : process
    begin
      j_i <= '0';
      k_i <= '0';
      wait for 100 ns;
      j_i <= '1';
      k_i <= '0';
      wait for 100 ns;
      j_i <= '0';
      k_i <= '1';
      wait for 100 ns;
      j_i <= '1';
      k_i <= '1';
      wait for 100 ns;
    end process p_test;

end sim;