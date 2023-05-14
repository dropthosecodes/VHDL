-------------------------------------------------------------------------------
--                                                                      
--                        simplegate Task
--  
-------------------------------------------------------------------------------
--                                                                      
-- ENTITY:         tb_xorgate
--
-- FILENAME:       tb_xorgate_sim.vhd
-- 
-- ARCHITECTURE:   sim
-- 
-- ENGINEER:       Konstantin Haferl
--
-- DATE:           20.2.2023
--
-- VERSION:        1.0
--
-------------------------------------------------------------------------------
--                                                                      
-- DESCRIPTION:    This is the architecture of the xorgate testbench
--                 for the simplegate task.
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

architecture sim of tb_xorgate is

  component xorgate
  port (a_i :   in std_logic;      -- operand a
        b_i :   in std_logic;      -- operand b
        d_o :  out std_logic);     -- output d

  end component;
  
  -- Declare the signals used stimulating the design's inputs.
  signal a_i : std_logic;
  signal b_i : std_logic;
  signal d_o : std_logic;
  
begin

  -- Instantiate the simplegate design for testing
  i_xorgate : xorgate
  port map              
    (a_i   => a_i,
     b_i   => b_i,
     d_o   => d_o);

  p_test : process
    begin
      -- ZERO
      a_i <= '0';
      b_i <= '0';
      wait for 200 ns;
      -- ONE
      a_i <= '1';
      b_i <= '0';
      wait for 200 ns;
      -- TWO
      a_i <= '0';
      b_i <= '1';
      wait for 200 ns;
      -- THREE
      a_i <= '1';
      b_i <= '1';
      wait for 200 ns;
    end process;

end sim;