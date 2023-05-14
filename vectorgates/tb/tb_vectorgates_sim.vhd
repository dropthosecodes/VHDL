-------------------------------------------------------------------------------
--                                                                      
--                        vectorgates task
--  
-------------------------------------------------------------------------------
--                                                                      
-- ENTITY:         tb_vectorgates
--
-- FILENAME:       tb_vectorgates_sim.vhd
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
-- DESCRIPTION:    This is the architecture of the vectorgates testbench
--                 for the vectorgates task.
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

architecture sim of tb_vectorgates is

  component vectorgates
    port (a_i :   in std_logic_vector(3 downto 0);       -- operand a
          b_i :   in std_logic_vector(3 downto 0);       -- operand b
          c_i :   in std_logic;                          -- operand c
          d_i :   in std_logic;                          -- operand d
          d_o :   out std_logic_vector(3 downto 0);      -- output d
          e_o :   out std_logic);                        -- output e
  end component;
  
  -- Declare the signals used stimulating the design's inputs.
  signal a_i : std_logic_vector(3 downto 0);
  signal b_i : std_logic_vector(3 downto 0);
  signal c_i : std_logic;
  signal d_i : std_logic;
  signal d_o : std_logic_vector(3 downto 0);
  signal e_o : std_logic;
  
begin

  -- Instantiate the vectorgates design for testing
  i_vectorgates : vectorgates
  port map         
    (a_i  => a_i,
     b_i  => b_i,
     c_i  => c_i,
     d_i  => d_i,
     d_o  => d_o,
     e_o => e_o);

  p_test : process
    begin
      a_i <= "0000";
      b_i <= "0000";
      c_i <= '0';
      d_i <= '0';
      wait for 200 ns;
      a_i <= "0000";
      b_i <= "1111";
      c_i <= '0';
      d_i <= '1';
      wait for 200 ns;
      a_i <= "1111";
      b_i <= "0000";
      c_i <= '1';
      d_i <= '0';
      wait for 200 ns;
      a_i <= "1111";
      b_i <= "1111";
      c_i <= '1';
      d_i <= '1';
      wait for 200 ns;

    end process;

end sim;