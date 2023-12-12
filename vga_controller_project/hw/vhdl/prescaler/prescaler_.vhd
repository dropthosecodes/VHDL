-------------------------------------------------------------------------------
-- VGA CONTROLLER PROJECT
-------------------------------------------------------------------------------
-- Author: Konstantin Haferl
--
-- Filename: prescaler_.vhd
--
-- Date of Creation: 2023 09 19
--
-- Version: 1.0
--
-- Design Unit: Prescaler (Entity)
--
-- Description: The prescaler is part of the VGA controller project
-- It manages ...
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity prescaler is
  port (--from FPGA board:
        clk_i :         in std_logic;                       --100 MHz system clock
        reset_i :       in std_logic;                      --asynchronous reset (active high)

        --to all other components
        pixel_en_o :      out std_logic);                   --25 MHz pixel enable clock

end prescaler;
