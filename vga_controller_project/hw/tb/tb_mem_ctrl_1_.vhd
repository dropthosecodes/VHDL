-------------------------------------------------------------------------------
-- VGA CONTROLLER PROJECT
-------------------------------------------------------------------------------
-- Author: Konstantin Haferl
--
-- Filename: tb_mem_ctrl_1_.vhd
--
-- Date of Creation: 2023 09 22
--
-- Version: 1.0
--
-- Design Unit: Memory Controller 1 (Testbench)
--
-- Description: The Memory Controller 1 is part of the VGA controller project.
-- The Memory Controller 1 generates addresses for a ROM where a 320x240x12bit
-- image is stored.
-- The Controller uses the x and y coordinates of the current pixel as input 
-- to calculate the necessary address in the ROM. Since the image is only a
-- quarter of the size of the actual 640x480 screen, it shall be displayed 4 times.
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_mem_ctrl_1 is
end tb_mem_ctrl_1;

