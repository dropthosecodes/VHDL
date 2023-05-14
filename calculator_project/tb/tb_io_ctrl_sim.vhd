-------------------------------------------------------------------------------
-- CALCULATOR PROJECT
-------------------------------------------------------------------------------
-- Author: Konstantin Haferl
--
-- Filename: tb_io_ctrl_sim.vhd
--
-- Date of Creation: 2023 05 01
--
-- Version: $Revision$
--
-- Design Unit: IO Control Unit (Testbench)
--
-- Description: The IO Control unit is part of the calculator project.
-- It manages the interface to the 7-segment displays, the LEDs, the push buttons
-- and the switches of the Digilent Basys3 FPGA board.
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

architecture sim of tb_io_ctrl is

  component io_ctrl
    port (--FPGA board:
          clk_i :         in std_logic;                       --100 MHz system clock
          reset_i :       in std_logic;                       --asynchronous reset (active high)
          sw_i :          in std_logic_vector(15 downto 0);   --state of 16 input switches
          pb_i :          in std_logic_vector(3 downto 0);    --state of 4 input push buttons
          ss_o :          out std_logic_vector(7 downto 0);   --8 Cathodes of an individual SS digit (active low)
          ss_sel_o :      out std_logic_vector(3 downto 0);   --Common Anodes of 4 SS digits (active low)
          led_o :         out std_logic_vector(15 downto 0);  --state of 16 LEDs

          --calc_ctrl:
          led_i :         in std_logic_vector(15 downto 0);   --state of 16 LEDs
          dig0_i :        in std_logic_vector(7 downto 0);    --8 Cathodes of SS digit0 (active low)
          dig1_i :        in std_logic_vector(7 downto 0);    --8 Cathodes of SS digit1 (active low)
          dig2_i :        in std_logic_vector(7 downto 0);    --8 Cathodes of SS digit2 (active low)
          dig3_i :        in std_logic_vector(7 downto 0);    --8 Cathodes of SS digit3 (active low)
          swsync_o :      out std_logic_vector(15 downto 0);  --state of 16 input switches
          pbsync_o :      out std_logic_vector(3 downto 0));  --state of 4 input push buttons
  end component;
  
  -- Declare the signals used stimulating the design's inputs.
  signal clk_i :      std_logic := '0';
  signal reset_i :    std_logic := '1';
  signal sw_i :       std_logic_vector(15 downto 0) := (others => '0');
  signal pb_i :       std_logic_vector(3 downto 0) := (others => '0');
  signal ss_o :       std_logic_vector(7 downto 0);
  signal ss_sel_o :   std_logic_vector(3 downto 0);
  signal led_o :      std_logic_vector(15 downto 0) := (others => '0'); 
  signal led_i :      std_logic_vector(15 downto 0) := (others => '0');
  signal dig0_i :     std_logic_vector(7 downto 0) := (others => '0');
  signal dig1_i :     std_logic_vector(7 downto 0) := (others => '0');
  signal dig2_i :     std_logic_vector(7 downto 0) := (others => '0');
  signal dig3_i :     std_logic_vector(7 downto 0) := (others => '0');
  signal swsync_o :   std_logic_vector(15 downto 0) := (others => '0');
  signal pbsync_o :   std_logic_vector(3 downto 0);

  
begin

  clk_i <= not clk_i after 5 ns;

  -- Instantiate the tb_io_ctrl design for testing
  i_tb_io_ctrl : io_ctrl
  port map
    (clk_i => clk_i,
     reset_i => reset_i,
     sw_i => sw_i,
     pb_i => pb_i,
     ss_o => ss_o,
     ss_sel_o => ss_sel_o,
     led_o => led_o,
     led_i => led_i,
     dig0_i => dig0_i,
     dig1_i => dig1_i,
     dig2_i => dig2_i,
     dig3_i => dig3_i,
     swsync_o => swsync_o,
     pbsync_o => pbsync_o);

  p_test : process
    begin
      reset_i <= '1';
      dig0_i <= "10000000";
      dig1_i <= "01000000";
      dig2_i <= "00100000";
      dig3_i <= "00010000";
      wait for 5 ms;
      reset_i <= '0';
      wait for 5 ms;
      led_i <= "0000111100001111";
      wait for 1 ms;
      led_i <= "1111000011110000";
      wait for 1 ms;
      led_i <= "0000111100001111";
      wait for 1 ms;
      pb_i <= "0010";
      sw_i <= "1000000000000001";
      wait for 100 ns;
      pb_i <= "0000";
      sw_i <= "0000000000000000";
      wait for 50 ns;
      pb_i <= "0001";
      sw_i <= "0000000000000001";
      wait for 7 ms;
      pb_i <= "0000";
      sw_i <= "0000000000000000";
      wait for 100 ns;
      pb_i <= "0001";
      sw_i <= "0000000000000001";
      wait for 100 ns;
      pb_i <= "0000";
      sw_i <= "0000000000000000";
      wait for 50 ns;
      pb_i <= "0001";
      sw_i <= "0000000000000001";
      wait for 20 ns;
      pb_i <= "0000";
      sw_i <= "0000000000000000";
      wait for 1000 ms;
    end process p_test;

end sim;