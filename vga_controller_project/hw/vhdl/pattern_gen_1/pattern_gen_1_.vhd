-------------------------------------------------------------------------------
-- VGA CONTROLLER PROJECT
-------------------------------------------------------------------------------
-- Author: Konstantin Haferl
--
-- Filename: pattern_gen_1_.vhd
--
-- Date of Creation: 2023 09 19
--
-- Version: 1.0
--
-- Design Unit: Pattern Generator 1 (Entity)
--
-- Description: The Pattern Generator 1 is part of the VGA controller project.
-- It generates a pattern of Red-Green-Blue-Black columns on the 640x480 screen.
-- The columns are 40 pixels wide, therefore a total of 16 columns are generated.
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity pattern_gen_1 is
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

end pattern_gen_1;