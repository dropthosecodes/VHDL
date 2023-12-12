-------------------------------------------------------------------------------
-- VGA CONTROLLER PROJECT
-------------------------------------------------------------------------------
-- Author: Konstantin Haferl
--
-- Filename: tb_pattern_gen_2_.vhd
--
-- Date of Creation: 2023 09 22
--
-- Version: 1.0
--
-- Design Unit: Pattern Generator 2 (Testbench)
--
-- Description: The Pattern Generator 2 is part of the VGA controller project.
-- It generates a pattern of Red, Green and Blue rectangles on the 640x480 screen.
-- There are 10 rectangles in each row and column, meaning each one has a size
-- of 64x48 pixels. For each row the colors are shifted to the left once recangle wide.
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_pattern_gen_2 is
end tb_pattern_gen_2;

