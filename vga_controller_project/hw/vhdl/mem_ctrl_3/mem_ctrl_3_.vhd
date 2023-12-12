-------------------------------------------------------------------------------
-- VGA CONTROLLER PROJECT
-------------------------------------------------------------------------------
-- Author: Konstantin Haferl
--
-- Filename: mem_ctrl_3_.vhd
--
-- Date of Creation: 2023 11 15
--
-- Version: 1.0
--
-- Design Unit: Memory Controller 3 (Entity)
--
-- Description: The Memory Controller 3 is part of the VGA controller project.
-- The Memory Controller 3 generates addresses for a ROM where a 100x100x12bit
-- image is stored.
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mem_ctrl_3 is
  port (--from FPGA board
        reset_i :       in std_logic;                       --asynchronous reset (active high)
        clk_i :         in std_logic;                       --100 MHz system clock

        --from prescaler
        pixel_en_i :    in std_logic;                       --25 MHz pixel enable clock

        --from source multiplexer
        pixel_x_i :     in unsigned(6 downto 0);            --horizonal pixel coordinates
        pixel_y_i :     in unsigned(6 downto 0);            --vertical pixel coordinated
        pixel_valid_i : in std_logic;                       --shows if the pixel coordinates are valid (in range of the actual screen)
        
        --to source multiplexer
        rgb_o :         out std_logic_vector(11 downto 0)); --color information for a given pixel

end mem_ctrl_3;