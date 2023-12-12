-------------------------------------------------------------------------------
-- VGA CONTROLLER PROJECT
-------------------------------------------------------------------------------
-- Author: Konstantin Haferl
--
-- Filename: vga_controller_top_.vhd
--
-- Date of Creation: 2023 11 06
--
-- Version: 1.0
--
-- Design Unit: Top-Level Design of the VGA Controller (Entity)
--
-- Description: This is the top-level design of the VGA Controller project.
-- It interconnects all sub-units and interfaces to the circuitry of the
-- Digilent Basys3 FPGA board.
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity vga_controller_top is
  port(--from FPGA board:
      reset_i :       in std_logic;                       --asynchronous reset (active high)
      clk_i :         in std_logic;                       --100 MHz system clock
      sw_i :          in std_logic_vector(5 downto 0);    --the 3 input switches
      pb_i :          in std_logic_vector(3 downto 0);    --the 4 input push buttons

      --to FPGA board:
      -- red_o :         out std_logic_vector(3 downto 0);   --red pixels (4 bit)
      -- green_o :       out std_logic_vector(3 downto 0);   --green pixels (4 bit)
      -- blue_o :        out std_logic_vector(3 downto 0);   --blue pixels (4 bit)

      rgb_o :         out std_logic_vector(11 downto 0);  --RGB signals
      hsync_o :       out std_logic;                      --horizontal sync 
      vsync_o :       out std_logic);                     --vertical sync

end vga_controller_top;