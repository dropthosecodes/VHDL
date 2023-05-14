-------------------------------------------------------------------------------
-- CALCULATOR PROJECT
-------------------------------------------------------------------------------
-- Author: Konstantin Haferl
--
-- Filename: io_ctrl_.vhd
--
-- Date of Creation: 2023 05 01
--
-- Version: $Revision$
--
-- Design Unit: IO Control Unit (Entity)
--
-- Description: The IO Control unit is part of the calculator project.
-- It manages the interface to the 7-segment displays, the LEDs, the push buttons
-- and the switches of the Digilent Basys3 FPGA board.
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity io_ctrl is
  port (clk_i :         in std_logic;                       --100 MHz system clock
        reset_i :       in std_logic;                       --asynchronous reset (active high)

        --FPGA board:
        sw_i :          in std_logic_vector(15 downto 0);   --state of 16 input switches
        pb_i :          in std_logic_vector(3 downto 0);    --state of 4 input push buttons
        ss_o :          out std_logic_vector(7 downto 0);   --8 Cathodes of an individual SS digit (active low)
        ss_sel_o :      out std_logic_vector(3 downto 0);   --Common Anodes of 4 SS digits (active low)
        led_o :         out std_logic_vector(15 downto 0);  --state of 16 LEDs

        --calc_ctrl:
        led_i :         in std_logic_vector(15 downto 0);   --state of 16 LEDs
        dig0_i :        in std_logic_vector(7 downto 0);    --8 Cathodes of SS digit0 (active low)
        dig1_i :        in std_logic_vector(7 downto 0);    --8 Cathodes of SS digit1 (active low)
        dig2_i :        in std_logic_vector(7 downto 0);    --8 Cathodes of SS digit2 (active low)
        dig3_i :        in std_logic_vector(7 downto 0);    --8 Cathodes of SS digit3 (active low)
        swsync_o :      out std_logic_vector(15 downto 0);  --state of 16 input switches
        pbsync_o :      out std_logic_vector(3 downto 0));  --state of 4 input push buttons
end io_ctrl;