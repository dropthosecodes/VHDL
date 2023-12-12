-------------------------------------------------------------------------------
-- VGA CONTROLLER PROJECT
-------------------------------------------------------------------------------
-- Author: Konstantin Haferl
--
-- Filename: mem_ctrl_3_.vhd
--
-- Date of Creation: 2023 11 15
--
-- Version: 1.0
--
-- Design Unit: Memory Controller 3 (Architecture)
--
-- Description: The Memory Controller 3 is part of the VGA controller project.
-- The Memory Controller 3 generates addresses for a ROM where a 100x100x12bit
-- image is stored.
--
-------------------------------------------------------------------------------

library IEEE; 
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

architecture rtl of mem_ctrl_3 is

  COMPONENT rom3
    PORT (
      clka :  IN STD_LOGIC;
      addra : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
      douta : OUT STD_LOGIC_VECTOR(11 DOWNTO 0));
  END COMPONENT;

  constant width : integer := 100;
  constant height : integer := 100;

  signal s_addra : std_logic_vector(13 downto 0);-- := (others => '0');

begin

  i_rom : rom3
  PORT MAP (
    clka => clk_i,
    addra => s_addra,
    douta => rgb_o
  );

  p_addr: process (clk_i, reset_i)

  variable screen :  integer := 0;
  variable addr : unsigned(13 downto 0) := (others => '0');

  begin
    if reset_i = '1' then --asynchronous reset (active high)
      s_addra <= (others => '0');
      addr := (others => '0');
    elsif clk_i'event and clk_i = '1' then --rising clock edge
      if pixel_valid_i = '1' then
        if pixel_en_i = '1' then

          --ADDRESS SELECTION
          if (pixel_x_i >= 1) and (pixel_x_i <= 100) then
            if (pixel_y_i >= 1) and (pixel_y_i <= 100) then
              s_addra <= std_logic_vector(unsigned(s_addra) + 1);
            end if;
          end if;

          --FRAME RESET
          if(pixel_x_i = 1) and (pixel_y_i = 1) then
            s_addra <= "00000000000000";
          end if;
              
        end if;
      else --nothing

      end if;
    end if;
  end process p_addr;

end rtl;