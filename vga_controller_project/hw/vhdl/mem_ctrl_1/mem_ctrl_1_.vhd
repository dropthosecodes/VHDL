-------------------------------------------------------------------------------
-- VGA CONTROLLER PROJECT
-------------------------------------------------------------------------------
-- Author: Konstantin Haferl
--
-- Filename: mem_ctrl_1_.vhd
--
-- Date of Creation: 2023 09 22
--
-- Version: 1.0
--
-- Design Unit: Memory Controller 1 (Entity)
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
use IEEE.numeric_std.all;

entity mem_ctrl_1 is
  port (--from FPGA board
        reset_i :       in std_logic;                       --asynchronous reset (active high)
        clk_i :         in std_logic;                       --100 MHz system clock

        --from prescaler
        pixel_en_i :    in std_logic;                       --25 MHz pixel enable clock

        --from VGA control
        pixel_x_i :     in unsigned(9 downto 0);            --horizonal pixel coordinates
        pixel_y_i :     in unsigned(9 downto 0);            --vertical pixel coordinated
        pixel_valid_i : in std_logic;                       --shows if the pixel coordinates are valid (in range of the actual screen)
        
        --to source multiplexer:
        rgb_o :         out std_logic_vector(11 downto 0)); --color information for a given pixel

end mem_ctrl_1;