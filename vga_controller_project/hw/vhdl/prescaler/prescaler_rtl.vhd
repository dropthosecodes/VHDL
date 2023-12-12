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
-- Design Unit: Prescaler (Architecture)
--
-- Description: The prescaler is part of the VGA controller project
-- It manages ...
--
-------------------------------------------------------------------------------

library IEEE; 
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

architecture rtl of prescaler is
  constant C_ENCOUNTVAL : integer := 4;
  signal s_pixel_en : std_logic;

begin

  --Generate 25MHz pixel enable signal.
  --Enable signal is inactive per default.
  --As long as the terminal count is not reached: increment the counter.
  --When the terminal count is reached, set enable signal and reset the counter.
  p_prescaler: process (clk_i, reset_i)
  variable counter : integer := 0;
  begin
    if reset_i = '1' then --asynchronous reset (active high)
      s_pixel_en <= '0';
      counter := 0;
    elsif clk_i'event and clk_i = '1' then --rising clock edge
      counter := counter + 1;
      if counter >= C_ENCOUNTVAL then
        s_pixel_en <= '1';
        counter := 0;
      else
        s_pixel_en <= '0';
      end if;
    end if;
  end process p_prescaler;

  pixel_en_o <= s_pixel_en;
end rtl;
