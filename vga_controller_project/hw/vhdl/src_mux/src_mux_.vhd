-------------------------------------------------------------------------------
-- VGA CONTROLLER PROJECT
-------------------------------------------------------------------------------
-- Author: Konstantin Haferl
--
-- Filename: src_mux_.vhd
--
-- Date of Creation: 2023 10 10
--
-- Version: 1.0
--
-- Design Unit: Source Multiplexer (Entity)
--
-- Description: The Source Multiplexer is part of the VGA controller project.
-- It routes the RGB signals to the VGA Control Unit according to the
-- position of the switches on the Basys3 devboard .
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library work;
use work.mc8051_p.all;

entity src_mux is
  port (--from FPGA board
        reset_i :        in std_logic;                          --asynchronous reset (active high)
        clk_i :          in std_logic;                          --100 MHz system clock

        --from prescaler
        pixel_en_i :     in std_logic;                          --25 MHz pixel enable clock

        --from IO Logic Unit
        sw_i :           in std_logic_vector(5 downto 0);       --state of the 3 input switches
        pb_i :           in std_logic_vector(3 downto 0);       --state of the 4 input push buttons (debounced)

        --from pattern generators
        pat1_rgb_i :     in std_logic_vector(11 downto 0);      --color information from pattern generator 1
        pat2_rgb_i :     in std_logic_vector(11 downto 0);      --color information from pattern generator 2
        
        --from memory controllers
        mem1_rgb_i :     in std_logic_vector(11 downto 0);      --color information from memory controller 1
        mem2_rgb_i :     in std_logic_vector(11 downto 0);      --color information from memory controller 2
        mem3_rgb_i :     in std_logic_vector(11 downto 0);      --color information from memory controller 3

        --to mem_ctrl2
        mem2_pixel_x_o :      out unsigned(6 downto 0);         --horizontal pixel coordinates for mem_ctrl2
        mem2_pixel_y_o :      out unsigned (6 downto 0);        --vertical pixel coordinates for mem_ctrl2
        mem2_pixel_valid_o :  out std_logic;                    --pixel valid signal for mem_ctrl2

        --to mem_ctrl3
        mem3_pixel_x_o :      out unsigned(6 downto 0);         --horizontal pixel coordinates for mem_ctrl3
        mem3_pixel_y_o :      out unsigned (6 downto 0);        --vertical pixel coordinates for mem_ctrl3
        mem3_pixel_valid_o :  out std_logic;                    --pixel valid signal for mem_ctrl3

        --from VGA control (for moving image)
        pixel_x_i :      in unsigned(9 downto 0);               --horizonal pixel coordinates
        pixel_y_i :      in unsigned(9 downto 0);               --vertical pixel coordinated
        pixel_valid_i :  in std_logic;                          --shows if the pixel coordinates are valid (in range of the actual screen)
        
        --to VGA control
        rgb_o :          out std_logic_vector(11 downto 0));    --color information for a given pixel

end src_mux;