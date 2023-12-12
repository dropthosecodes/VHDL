-------------------------------------------------------------------------------
-- VGA CONTROLLER PROJECT
-------------------------------------------------------------------------------
-- Author: Konstantin Haferl
--
-- Filename: tb_mem_ctrl_1_sim.vhd
--
-- Date of Creation: 2023 09 22
--
-- Version: 1.0
--
-- Design Unit: Memory Controller 1 (Testbench)
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

architecture sim of tb_mem_ctrl_1 is

  component mem_ctrl_1
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

  -- Instantiate the tb_mem_ctrl_1 design for testing
  i_tb_mem_ctrl_1 : mem_ctrl_1
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
      wait for 2 ms;
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