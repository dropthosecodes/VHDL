-- Testbench for clock generator test design
-- FPGA device/board: Xilinx Artix-7 on Digilent Basys3 board
-- Author: Peter Roessler
-- Date: 2016-02-01 

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_test_clkgen is
end tb_test_clkgen;

architecture sim of tb_test_clkgen is

-- clock generator test design
component test_clkgen is
  port(
    s_osc_i  : in  std_logic;
    s_btnr_i : in  std_logic;
    s_led0_o : out std_logic
    );
end component;

signal s_osc_i : std_logic;
signal s_btnr_i : std_logic;
signal s_led0_o : std_logic;

begin

  -- simulate 100 MHz clock oscillator
  p_osc : process
  begin
    loop
      s_osc_i <= '0';
      wait for 5 ns;
      s_osc_i <= '1';
      wait for 5 ns;
    end loop;
  end process p_osc;

  -- instantiate clock generator test design
  i_test_clkgen : test_clkgen
    port map(
      s_osc_i  => s_osc_i,
      s_btnr_i => s_btnr_i,
      s_led0_o => s_led0_o
      );

  -- timing of simulation
  p_tb : process
  begin
    -- apply reset for 5 clock cycles
    s_btnr_i <= '1';
    wait for 5*20 ns;
    s_btnr_i <= '0';

    -- wait until end of simulation
    wait;
  end process;

end sim;
