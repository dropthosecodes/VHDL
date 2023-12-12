-------------------------------------------------------------------------------
-- VGA CONTROLLER PROJECT
-------------------------------------------------------------------------------
-- Author: Konstantin Haferl
--
-- Filename: tb_io_logic_sim_.vhd
--
-- Date of Creation: 2023 09 19
--
-- Version: 1.0
--
-- Design Unit: IO Logic Unit (Testbench)
--
-- Description: The IO Logic Unit is part of the VGA controller project
-- It handles the debouncing of the push buttons as well as the three switches SW0, SW1 and SW2.
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

architecture sim of tb_io_logic is

  component io_logic
    port (--from FPGA board
          reset_i :       in std_logic;                       --asynchronous reset (active high)
          clk_i :         in std_logic;                       --100 MHz system clock
          sw_i :          in std_logic_vector(5 downto 0);    --the 3 input switches
          pb_i :          in std_logic_vector(3 downto 0);    --the 4 input push buttons

          --to source multiplexer
          sw_o :      out std_logic_vector(5 downto 0);   --state of the 3 input switches
          pb_o :      out std_logic_vector(3 downto 0));  --state of the 4 input push buttons (debounced)

  end component;
  
  -- Declare the signals used stimulating the design's inputs.
  signal clk_i :      std_logic := '0';
  signal reset_i :    std_logic := '1';
  signal sw_i :       std_logic_vector(5 downto 0) := (others => '0');
  signal pb_i :       std_logic_vector(3 downto 0) := (others => '0');
  signal sw_o :       std_logic_vector(5 downto 0) := (others => '0');
  signal pb_o :       std_logic_vector(3 downto 0);

begin

  clk_i <= not clk_i after 5 ns;

  -- Instantiate the tb_io_logic design for testing
  i_tb_io_logic : io_logic
  port map
    (clk_i => clk_i,
     reset_i => reset_i,
     sw_i => sw_i,
     pb_i => pb_i,
     sw_o => sw_o,
     pb_o => pb_o);

  p_test : process
    begin
      wait for 1 ms;
      reset_i <= '0';
      wait for 1 ms;
      pb_i <= "0010";
      sw_i <= "000100";
      wait for 100 ns;
      pb_i <= "0000";
      sw_i <= "000000";
      wait for 1 ms;
      pb_i <= "1000";
      wait for 2 ms;
      pb_i <= "0000";
      wait;
    end process p_test;

end sim;