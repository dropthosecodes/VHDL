-- Test design for clock generator 
-- FPGA device/board: Xilinx Artix-7 on Digilent Basys3 board
-- Author: Peter Roessler
-- Date: 2017-02-01 

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned."+";

entity test_clkgen is
  port(
    s_osc_i  : in  std_logic; -- 100 MHz clock (coming from board's clock oscillator)
    s_btnr_i : in  std_logic; -- push button BTNR (reset button) 
    s_led0_o : out std_logic  -- LED0
    );
end test_clkgen;

architecture rtl of test_clkgen is

-- Clock generator (generated via Xilinx Vivado IP Catalog/Clocking Wizard)
component clkgen is
  port(
    clk_in1  : in  std_logic; -- 100 MHz clock input
    clk_out1 : out std_logic; -- 10 MHz clock output
    reset    : in  std_logic; -- high-active reset input 
    locked   : out std_logic  -- "PLL locked" output, showing that signal clk_out1 is stable
    );
end component;

-- internal signals
signal s_rst_n : std_logic;
signal s_clk : std_logic;
signal s_ledcnt : std_logic_vector(22 downto 0); 

begin

  -- instantiate clock generator
  i_clkgen : clkgen
    port map(
      clk_in1  => s_osc_i,
      clk_out1 => s_clk,
      reset    => s_btnr_i, 
      locked   => s_rst_n -- use "PLL locked" signal as reset signal for remaining logic
      );

  -- LED counter
  p_ledcnt : process (s_clk, s_rst_n)
  begin
    if (s_rst_n='0') then
      s_ledcnt <= (others => '0');
    elsif (s_clk'event and s_clk='1') then
      s_ledcnt <= s_ledcnt + '1';
    end if;
  end process p_ledcnt;
  
  -- LED0 flashes with a frequency of 1.2 Hz 
  -- (assuming that LED counter is clocked with 10 MHz)
  s_led0_o <= s_ledcnt(22);
          
end rtl;
