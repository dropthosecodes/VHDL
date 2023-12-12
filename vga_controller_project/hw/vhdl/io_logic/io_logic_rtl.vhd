-------------------------------------------------------------------------------
-- VGA CONTROLLER PROJECT
-------------------------------------------------------------------------------
-- Author: Konstantin Haferl
--
-- Filename: io_logic_rtl.vhd
--
-- Date of Creation: 2023 09 19
--
-- Version: 1.0
--
-- Design Unit: IO Logic Unit (Architecture)
--
-- Description: The IO Logic Unit is part of the VGA controller project
-- It handles the debouncing of the push buttons as well as the three switches SW0, SW1 and SW2.
--
-------------------------------------------------------------------------------

library IEEE; 
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

architecture rtl of io_logic is
  constant C_ENCOUNTVAL : integer := 100000;
  signal counter : integer := 0;

  signal s_1khzdb : std_logic;
  signal s_sw : std_logic_vector(5 downto 0);
  signal s_pb : std_logic_vector(3 downto 0);

  type t_pb_state is (IDLE_S, WAIT_S);
  signal s_pb_state : t_pb_state;
  signal s_pb_temp : std_logic_vector(3 downto 0);

begin

  --Generate 1 kHz debounce signal.
  --Enable signal is inactive per default.
  --As long as the terminal count is not reached: increment the counter.
  --When the terminal count is reached, set enable signal and reset the counter.
  p_slowen: process (clk_i, reset_i)
  begin
    if reset_i = '1' then --asynchronous reset (active high)
      s_1khzdb <= '0';
      counter <= 0;
    elsif clk_i'event and clk_i = '1' then --rising clock edge
      counter <= counter + 1;
      if counter >= C_ENCOUNTVAL then
        s_1khzdb <= '1';
        counter <= 0;
      else
        s_1khzdb <= '0';
      end if;
    end if;
  end process p_slowen;

  --Debounce buttons
  p_pb_debounce: process (clk_i, reset_i)
  begin
    if reset_i = '1' then -- asynchronous reset (active high)
      s_pb_state <= IDLE_S;
      s_pb <= (others => '0');
      s_pb_temp <= (others => '0');
    elsif clk_i'event and clk_i = '1' then -- rising clock edge
      case s_pb_state is
        when IDLE_S =>
          if pb_i /= "0000" then
            s_pb_temp <= pb_i;
            s_pb_state <= WAIT_S;
          else
            s_pb_state <= IDLE_S;
          end if;
          s_pb <= (others => '0');

        when WAIT_S =>
          if s_1khzdb = '1' then
            if pb_i = "0000" then
              s_pb <= s_pb_temp;
              s_pb_state <= IDLE_S;
            end if;
          else
            s_pb <= (others => '0');
          end if;

        when others =>
          s_pb_state <= IDLE_S;
      end case;
    end if;
  end process p_pb_debounce;

  pb_o <= s_pb;

  --the switches don't need debouncing
  sw_o <= sw_i;

end rtl;