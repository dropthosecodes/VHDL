-------------------------------------------------------------------------------
-- VGA CONTROLLER PROJECT
-------------------------------------------------------------------------------
-- Author: Konstantin Haferl
--
-- Filename: pattern_gen_1_rtl.vhd
--
-- Date of Creation: 2023 09 19
--
-- Version: 1.0
--
-- Design Unit: Pattern Generator 1 (Architecture)
--
-- Description: The Pattern Generator 1 is part of the VGA controller project.
-- It generates a pattern of Red-Green-Blue-Black columns on the 640x480 screen.
-- The columns are 40 pixels wide, therefore a total of 16 columns are generated.
--
-------------------------------------------------------------------------------

library IEEE; 
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

architecture rtl of pattern_gen_1 is

  constant column_width : integer := 40;
  constant red : std_logic_vector(11 downto 0)    := "111100000000";
  constant green : std_logic_vector(11 downto 0)  := "000011110000";
  constant blue : std_logic_vector(11 downto 0)   := "000000001111";
  constant black : std_logic_vector(11 downto 0)  := "000000000000";
  constant white : std_logic_vector(11 downto 0)  := "111111111111"; --unused

  type t_lut is array (0 to 639) of std_logic_vector(11 downto 0);
  constant lut : t_lut := (
    0 to 39 =>    red,
    40 to 79 =>   green,
    80 to 119 =>  blue,
    120 to 159 => black,
    160 to 199 => red,
    200 to 239 => green,
    240 to 279 => blue,
    280 to 319 => black,
    320 to 359 => red,
    360 to 399 => green,
    400 to 439 => blue,
    440 to 479 => black,
    480 to 519 => red,
    520 to 559 => green,
    560 to 599 => blue,
    600 to 639 => black);

  signal s_rgb_o : std_logic_vector(11 downto 0);

begin

  p_gen: process (clk_i, reset_i)
  begin
    if reset_i = '1' then --asynchronous reset (active high)
      s_rgb_o(11 downto 0) <= (others => '0');
    elsif clk_i'event and clk_i = '1' then --rising clock edge
      if pixel_valid_i = '1' then
        if pixel_en_i = '1' then
          s_rgb_o <= lut(to_integer(pixel_x_i));
        end if;
      else 
        s_rgb_o(11 downto 0) <= black(11 downto 0);
      end if;
    end if;
  end process p_gen;

rgb_o(11 downto 0) <= s_rgb_o(11 downto 0);

end rtl;




          -- case to_integer(pixel_x_i) is
          --   when 0 to 39 =>
          --     s_rgb_o(11 downto 0) <= red(11 downto 0);
          --   when 40 to 79 =>
          --     s_rgb_o(11 downto 0) <= green(11 downto 0);
          --   when 80 to 119 =>
          --     s_rgb_o(11 downto 0) <= blue(11 downto 0);
          --   when 120 to 159 =>
          --     s_rgb_o(11 downto 0) <= black(11 downto 0);
          --   when 160 to 199 =>
          --     s_rgb_o(11 downto 0) <= red(11 downto 0);
          --   when 200 to 239 =>
          --     s_rgb_o(11 downto 0) <= green(11 downto 0);
          --   when 240 to 279 =>
          --     s_rgb_o(11 downto 0) <= blue(11 downto 0);
          --   when 280 to 319 =>
          --     s_rgb_o(11 downto 0) <= black(11 downto 0);
          --   when 320 to 359 =>
          --     s_rgb_o(11 downto 0) <= red(11 downto 0);
          --   when 360 to 399 =>
          --     s_rgb_o(11 downto 0) <= green(11 downto 0);
          --   when 400 to 439 =>
          --     s_rgb_o(11 downto 0) <= blue(11 downto 0);
          --   when 440 to 479 =>
          --     s_rgb_o(11 downto 0) <= black(11 downto 0);
          --   when 480 to 519 =>
          --     s_rgb_o(11 downto 0) <= red(11 downto 0);
          --   when 520 to 559 =>
          --     s_rgb_o(11 downto 0) <= green(11 downto 0);
          --   when 560 to 599 =>
          --     s_rgb_o(11 downto 0) <= blue(11 downto 0);
          --   when 600 to 639 =>
          --     s_rgb_o(11 downto 0) <= black(11 downto 0);
          --   when others =>
          --     s_rgb_o(11 downto 0) <= black(11 downto 0);
          -- end case;