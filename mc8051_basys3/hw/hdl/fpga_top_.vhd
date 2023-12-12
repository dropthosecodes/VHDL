-- MC8051 IP Core Demo Design, Top-level Entity
-- FPGA device/board: Xilinx Artix-7 on Digilent Basys3 board
-- Author: Peter Roessler
-- Date: 2017-02-08

library IEEE; 
use IEEE.std_logic_1164.all; 

library work;
use work.mc8051_p.all;

entity fpga_top is
  port (
        clk   : in  std_logic;                   -- 100 MHz clock signal coming from clock oscillator
        reset : in  std_logic;                   -- reset signal coming from buuton BTNC
        led_o : out std_logic_vector(7 downto 0) -- 8 LEDs LED0 - LED7
       );
end fpga_top;
