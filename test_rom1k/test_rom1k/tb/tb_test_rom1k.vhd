-- Testbench for "1k ROM" test design
-- FPGA device/board: Xilinx Artix-7 on Digilent Basys3 board
-- Author: Peter Roessler
-- Date: 2016-02-02 

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_test_rom1k is
end tb_test_rom1k;

architecture sim of tb_test_rom1k is

-- "1k ROM" test design
component test_rom1k is
  port(
    s_clk_i      : in  std_logic;
    s_rst_i      : in  std_logic;
    s_inc_fast_i : in  std_logic;
    s_led_o      : out std_logic_vector(9 downto 0)
    );
end component;

signal s_clk_i : std_logic;
signal s_rst_i : std_logic;
signal s_inc_fast_i : std_logic;
signal s_led_o : std_logic_vector(9 downto 0);

begin

  -- simulate 100 MHz clock oscillator
  p_clk : process
  begin
    loop
      s_clk_i <= '0';
      wait for 5 ns;
      s_clk_i <= '1';
      wait for 5 ns;
    end loop;
  end process p_clk;

  -- instantiate "1k ROM" test design
  i_test_rom1k : test_rom1k
    port map(
      s_clk_i      => s_clk_i,
      s_rst_i      => s_rst_i,
      s_inc_fast_i => s_inc_fast_i,
      s_led_o      => s_led_o
      );

  -- timing of simulation
  p_tb : process
  begin
    -- count fast (to speed up simulation)
    s_inc_fast_i <= '1';

    -- apply reset for 5 clock cycles
    s_rst_i <= '1';
    wait for 5*20 ns;
    s_rst_i <= '0';

    -- wait until end of simulation
    wait;
  end process;

end sim;
