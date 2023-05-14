-------------------------------------------------------------------------------
-- CALCULATOR PROJECT
-------------------------------------------------------------------------------
-- Author: Konstantin Haferl
--
-- Filename: alu_.vhd
--
-- Date of Creation: 2023 05 05
--
-- Version: $Revision$
--
-- Design Unit: ALU (Entity)
--
-- Description: The ALU is part of the calculator project.
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity alu is
  port (clk_i :         in std_logic;                        --100 MHz system clock
        reset_i :       in std_logic;                        --asynchronous reset (active high)

        --calc_ctrl:
        op1_i :         in std_logic_vector(11 downto 0);    --operand 1
        op2_i :         in std_logic_vector(11 downto 0);    --operand 2
        optype_i :      in std_logic_vector(3 downto 0);     --operator
        start_i :       in std_logic;                        --start signal

        result_o :      out std_logic_vector(15 downto 0);   --result from calculation
        finished_o :    out std_logic;                       --finished signal
        sign_o :        out std_logic;                       --signed flag
        overflow_o :    out std_logic;                       --overflow flag
        error_o :       out std_logic);                      --error flag
end alu;