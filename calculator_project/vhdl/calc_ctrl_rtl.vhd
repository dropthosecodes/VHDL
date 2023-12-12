-------------------------------------------------------------------------------
-- CALCULATOR PROJECT
-------------------------------------------------------------------------------
-- Author: Konstantin Haferl
--
-- Filename: calc_ctrl_rtl.vhd
--
-- Date of Creation: 2023 05 01
--
-- Version: $Revision$
--
-- Design Unit: Calculator Control Unit (Architecture)
--
-- Description: The Calculator Control unit is part of the calculator project.
--
-------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

architecture rtl of calc_ctrl is
  --Buttons
  constant BTNL : std_logic_vector(3 downto 0):= "1000";  --op1
  constant BTNC : std_logic_vector(3 downto 0):= "0100";  --op2
  constant BTNR : std_logic_vector(3 downto 0):= "0010";  --optype
  constant BTND : std_logic_vector(3 downto 0):= "0001";  --calc

  --Operators
  constant OP_ADD : std_logic_vector(3 downto 0):= "0000";
  constant OP_SUB : std_logic_vector(3 downto 0):= "0001";
  constant OP_RE :  std_logic_vector(3 downto 0):= "0100";
  constant OP_AND : std_logic_vector(3 downto 0):= "1001";
  constant OP_ROL : std_logic_vector(3 downto 0):= "1100";

  --SS digits
  constant SS_0 : std_logic_vector(7 downto 0):= "00000011";
  constant SS_1 : std_logic_vector(7 downto 0):= "10011111";
  constant SS_2 : std_logic_vector(7 downto 0):= "00100101";
  constant SS_3 : std_logic_vector(7 downto 0):= "00001101";
  constant SS_4 : std_logic_vector(7 downto 0):= "10011001";
  constant SS_5 : std_logic_vector(7 downto 0):= "01001001";
  constant SS_6 : std_logic_vector(7 downto 0):= "01000001";
  constant SS_7 : std_logic_vector(7 downto 0):= "00011111";
  constant SS_8 : std_logic_vector(7 downto 0):= "00000001";
  constant SS_9 : std_logic_vector(7 downto 0):= "00011001";
  constant SS_A : std_logic_vector(7 downto 0):= "00010001";
  constant SS_B : std_logic_vector(7 downto 0):= "11000001";
  constant SS_C : std_logic_vector(7 downto 0):= "01100011";
  constant SS_D : std_logic_vector(7 downto 0):= "10000101";
  constant SS_E : std_logic_vector(7 downto 0):= "01100001";
  constant SS_F : std_logic_vector(7 downto 0):= "01110001";
  constant SS_L : std_logic_vector(7 downto 0):= "11100011";
  constant SS_N : std_logic_vector(7 downto 0):= "11010101";
  constant SS_O : std_logic_vector(7 downto 0):= "11000101";
  constant SS_R : std_logic_vector(7 downto 0):= "11110101";
  constant SS_S : std_logic_vector(7 downto 0):= "01001001";
  constant SS_U : std_logic_vector(7 downto 0):= "11000111";
  constant SS_dot : std_logic_vector(7 downto 0):= "11111110";
  constant SS_1_dot: std_logic_vector(7 downto 0):= "10011110";
  constant SS_2_dot : std_logic_vector(7 downto 0):= "00100100";
  constant SS_O_dot : std_logic_vector(7 downto 0):= "11000100";
  constant SS_minus : std_logic_vector(7 downto 0):= "11111101";
  constant SS_empty : std_logic_vector(7 downto 0):= "11111111";

  --Look up table for SS
  type t_lut_hex is array (0 to 15) of std_logic_vector(7 downto 0);
  constant lut_hex : t_lut_hex := (
    0 => SS_0,
    1 => SS_1,
    2 => SS_2,
    3 => SS_3,
    4 => SS_4,
    5 => SS_5,
    6 => SS_6,
    7 => SS_7,
    8 => SS_8,
    9 => SS_9,
    10 => SS_A,
    11 => SS_B,
    12 => SS_C,
    13 => SS_D,
    14 => SS_E,
    15 => SS_F);

  type t_calc_state is (ENTER_OP1_S, ENTER_OP2_S, ENTER_OPTYPE_S, CALCULATE_S, DISPLAY_S);
  signal s_calc_state : t_calc_state;

  signal s_op1_o :     std_logic_vector(11 downto 0);  --operand 1 signal
  signal s_op2_o :     std_logic_vector(11 downto 0);  --operand 2 signal
  signal s_optype_o :  std_logic_vector(3 downto 0);   --operator signal
  signal s_start_o :   std_logic;                      --start signal
  signal s_led_o :     std_logic_vector(15 downto 0);  --output leds

  type t_dig_dec is array (0 to 3) of std_logic_vector(7 downto 0);
  signal s_dig_dec : t_dig_dec;

