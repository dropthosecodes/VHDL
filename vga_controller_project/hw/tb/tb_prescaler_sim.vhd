-------------------------------------------------------------------------------
-- VGA CONTROLLER PROJECT
-------------------------------------------------------------------------------
-- Author: Konstantin Haferl
--
-- Filename: tb_prescaler_sim.vhd
--
-- Date of Creation: 2023 09 19
--
-- Version: 1.0
--
-- Design Unit: Prescaler (Testbench)
--
-- Description: The prescaler is part of the VGA controller project
-- It manages ...
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

architecture sim of tb_prescaler is

  component prescaler
    port (--from FPGA board:
          clk_i :         in std_logic;                       --100 MHz system clock
          reset_i :       in std_logic;                      --asynchronous reset (active high)
  
          --to all other components
          pixel_en_o :      out std_logic);                   --25 MHz pixel enable clock

  end component;
  
  -- Declare the signals used stimulating the design's inputs.
  signal clk_i :      std_logic := '0';
  signal reset_i :    std_logic := '1';
  signal pixel_en_o : std_logic := '0';
  
begin

  clk_i <= not clk_i after 5 ns;

  -- Instantiate the tb_prescaler design for testing
  i_tb_prescaler : prescaler
  port map
    (clk_i => clk_i,
     reset_i => reset_i,
     pixel_en_o => pixel_en_o);

  p_test : process
    begin
      reset_i <= '1';
      wait for 20 ns;
      reset_i <= '0';
      wait;
    end process p_test;

end sim;