-------------------------------------------------------------------------------
-- CALCULATOR PROJECT
-------------------------------------------------------------------------------
-- Author: Konstantin Haferl
--
-- Filename: tb_calc_top_sim.vhd
--
-- Date of Creation: 2023 05 05
--
-- Version: $Revision$
--
-- Design Unit: Top-level Design of Calculator (Testbench)
--
-- Description: This is the top-level design of the calculator project.
-- It interconnects the sub-units 'IO control unit', 'calculator
-- control unit' and 'arithmetic logic unit' and interfaces to
-- the circuitry of the Digilent Basys3 FPGA board.
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

architecture sim of tb_calc_top is

  component calc_top
    port (clk_i :         in std_logic;                       --100 MHz system clock
          reset_i :       in std_logic;                       --asynchronous reset (active high)
          sw_i :          in std_logic_vector(15 downto 0);   --state of 16 input switches
          pb_i :          in std_logic_vector(3 downto 0);    --state of 4 input push buttons
          ss_o :          out std_logic_vector(7 downto 0);   --8 Cathodes of an individual SS digit (active low)
          ss_sel_o :      out std_logic_vector(3 downto 0);   --Common Anodes of 4 SS digits (active low)
          led_o :         out std_logic_vector(15 downto 0));  --state of 16 LEDs
  end component;
  
  -- Declare the signals used stimulating the design's inputs.
  signal clk_i :      std_logic := '0';
  signal reset_i :    std_logic := '1';
  signal sw_i :       std_logic_vector(15 downto 0) := (others => '0');
  signal pb_i :       std_logic_vector(3 downto 0) := (others => '0');
  signal ss_o :       std_logic_vector(7 downto 0);
  signal ss_sel_o :   std_logic_vector(3 downto 0);
  signal led_o :      std_logic_vector(15 downto 0);-- := (others => '0'); 

begin

  clk_i <= not clk_i after 5 ns;

  -- Instantiate the tb_calc_top design for testing
  i_tb_calc_top : calc_top
  port map
    (clk_i => clk_i,
    reset_i => reset_i,
    sw_i => sw_i,
    pb_i => pb_i,
    ss_o => ss_o,
    ss_sel_o => ss_sel_o,
    led_o => led_o);

  p_test : process
    begin
      reset_i <= '1';
      wait for 5 ms;
      reset_i <= '0';
      wait for 10 ms;
      pb_i <= "1000";
      wait for 1 ms;
      pb_i <= "0000";
      wait for 1 ms;
      sw_i <= "1111111111111111";
      wait for 10 ms;
      pb_i <= "0100";
      wait for 1 ms;
      pb_i <= "0000";
      wait for 1 ms;
      sw_i <= "0000001100010011";
      wait for 10 ms;
      pb_i <= "0010";
      wait for 1 ms;
      pb_i <= "0000";
      wait for 1 ms;
      sw_i <= "1001000000000011";
      wait for 10 ms;
      pb_i <= "0001";
      wait for 1 ms;
      pb_i <= "0000";
      wait for 20 ms;
    end process p_test;

end sim;