-------------------------------------------------------------------------------
-- VGA CONTROLLER PROJECT
-------------------------------------------------------------------------------
-- Author: Konstantin Haferl
--
-- Filename: tb_pattern_gen_2_sim.vhd
--
-- Date of Creation: 2023 09 22
--
-- Version: 1.0
--
-- Design Unit: Pattern Generator 2 (Testbench)
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

architecture sim of tb_pattern_gen_2 is

  component pattern_gen_2
    port (--from FPGA board
          reset_i :       in std_logic;                       --asynchronous reset (active high)
          clk_i :         in std_logic;                       --100 MHz system clock

          --from prescaler
          pixel_en_i :    in std_logic;                       --25 MHz pixel enable clock

          --from VGA control
          pixel_x_i :     in unsigned(9 downto 0);            --horizonal pixel coordinates
          pixel_y_i :     in unsigned(9 downto 0);            --vertical pixel coordinated
          pixel_valid_i : in std_logic;                       --shows if the pixel coordinates are valid (in range of the actual screen)
          
          --to source multiplexer:
          rgb_o :         out std_logic_vector(11 downto 0)); --color information for a given pixel

  end component;
  
  -- Declare the signals used stimulating the design's inputs.
  signal clk_i :          std_logic := '1';
  signal reset_i :        std_logic := '1';
  signal pixel_en_i :     std_logic := '0';
  signal pixel_x_i :      unsigned(9 downto 0) := (others => '0');
  signal pixel_y_i :      unsigned(9 downto 0) := (others => '0');
  signal pixel_valid_i :  std_logic := '0';
  signal rgb_o :          std_logic_vector(11 downto 0);
  
begin

  clk_i <= not clk_i after 5 ns;

  -- Instantiate the tb_pattern_gen_2 design for testing
  i_tb_pattern_gen_2 : pattern_gen_2
  port map
    (clk_i => clk_i,
     reset_i => reset_i,
     pixel_en_i => pixel_en_i,
     pixel_x_i => pixel_x_i,
     pixel_y_i => pixel_y_i,
     pixel_valid_i => pixel_valid_i,
     rgb_o => rgb_o);


  p_enable : process
    begin
      pixel_en_i <= '1';
      wait for 10 ns;
      pixel_en_i <= '0';
      wait for 30 ns;
  end process p_enable;

  p_pixels : process
    begin
      pixel_valid_i <= '1';
      for i in 0 to 479 loop
        for k in 0 to 639 loop
          pixel_x_i <= to_unsigned(k, 10);
          pixel_y_i <= to_unsigned(i, 10);
          wait for 40 ns;
        end loop;
      end loop;
      wait;
    end process p_pixels;

  p_test : process
    begin
      wait for 1 ms;
      reset_i <= '0';
      wait for 10 ms;
      
      wait;
    end process p_test;

end sim;