begin

  --State machine of the Calculator Control Unit
  p_calc_ctrl: process (clk_i, reset_i)
  begin
    if reset_i = '1' then --asynchronous reset (active high)
      s_calc_state <= CALCULATE_S;
      s_op1_o <= (others => '0');
      s_op2_o <= (others => '0');
      s_optype_o <= OP_ADD;
      s_start_o <= '1';
    elsif clk_i'event and clk_i = '1' then --rising clock edge
      case s_calc_state is
        when ENTER_OP1_S =>
          s_op1_o <= swsync_i(11 downto 0);
          case pbsync_i is
            when BTNL =>
              s_calc_state <= ENTER_OP1_S;
            when BTNC =>
              s_calc_state <= ENTER_OP2_S;
            when BTNR =>
              s_calc_state <= ENTER_OPTYPE_S;
            when BTND =>
              s_start_o <= '1';
              s_calc_state <= CALCULATE_S;
            when others =>
              s_calc_state <= ENTER_OP1_S;
          end case;
        when ENTER_OP2_S =>
          s_op2_o <= swsync_i(11 downto 0);
          case pbsync_i is
            when BTNL =>
              s_calc_state <= ENTER_OP1_S;
            when BTNC =>
              s_calc_state <= ENTER_OP2_S;
            when BTNR =>
              s_calc_state <= ENTER_OPTYPE_S;
            when BTND =>
              s_start_o <= '1';
              s_calc_state <= CALCULATE_S;
            when others =>
              s_calc_state <= ENTER_OP2_S;
          end case;
        when ENTER_OPTYPE_S =>
          s_optype_o <= swsync_i(15 downto 12);
          case pbsync_i is
            when BTNL =>
              s_calc_state <= ENTER_OP1_S;
            when BTNC =>
              s_calc_state <= ENTER_OP2_S;
            when BTNR =>
              s_calc_state <= ENTER_OPTYPE_S;
            when BTND =>
              s_start_o <= '1';
              s_calc_state <= CALCULATE_S;
            when others =>
              s_calc_state <= ENTER_OPTYPE_S;
          end case;
        when CALCULATE_S =>
          s_calc_state <= CALCULATE_S;
          s_start_o <= '0';
          if finished_i = '1' then
            s_calc_state <= DISPLAY_S;
          end if;
        when DISPLAY_S =>
          case pbsync_i is
            when BTNL =>
              s_calc_state <= ENTER_OP1_S;
            when BTNC =>
              s_calc_state <= ENTER_OP2_S;
            when BTNR =>
              s_calc_state <= ENTER_OPTYPE_S;
            when BTND =>
              s_calc_state <= DISPLAY_S;
            when others =>
              s_calc_state <= DISPLAY_S;
          end case;
        when others =>
          s_calc_state <= CALCULATE_S;
      end case;
    end if;
  end process p_calc_ctrl;

  op1_o <= s_op1_o;
  op2_o <= s_op2_o;
  optype_o <= s_optype_o;
  start_o <= s_start_o;

  --Decoder for SS
  p_ss_decode: process (clk_i, reset_i)
  begin
    if reset_i = '1' then
      for i in 0 to 3 loop
        s_dig_dec(i) <= SS_empty;
      end loop;
      s_led_o <= (others => '0');
    elsif clk_i'event and clk_i = '1' then
      case s_calc_state is
        when ENTER_OP1_S =>
          --s_led_o <= "0000000000000001";
          s_led_o <= (others => '0');
          s_dig_dec(3) <= SS_1_dot;
          for i in 0 to 2 loop
            s_dig_dec(i) <= lut_hex(to_integer(unsigned(swsync_i((i*4+3) downto i*4))));
          end loop;

        when ENTER_OP2_S =>
          --s_led_o <= "0000000000000010";
          s_led_o <= (others => '0');
          s_dig_dec(3) <= SS_2_dot;
          for i in 0 to 2 loop
            s_dig_dec(i) <= lut_hex(to_integer(unsigned(swsync_i((i*4+3) downto i*4))));
          end loop;

        when ENTER_OPTYPE_S =>
        --s_led_o <= "0000000000000100";
          s_led_o <= (others => '0');
          s_dig_dec(3) <= SS_o_dot;
          case swsync_i(15 downto 12) is
            when OP_ADD =>
              s_dig_dec(0) <= SS_D;
              s_dig_dec(1) <= SS_D;
              s_dig_dec(2) <= SS_A;
            when OP_SUB =>
              s_dig_dec(0) <= SS_B;
              s_dig_dec(1) <= SS_U;
              s_dig_dec(2) <= SS_S;
            when OP_RE =>
              s_dig_dec(0) <= SS_empty;
              s_dig_dec(1) <= SS_E;
              s_dig_dec(2) <= SS_R;
            when OP_AND =>
              s_dig_dec(0) <= SS_D;
              s_dig_dec(1) <= SS_N;
              s_dig_dec(2) <= SS_A;
            when OP_ROL =>
              s_dig_dec(0) <= SS_L;
              s_dig_dec(1) <= SS_O;
              s_dig_dec(2) <= SS_R;
            when others =>
              s_dig_dec(0) <= SS_empty;
              s_dig_dec(1) <= SS_empty;
              s_dig_dec(2) <= SS_empty;
          end case;

        when CALCULATE_S =>
          s_led_o <= (others => '0');
          for i in 0 to 3 loop
            s_dig_dec(i) <= SS_empty;
          end loop;

        when DISPLAY_S => --LED
          s_led_o <= "1000000000000000";
          if error_i = '1' then
            s_dig_dec(0) <= SS_R;
            s_dig_dec(1) <= SS_R;
            s_dig_dec(2) <= SS_E;
            s_dig_dec(3) <= SS_empty;
          elsif overflow_i = '1' then
            for i in 0 to 3 loop
              s_dig_dec(i) <= SS_o;
            end loop;
          elsif sign_i = '1' then
            s_dig_dec(3) <= SS_minus;
            for i in 0 to 2 loop
              s_dig_dec(i) <= lut_hex(to_integer(unsigned(result_i((i*4+3) downto i*4))));
            end loop;
          else
            for i in 0 to 3 loop
              s_dig_dec(i) <= lut_hex(to_integer(unsigned(result_i((i*4+3) downto i*4))));
            end loop;
          end if;

        when others => null;
      end case;
    end if;
  end process p_ss_decode;

  dig0_o <= s_dig_dec(0);
  dig1_o <= s_dig_dec(1);
  dig2_o <= s_dig_dec(2);
  dig3_o <= s_dig_dec(3);
  led_o <= s_led_o;
  
end rtl;