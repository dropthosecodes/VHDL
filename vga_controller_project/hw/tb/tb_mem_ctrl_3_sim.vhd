-------------------------------------------------------------------------------
-- VGA CONTROLLER PROJECT
-------------------------------------------------------------------------------
-- Author: Konstantin Haferl
--
-- Filename: mem_ctrl_3_.vhd
--
-- Date of Creation: 2023 13 11
--
-- Version: 1.0
--
-- Design Unit: Memory Controller 3 (Testbench)
--
-- Description: The Memory Controller 3 is part of the VGA controller project.
-- The Memory Controller 3 generates addresses for a ROM where a 100x100x12bit
-- image is stored.
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

architecture sim of tb_mem_ctrl_3 is

  component mem_ctrl_3
    port (--from FPGA board
          reset_i :       in std_logic;                       --asynchronous reset (active high)
          clk_i :         in std_logic;                       --100 MHz system clock

          --from prescaler
          pixel_en_i :    in std_logic;                       --25 MHz pixel enable clock

          --from source multiplexer
          pixel_x_i :     in unsigned(6 downto 0);            --horizonal pixel coordinates
          pixel_y_i :     in unsigned(6 downto 0);            --vertical pixel coordinated
          pixel_valid_i : in std_logic;                       --shows if the pixel coordinates are valid (in range of the actual screen)
          
          --to source multiplexer
          rgb_o :         out std_logic_vector(11 downto 0)); --color information for a given pixel

  end component;
  
  -- Declare the signals used stimulating the design's inputs.
  signal clk_i :          std_logic := '1';
  signal reset_i :        std_logic := '1';
  signal pixel_en_i :     std_logic := '0';
  signal pixel_x_i :      unsigned(6 downto 0) := (others => '0');
  signal pixel_y_i :      unsigned(6 downto 0) := (others => '0');
  signal pixel_valid_i :  std_logic := '0';
  signal rgb_o :          std_logic_vector(11 downto 0);
  
begin

  clk_i <= not clk_i after 5 ns;

  -- Instantiate the tb_mem_ctrl_3 design for testing
  i_tb_mem_ctrl_3 : mem_ctrl_3
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
      wait for 200 us;
      pixel_valid_i <= '1';
      for i in 1 to 100 loop
        for k in 1 to 100 loop
          pixel_x_i <= to_unsigned(k, 7);
          pixel_y_i <= to_unsigned(i, 7);
          wait for 40 ns;
        end loop;
      end loop;
      pixel_valid_i <= '0';
      wait;
    end process p_pixels;

  p_test : process
    begin
      wait for 100 us;
      reset_i <= '0';
      wait;
    end process p_test;

end sim;