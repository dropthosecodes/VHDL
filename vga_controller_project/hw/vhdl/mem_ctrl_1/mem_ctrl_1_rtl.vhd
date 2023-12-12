-------------------------------------------------------------------------------
-- VGA CONTROLLER PROJECT
-------------------------------------------------------------------------------
-- Author: Konstantin Haferl
--
-- Filename: mem_ctrl_1_rtl.vhd
--
-- Date of Creation: 2023 09 22
--
-- Version: 1.0
--
-- Design Unit: Memory Controller 1 (Architecture)
--
-- Description: The Memory Controller 1 is part of the VGA controller project.
-- The Memory Controller 1 generates addresses for a ROM where a 320x240x12bit
-- image is stored.
-- The Controller uses the x and y coordinates of the current pixel as input 
-- to calculate the necessary address in the ROM. Since the image is only a
-- quarter of the size of the actual 640x480 screen, it shall be displayed 4 times.
--
-------------------------------------------------------------------------------

library IEEE; 
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

architecture rtl of mem_ctrl_1 is

  COMPONENT rom1
    PORT (
      clka :  IN STD_LOGIC;
      addra : IN STD_LOGIC_VECTOR(16 DOWNTO 0);
      douta : OUT STD_LOGIC_VECTOR(11 DOWNTO 0));
  END COMPONENT;

  --width and height of the 4 sub-screens
  constant split_width :  integer := 320;
  constant split_height : integer := 240;

  signal s_addra : std_logic_vector(16 downto 0) := (others => '0');

begin

  i_rom : rom1
  PORT MAP (
    clka => clk_i,
    addra => s_addra,
    douta => rgb_o
  );

  p_addr: process (clk_i, reset_i)

  variable screen :  integer := 0;
  variable addr_s1 : unsigned(16 downto 0) := (others => '0');
  variable addr_s2 : unsigned(16 downto 0) := (others => '0');
  variable addr_s3 : unsigned(16 downto 0) := (others => '0');
  variable addr_s4 : unsigned(16 downto 0) := (others => '0');

  begin
    if reset_i = '1' then --asynchronous reset (active high)
      s_addra <= (others => '0');
      screen  := 0;
      addr_s1 := (others => '0');
      addr_s2 := (others => '0');
      addr_s3 := (others => '0');
      addr_s4 := (others => '0');
    elsif clk_i'event and clk_i = '1' then --rising clock edge
      if pixel_valid_i = '1' then
        if pixel_en_i = '1' then

          --SCREEN SELECTION
          if    (to_integer(pixel_x_i) < split_width) and (to_integer(pixel_y_i) < split_height) then
            screen := 1;
          elsif (to_integer(pixel_x_i) >= split_width) and (to_integer(pixel_y_i) < split_height) then
            screen := 2;
          elsif (to_integer(pixel_x_i) < split_width) and (to_integer(pixel_y_i) >= split_height) then
            screen := 3;
          elsif (to_integer(pixel_x_i) >= split_width) and (to_integer(pixel_y_i) >= split_height) then
            screen := 4;
          end if;

          --FRAME RESET
          if(pixel_x_i = 0) and (pixel_y_i = 0) then
            addr_s1 := (others => '0');
            addr_s2 := (others => '0');
            addr_s3 := (others => '0');
            addr_s4 := (others => '0');
          end if;

          --ADDRESS SELECTION
          case screen is
            when 1 =>
              s_addra <= std_logic_vector(addr_s1);
              addr_s1 := addr_s1 + 1;
            when 2 =>
              s_addra <= std_logic_vector(addr_s2);
              addr_s2 := addr_s2 + 1;
            when 3 =>
              s_addra <= std_logic_vector(addr_s3);
              addr_s3 := addr_s3 + 1;
            when 4 =>
              s_addra <= std_logic_vector(addr_s4);
              addr_s4 := addr_s4 + 1;
            when others =>
              s_addra <= "00000000000000000";
          end case;
        end if;
      else --nothing

      end if;
    end if;
  end process p_addr;

end rtl;