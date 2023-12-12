-------------------------------------------------------------------------------
-- VGA CONTROLLER PROJECT
-------------------------------------------------------------------------------
-- Author: Konstantin Haferl
--
-- Filename: vga_ctrl_.vhd
--
-- Date of Creation: 2023 09 18
--
-- Version: 1.0
--
-- Design Unit: VGA Control Unit (Entity)
--
-- Description: The VGA Control unit is part of the VGA controller project
-- It drives the VGA signals and generates the horizontal any vertical sync
-- counters for the memory controllers and pattern generators
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity vga_ctrl is
  port (--from FPGA board
        reset_i :       in std_logic;                       --asynchronous reset (active high)
        clk_i :         in std_logic;                       --100 MHz system clock

        --from prescaler
        pixel_en_i :    in std_logic;                       --25 MHz pixel enable clock

        --from source multiplexer:
        rgb_i :         in std_logic_vector(11 downto 0);   --color information for a given pixel

        --to FPGA board:
        red_o :         out std_logic_vector(3 downto 0);   --red pixels (4 bit)
        green_o :       out std_logic_vector(3 downto 0);   --green pixels (4 bit)
        blue_o :        out std_logic_vector(3 downto 0);   --blue pixels (4 bit)
        hsync_o :       out std_logic;                      --horizontal sync 
        vsync_o :       out std_logic;                      --vertical sync
                        
        --to memory controllers and pattern generators
        pixel_x_o :     out unsigned(9 downto 0);           --horizonal pixel coordinates
        pixel_y_o :     out unsigned(9 downto 0);           --vertical pixel coordinated
        pixel_valid_o : out std_logic);                     --shows if the pixel coordinates are valid (in range of the actual screen)
        
        -- --OUTDATED
        -- --to source multiplexer (which forwards the signals to memory controllers and pattern generators)
        -- hsync_c_o :     out unsigned;                        --horizontal sync counter
        -- vsync_c_o :     out unsigned);                       --vertical sync counter
end vga_ctrl;