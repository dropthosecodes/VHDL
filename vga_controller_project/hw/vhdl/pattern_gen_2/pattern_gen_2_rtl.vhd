-------------------------------------------------------------------------------
-- VGA CONTROLLER PROJECT
-------------------------------------------------------------------------------
-- Author: Konstantin Haferl
--
-- Filename: pattern_gen_2_rtl.vhd
--
-- Date of Creation: 2023 09 22
--
-- Version: 1.0
--
-- Design Unit: Pattern Generator 2 (Architecture)
--
-- Description: The Pattern Generator 2 is part of the VGA controller project.
-- It generates a pattern of Red, Green and Blue rectangles on the 640x480 screen.
-- There are 10 rectangles in each row and column, meaning each one has a size
-- of 64x48 pixels. For each row the colors are shifted to the left once recangle wide.
--
-------------------------------------------------------------------------------

library IEEE; 
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

architecture rtl of pattern_gen_2 is

  constant column_width : integer := 64;
  constant row_height : integer   := 48;
  constant red : std_logic_vector(11 downto 0)    := "111100000000";
  constant green : std_logic_vector(11 downto 0)  := "000011110000";
  constant blue : std_logic_vector(11 downto 0)   := "000000001111";
  constant black : std_logic_vector(11 downto 0)  := "000000000000"; --unused
  constant white : std_logic_vector(11 downto 0)  := "111111111111"; --unused

  -- --115.2 KB
  -- --320x240x12bit image
  -- type rom is array (0 to 76799) of std_logic_vector(11 downto 0);

  type t_lut_column is array (0 to 767) of std_logic_vector(11 downto 0);
  constant lut_column : t_lut_column := (
    0 to 63 =>    red,
    64 to 127 =>  green,
    128 to 191 => blue,
    192 to 255 => red,
    256 to 319 => green,
    320 to 383 => blue,
    384 to 447 => red,
    448 to 511 => green,
    512 to 575 => blue,
    576 to 639 => red,
    640 to 703 => green,  --extended for shifting
    704 to 767 => blue);  --extended for shifting

  signal s_rgb_o : std_logic_vector(11 downto 0);

begin

  p_gen: process (clk_i, reset_i)
  begin
    if reset_i = '1' then --asynchronous reset (active high)
      s_rgb_o(11 downto 0) <= (others => '0');
    elsif clk_i'event and clk_i = '1' then --rising clock edge
      if pixel_valid_i = '1' then
        if pixel_en_i = '1' then
          case to_integer(pixel_y_i) is
            when 0 to 47 =>
              s_rgb_o <= lut_column(to_integer(pixel_x_i));
            when 48 to 95 =>
              s_rgb_o <= lut_column(to_integer(pixel_x_i + column_width));
            when 96 to 143 =>
              s_rgb_o <= lut_column(to_integer(pixel_x_i + column_width + column_width));
            when 144 to 191 =>
              s_rgb_o <= lut_column(to_integer(pixel_x_i));
            when 192 to 239 =>
              s_rgb_o <= lut_column(to_integer(pixel_x_i + column_width));
            when 240 to 287 =>
              s_rgb_o <= lut_column(to_integer(pixel_x_i + column_width + column_width));
            when 288 to 335 =>
              s_rgb_o <= lut_column(to_integer(pixel_x_i));
            when 336 to 383 =>
              s_rgb_o <= lut_column(to_integer(pixel_x_i + column_width));
            when 384 to 431 =>
              s_rgb_o <= lut_column(to_integer(pixel_x_i + column_width + column_width));
            when 432 to 479 =>
              s_rgb_o <= lut_column(to_integer(pixel_x_i));
            when others =>
              s_rgb_o <= black;
          end case;
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