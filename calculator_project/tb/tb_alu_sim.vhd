-------------------------------------------------------------------------------
-- CALCULATOR PROJECT
-------------------------------------------------------------------------------
-- Author: Konstantin Haferl
--
-- Filename: tb_alu_sim.vhd
--
-- Date of Creation: 2023 05 05
--
-- Version: $Revision$
--
-- Design Unit: ALU (Testbench)
--
-- Description: The ALU is part of the calculator project.
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

architecture sim of tb_alu is

  component alu
    port (clk_i :         in std_logic;                        --100 MHz system clock
          reset_i :       in std_logic;                        --asynchronous reset (active high)

          --calc_ctrl:
          op1_i :         in std_logic_vector(11 downto 0);    --operand 1
          op2_i :         in std_logic_vector(11 downto 0);    --operand 2
          optype_i :      in std_logic_vector(3 downto 0);     --operator
          start_i :       in std_logic;                        --start signal

          result_o :      out std_logic_vector(15 downto 0);   --result from calculation
          finished_o :    out std_logic;                       --finished signal
          sign_o :        out std_logic;                       --signed flag
          overflow_o :    out std_logic;                       --overflow flag
          error_o :       out std_logic);                      --error flag
  end component;
  
  -- Declare the signals used stimulating the design's inputs.
  signal clk_i :        std_logic := '0';
  signal reset_i :      std_logic := '1';

  signal op1_i :        std_logic_vector(11 downto 0) := (others => '0');
  signal op2_i :        std_logic_vector(11 downto 0) := (others => '0');
  signal optype_i :     std_logic_vector(3 downto 0) := (others => '0');  --add
  signal start_i :      std_logic := '0';
  
  signal result_o :     std_logic_vector(15 downto 0) := (others => '0'); 
  signal finished_o :   std_logic := '0';
  signal sign_o :       std_logic := '0';
  signal overflow_o :   std_logic := '0';
  signal error_o :      std_logic := '0';

begin

  clk_i <= not clk_i after 5 ns;

  -- Instantiate the tb_alu design for testing
  i_tb_alu : alu
  port map
    (clk_i => clk_i,
     reset_i => reset_i,
     op1_i => op1_i,
     op2_i => op2_i,
     optype_i => optype_i,
     start_i => start_i,
     result_o => result_o,
     finished_o => finished_o,
     sign_o => sign_o,
     overflow_o => overflow_o,
     error_o => error_o);

  p_test : process
    begin
      reset_i <= '1';
      op1_i <= "111111111111";
      op2_i <= "110000000011";
      optype_i <= "1001"; --AND
      wait for 1 ms;
      reset_i <= '0';
      wait for 1 ms;
      wait for 5 ns;
      start_i <= '1';
      wait for 10 ns;
      start_i <= '0';
      wait for 2 ms;
      op1_i <= "000000000000";
      wait for 3 ms;
      op1_i <= "111111111111";
      op2_i <= "111111111111";
      optype_i <= "0000"; --ADD
      start_i <= '1';
      wait for 10 ns;
      start_i <= '0';
      wait for 5 ms;
      op1_i <= "100000000001";
      optype_i <= "1100"; --ROL
      start_i <= '1';
      wait for 10 ns;
      start_i <= '0';
      wait for 5 ms;
      op1_i <= "000000000000";
      op2_i <= "000000001111";
      optype_i <= "0001"; --SUB
      start_i <= '1';
      wait for 10 ns;
      start_i <= '0';
      wait for 5 ms;
      op1_i <= "000000100000";
      op2_i <= "000000000101";
      optype_i <= "0100"; --RE
      start_i <= '1';
      wait for 10 ns;
      start_i <= '0';
      wait for 20 ms;
    end process p_test;


end sim;