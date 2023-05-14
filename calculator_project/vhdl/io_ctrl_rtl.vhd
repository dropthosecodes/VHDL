-------------------------------------------------------------------------------
-- CALCULATOR PROJECT
-------------------------------------------------------------------------------
-- Author: Konstantin Haferl
--
-- Filename: io_ctrl_rtl.vhd
--
-- Date of Creation: 2023 05 01
--
-- Version: $Revision$
--
-- Design Unit: IO Control Unit (Architecture)
--
-- Description: The IO Control unit is part of the calculator project.
-- It manages the interface to the 7-segment displays, the LEDs, the push buttons
-- and the switches of the Digilent Basys3 FPGA board.
--
-------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

architecture rtl of io_ctrl is
  constant C_ENCOUNTVAL : integer := 100000;
  signal counter : integer := 0;

  signal s_1khzen : std_logic;
  signal s_swsync : std_logic_vector(15 downto 0);
  signal s_pbsync : std_logic_vector(3 downto 0);
  signal s_ss_sel : std_logic_vector(3 downto 0);
  signal s_ss : std_logic_vector(7 downto 0);

  type t_pb_state is (IDLE_S, WAIT_S);
  signal s_pb_state : t_pb_state;
  signal s_pbsync_temp : std_logic_vector(3 downto 0);
  
  type t_sw_state is (OFF_S, ON_S);
  signal s_sw_state : t_sw_state;

  type t_digit_state is (dig0_s, dig1_s, dig2_s, dig3_s);
  signal s_digit_state : t_digit_state;
begin

  --Generate 1 kHz enable signal.
  --Enable signal is inactive per default.
  --As long as the terminal count is not reached: increment the counter.
  --When the terminal count is reached, set enable signal and reset the counter.
  p_slowen: process (clk_i, reset_i)
  begin
    if reset_i = '1' then --asynchronous reset (active high)
      s_1khzen <= '0';
      counter <= 0;
    elsif clk_i'event and clk_i = '1' then --rising clock edge
      counter <= counter + 1;
      if counter >= C_ENCOUNTVAL then
        s_1khzen <= '1';
        counter <= 0;
      else
        s_1khzen <= '0';
      end if;
    end if;
  end process p_slowen;

  --Debounce buttons
  p_pb_debounce: process (clk_i, reset_i)
  begin
    if reset_i = '1' then -- asynchronous reset (active high)
      s_pb_state <= IDLE_S;
      s_pbsync <= (others => '0');
      s_pbsync_temp <= (others => '0');
    elsif clk_i'event and clk_i = '1' then -- rising clock edge
      case s_pb_state is
        when IDLE_S =>
          if pb_i /= "0000" then
            s_pbsync_temp <= pb_i;
            s_pb_state <= WAIT_S;
          else
            s_pb_state <= IDLE_S;
          end if;
          s_pbsync <= (others => '0');

        when WAIT_S =>  --suboptimal
          if s_1khzen = '1' then
            if pb_i = "0000" then
              s_pbsync <= s_pbsync_temp;
              s_pb_state <= IDLE_S;
            end if;
          else
            s_pbsync <= (others => '0');
          end if;

        when others =>
          s_pb_state <= IDLE_S;
      end case;
    end if;
  end process p_pb_debounce;
  pbsync_o <= s_pbsync;
  --pbsync_o <= pb_i;

  --Debounce switches
  -- p_sw_debounce: process (clk_i, reset_i)
  -- begin
  --   if reset_i = '1' then -- asynchronous reset (active high)
  --     s_sw_state <= OFF_S;
  --     s_swsync <= (others => '0');
  --   elsif clk_i'event and clk_i = '1' then -- rising clock edge
  --     case s_sw_state is
  --       when OFF_S =>
  --         if sw_i /= "0000000000000000" then 
  --           s_sw_state <= ON_S;
  --         else
  --           s_sw_state <= OFF_S;
  --           s_swsync <= (others => '0');
  --         end if;

  --       when ON_S =>  --SUBOPTIMAL
  --         if s_1khzen = '1' then
  --           if sw_i /= "0000000000000000" then
  --             s_swsync <= sw_i;
  --           else
  --             s_swsync <= (others => '0');
  --             s_sw_state <= OFF_S;
  --           end if;
  --         end if;

  --       when others =>
  --         s_sw_state <= OFF_S;
  --     end case;
  --   end if;
  -- end process p_sw_debounce;
  --swsync_o <= s_swsync;
  swsync_o <= sw_i;

  -- Display controller for the 7-segment display
  p_display_ctrl: process (s_1khzen, reset_i) --darf man das machen oder muss clk_i der takt sein?
  begin
    if reset_i = '1' then --asynchronous reset (active high)
      s_digit_state <= dig0_s;
      s_ss <= (others => '1');
      s_ss_sel <= (others => '1');
    elsif s_1khzen'event and s_1khzen = '1' then --rising clock edge
      case s_digit_state is
        when dig0_s =>
          s_ss_sel <= "1110";
          s_ss <= dig0_i;
          s_digit_state <= dig1_s;
        when dig1_s =>
          s_ss_sel <= "1101";
          s_ss <= dig1_i;
          s_digit_state <= dig2_s;
        when dig2_s =>
          s_ss_sel <= "1011";
          s_ss <= dig2_i;
          s_digit_state <= dig3_s;
        when dig3_s =>
          s_ss_sel <= "0111";
          s_ss <= dig3_i;
          s_digit_state <= dig0_s;
        when others =>
          s_digit_state <= dig0_s;
      end case;
    end if;
  end process p_display_ctrl;
  ss_o <= s_ss;             --8 Cathodes of an individual SS digit (active low)
  ss_sel_o <= s_ss_sel;     --Common Anodes of 4 SS digits (active low)

  --Handle the 16 LEDs
  led_o <= led_i; --simply connect the internal to the external signals
end rtl;



  -- p_pb_debounce: process (clk_i, reset_i)
  -- begin
  --   if reset_i = '1' then -- asynchronous reset (active high)
  --     s_pbsync <= (others => '0');
  --     s_pbsync_temp <= (others => '0');
  --   elsif clk_i'event and clk_i = '1' then -- rising clock edge
  --     if pb_i = "1000" then
  --       s_pbsync_temp <= "1000";
  --     elsif pb_i = "0100" then
  --       s_pbsync_temp <= "0100";
  --     elsif pb_i = "0010" then
  --       s_pbsync_temp <= "0010";
  --     elsif pb_i = "0001" then
  --       s_pbsync_temp <= "0001";
  --     else
  --       s_pbsync_temp <= "0000";
  --     end if;

  --     if s_1khzen = '1' then
  --       s_pbsync <= s_pbsync_temp;
  --     end if;
  --   end if;
  -- end process p_pb_debounce;