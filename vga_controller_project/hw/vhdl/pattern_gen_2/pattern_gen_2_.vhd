-------------------------------------------------------------------------------
-- VGA CONTROLLER PROJECT
-------------------------------------------------------------------------------
-- Author: Konstantin Haferl
--
-- Filename: pattern_gen_2_.vhd
--
-- Date of Creation: 2023 09 22
--
-- Version: 1.0
--
-- Design Unit: Pattern Generator 2 (Entity)
--
-- Description: The Pattern Generator 2 is part of the VGA controller project.
-- It generates a pattern of Red, Green and Blue rectangles on the 640x480 screen.
-- There are 10 rectangles in each row and column, meaning each one has a size
-- of 64x48 pixels. For each row the colors are shifted to the left once recangle wide.
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity pattern_gen_2 is
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

end pattern_gen_2;