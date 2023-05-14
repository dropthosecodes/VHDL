-------------------------------------------------------------------------------
-- CALCULATOR PROJECT
-------------------------------------------------------------------------------
-- Author: Konstantin Haferl
--
-- Filename: tb_calc_ctrl_sim.vhd
--
-- Date of Creation: 2023 05 01
--
-- Version: $Revision$
--
-- Design Unit: Calculator Control Unit (Testbench)
--
-- Description: The Calculator Control unit is part of the calculator project.
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

architecture sim of tb_calc_ctrl is

  component calc_ctrl
    port (clk_i :         in std_logic;                       --100 MHz system clock
          reset_i :       in std_logic;                       --asynchronous reset (active high)

          --alu:
          op1_o :         out std_logic_vector(11 downto 0);  --operand 1
          op2_o :         out std_logic_vector(11 downto 0);  --operand 2
          optype_o :      out std_logic_vector(3 downto 0);   --operator
          start_o :       out std_logic;                      --start signal
          result_i :      in std_logic_vector(15 downto 0);   --result from calculation
          finished_i :    in std_logic;                       --finished signal
          sign_i :        in std_logic;                       --signed flag
          overflow_i :    in std_logic;                       --overflow flag
          error_i :       in std_logic;                       --error flag

          --io_ctrl:
          led_o :         out std_logic_vector(15 downto 0);   --state of 16 LEDs
          dig0_o :        out std_logic_vector(7 downto 0);    --8 Cathodes of SS digit0 (active low)
          dig1_o :        out std_logic_vector(7 downto 0);    --8 Cathodes of SS digit1 (active low)
          dig2_o :        out std_logic_vector(7 downto 0);    --8 Cathodes of SS digit2 (active low)
          dig3_o :        out std_logic_vector(7 downto 0);    --8 Cathodes of SS digit3 (active low)
          swsync_i :      in std_logic_vector(15 downto 0);    --state of 16 input switches
          pbsync_i :      in std_logic_vector(3 downto 0));    --state of 4 input push buttons
  end component;
  
  -- Declare the signals used stimulating the design's inputs.
  signal clk_i :        std_logic := '0';
  signal reset_i :      std_logic := '1';
  signal op1_o :        std_logic_vector(11 downto 0);-- := (others => '0');
  signal op2_o :        std_logic_vector(11 downto 0);-- := (others => '0');
  signal optype_o :     std_logic_vector(3 downto 0);-- := (others => '0');  --add
  signal start_o :      std_logic;-- := '0';
  signal result_i :     std_logic_vector(15 downto 0) := (others => '0'); 
  signal finished_i :   std_logic := '0';
  signal sign_i :       std_logic := '0';
  signal overflow_i :   std_logic := '0';
  signal error_i :      std_logic := '0';
  signal led_o :        std_logic_vector(15 downto 0) := (others => '0');
  signal dig0_o :       std_logic_vector(7 downto 0) := (others => '0');
  signal dig1_o :       std_logic_vector(7 downto 0) := (others => '0');
  signal dig2_o :       std_logic_vector(7 downto 0) := (others => '0');
  signal dig3_o :       std_logic_vector(7 downto 0) := (others => '0');
  signal swsync_i :     std_logic_vector(15 downto 0) := (others => '0');
  signal pbsync_i :     std_logic_vector(3 downto 0) := (others => '0');
  
begin

  clk_i <= not clk_i after 5 ns;

  -- Instantiate the tb_calc_ctrl design for testing
  i_tb_calc_ctrl : calc_ctrl
  port map
    (clk_i => clk_i,
     reset_i => reset_i,
     op1_o => op1_o,
     op2_o => op2_o,
     optype_o => optype_o,
     start_o => start_o,
     result_i => result_i,
     finished_i => finished_i,
     sign_i => sign_i,
     overflow_i => overflow_i,
     error_i => error_i,
     led_o => led_o,
     dig0_o => dig0_o,
     dig1_o => dig1_o,
     dig2_o => dig2_o,
     dig3_o => dig3_o,
     swsync_i => swsync_i,
     pbsync_i => pbsync_i);

  p_test : process
    begin
      reset_i <= '1';
      result_i <= "0000111100001111";
      wait for 5 ms;
      reset_i <= '0';
      wait for 5 ms;
      finished_i <= '1';
      wait for 10 ns;
      finished_i <= '0';
      wait for 1 ms;
      pbsync_i <= "1000";
      wait for 10 ns;
      pbsync_i <= "0000";
      wait  for 100 ns;
      swsync_i <= "0000111100001001";
      result_i <= "0000111100000000";
      wait for 2 ms;
      pbsync_i <= "0100";
      wait for 10 ns;
      pbsync_i <= "0000";
      wait for 2 ms;
      pbsync_i <= "0010";
      wait for 10 ns;
      pbsync_i <= "0000";
      swsync_i <= "0001000000001111";
      wait for 2 ms;
      pbsync_i <= "0001";
      wait for 10 ns;
      pbsync_i <= "0000";
      wait for 2 ms;
      finished_i <= '1';
      wait for 100 ns;
      finished_i <= '0';
      wait for 1 ms;
      overflow_i <= '1';
      wait for 10 ms;
      overflow_i <= '0';
      wait for 100 ms;
    end process p_test;

end sim;