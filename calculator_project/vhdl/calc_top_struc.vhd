-------------------------------------------------------------------------------
-- CALCULATOR PROJECT
-------------------------------------------------------------------------------
-- Author: Konstantin Haferl
--
-- Filename: calc_top_struc.vhd
--
-- Date of Creation: 2023 05 05
--
-- Version: $Revision$
--
-- Design Unit: Top-level Design of Calculator (Architecture)
--
-- Description: This is the top-level design of the calculator project.
-- It interconnects the sub-units 'IO control unit', 'calculator
-- control unit' and 'arithmetic logic unit' and interfaces to
-- the circuitry of the Digilent Basys3 FPGA board.
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

architecture struc of calc_top is

  component io_ctrl
    port (--FPGA board:
          clk_i :         in std_logic;                       --100 MHz system clock
          reset_i :       in std_logic;                       --asynchronous reset (active high)
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
  end component;

  component calc_ctrl
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
          led_o :         out std_logic_vector(15 downto 0);   --state of 16 LEDs
          dig0_o :        out std_logic_vector(7 downto 0);    --8 Cathodes of SS digit0 (active low)
          dig1_o :        out std_logic_vector(7 downto 0);    --8 Cathodes of SS digit1 (active low)
          dig2_o :        out std_logic_vector(7 downto 0);    --8 Cathodes of SS digit2 (active low)
          dig3_o :        out std_logic_vector(7 downto 0);    --8 Cathodes of SS digit3 (active low)
          swsync_i :      in std_logic_vector(15 downto 0);    --state of 16 input switches
          pbsync_i :      in std_logic_vector(3 downto 0));    --state of 4 input push buttons
  end component;

  component alu
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
  end component;

  -- signal clk_i :      std_logic;
  -- signal reset_i :    std_logic;
  -- signal sw_i :       std_logic_vector(15 downto 0);
  -- signal pb_i :       std_logic_vector(3 downto 0);
  -- signal ss_o :       std_logic_vector(7 downto 0);
  -- signal ss_sel_o :   std_logic_vector(3 downto 0);
  -- signal led_o :      std_logic_vector(15 downto 0);

  signal s_led :      std_logic_vector(15 downto 0);
  signal s_dig0 :     std_logic_vector(7 downto 0);
  signal s_dig1 :     std_logic_vector(7 downto 0);
  signal s_dig2 :     std_logic_vector(7 downto 0);
  signal s_dig3 :     std_logic_vector(7 downto 0);
  signal s_swsync :   std_logic_vector(15 downto 0);
  signal s_pbsync :   std_logic_vector(3 downto 0);

  signal s_op1 :      std_logic_vector(11 downto 0);
  signal s_op2 :      std_logic_vector(11 downto 0);
  signal s_optype :   std_logic_vector(3 downto 0);
  signal s_start :    std_logic;
  signal s_result :   std_logic_vector(15 downto 0);
  signal s_finished : std_logic;
  signal s_sign :     std_logic;
  signal s_overflow : std_logic;
  signal s_error :    std_logic;

  begin

    i_io_ctrl : io_ctrl
    port map
      (clk_i => clk_i,
      reset_i => reset_i,
      sw_i => sw_i,
      pb_i => pb_i,
      ss_o => ss_o,
      ss_sel_o => ss_sel_o,
      led_o => led_o,
      led_i => s_led,
      dig0_i => s_dig0,
      dig1_i => s_dig1,
      dig2_i => s_dig2,
      dig3_i => s_dig3,
      swsync_o => s_swsync,
      pbsync_o => s_pbsync);

    i_calc_ctrl : calc_ctrl
    port map
      (clk_i => clk_i,
      reset_i => reset_i,
      op1_o => s_op1,
      op2_o => s_op2,
      optype_o => s_optype,
      start_o => s_start,
      result_i => s_result,
      finished_i => s_finished,
      sign_i => s_sign,
      overflow_i => s_overflow,
      error_i => s_error,
      led_o => s_led,
      dig0_o => s_dig0,
      dig1_o => s_dig1,
      dig2_o => s_dig2,
      dig3_o => s_dig3,
      swsync_i => s_swsync,
      pbsync_i => s_pbsync);

    i_alu : alu
    port map
    (clk_i => clk_i,
      reset_i => reset_i,
      op1_i => s_op1,
      op2_i => s_op2,
      optype_i => s_optype,
      start_i => s_start,
      result_o => s_result,
      finished_o => s_finished,
      sign_o => s_sign,
      overflow_o => s_overflow,
      error_o => s_error);

end struc;