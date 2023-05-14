-------------------------------------------------------------------------------
-- CALCULATOR PROJECT
-------------------------------------------------------------------------------
-- Author: Konstantin Haferl
--
-- Filename: calc_top_.vhd
--
-- Date of Creation: 2023 05 05
--
-- Version: $Revision$
--
-- Design Unit: Top-level Design of Calculator (Entity)
--
-- Description: This is the top-level design of the calculator project.
-- It interconnects the sub-units 'IO control unit', 'calculator
-- control unit' and 'arithmetic logic unit' and interfaces to
-- the circuitry of the Digilent Basys3 FPGA board.
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity calc_top is
  port (clk_i :         in std_logic;                       --100 MHz system clock
        reset_i :       in std_logic;                       --asynchronous reset (active high)
        sw_i :          in std_logic_vector(15 downto 0);   --state of 16 input switches
        pb_i :          in std_logic_vector(3 downto 0);    --state of 4 input push buttons
        ss_o :          out std_logic_vector(7 downto 0);   --8 Cathodes of an individual SS digit (active low)
        ss_sel_o :      out std_logic_vector(3 downto 0);   --Common Anodes of 4 SS digits (active low)
        led_o :         out std_logic_vector(15 downto 0));  --state of 16 LEDs
end calc_top;