-------------------------------------------------------------------------------
-- CALCULATOR PROJECT
-------------------------------------------------------------------------------
-- Author: Konstantin Haferl
--
-- Filename: calc_ctrl_.vhd
--
-- Date of Creation: 2023 05 01
--
-- Version: $Revision$
--
-- Design Unit: Calculator Control Unit (Entity)
--
-- Description: The Calculator Control unit is part of the calculator project.
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity calc_ctrl is
  port (clk_i :         in std_logic;                       --100 MHz system clock
        reset_i :       in std_logic;                       --asynchronous reset (active high)

        --alu:
        op1_o :         out std_logic_vector(11 downto 0);  --operand 1
        op2_o :         out std_logic_vector(11 downto 0);  --operand 2
        optype_o :      out std_logic_vector(3 downto 0);   --operator
        start_o :       out std_logic;                      --start signal
        result_i :      in std_logic_vector(15 downto 0);   --result from calculation
        finished_i :    in std_logic;                       --finished signal
        sign_i :        in std_logic;                       --signed flag
        overflow_i :    in std_logic;                       --overflow flag
        error_i :       in std_logic;                       --error flag

        --io_ctrl:
        led_o :         out std_logic_vector(15 downto 0);  --state of 16 LEDs
        dig0_o :        out std_logic_vector(7 downto 0);   --8 Cathodes of SS digit0 (active low)
        dig1_o :        out std_logic_vector(7 downto 0);   --8 Cathodes of SS digit1 (active low)
        dig2_o :        out std_logic_vector(7 downto 0);   --8 Cathodes of SS digit2 (active low)
        dig3_o :        out std_logic_vector(7 downto 0);   --8 Cathodes of SS digit3 (active low)
        swsync_i :      in std_logic_vector(15 downto 0);   --state of 16 input switches
        pbsync_i :      in std_logic_vector(3 downto 0));   --state of 4 input push buttons
end calc_ctrl;