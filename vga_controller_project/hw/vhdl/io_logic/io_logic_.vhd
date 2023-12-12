-------------------------------------------------------------------------------
-- VGA CONTROLLER PROJECT
-------------------------------------------------------------------------------
-- Author: Konstantin Haferl
--
-- Filename: io_logic_.vhd
--
-- Date of Creation: 2023 09 19
--
-- Version: 1.0
--
-- Design Unit: IO Logic Unit (Entity)
--
-- Description: The IO Logic Unit is part of the VGA controller project
-- It handles the debouncing of the push buttons as well as the three switches SW0, SW1 and SW2.
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity io_logic is
  port (--from FPGA board
        reset_i :       in std_logic;                       --asynchronous reset (active high)
        clk_i :         in std_logic;                       --100 MHz system clock
        sw_i :          in std_logic_vector(5 downto 0);    --the 3 input switches
        pb_i :          in std_logic_vector(3 downto 0);    --the 4 input push buttons

        --to source multiplexer
        sw_o :      out std_logic_vector(5 downto 0);        --state of the 3 input switches
        pb_o :      out std_logic_vector(3 downto 0));       --state of the 4 input push buttons (debounced)

end io_logic;