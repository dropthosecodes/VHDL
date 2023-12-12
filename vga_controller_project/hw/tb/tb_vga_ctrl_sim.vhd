-------------------------------------------------------------------------------
-- VGA CONTROLLER PROJECT
-------------------------------------------------------------------------------
-- Author: Konstantin Haferl
--
-- Filename: tb_vga_ctrl_sim.vhd
--
-- Date of Creation: 2023 09 18
--
-- Version: 1.0
--
-- Design Unit: VGA Control Unit (Testbench)
--
-- Description: The VGA Control unit is part of the VGA controller project
-- It drives the VGA signals and generates the horizontal any vertical sync
-- counters for the memory controllers and pattern generators
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

architecture sim of tb_vga_ctrl is

  component vga_ctrl
    port (--from FPGA board
          reset_i :       in std_logic;                       --asynchronous reset (active high)
          clk_i :         in std_logic;                       --100 MHz system clock

          --from prescaler
          pixel_en_i :    in std_logic;                       --25 MHz pixel enable clock

          --from source multiplexer:
          rgb_i :         in std_logic_vector(11 downto 0);   --color information for a given pixel

          --to FPGA board:
          red_o :         out std_logic_vector(3 downto 0);   --red pixels (4 bit)
          green_o :       out std_logic_vector(3 downto 0);   --green pixels (4 bit)
          blue_o :        out std_logic_vector(3 downto 0);   --blue pixels (4 bit)
          hsync_o :       out std_logic;                      --horizontal sync 
          vsync_o :       out std_logic;                      --vertical sync
                          
          --to memory controllers and pattern generators
          pixel_x_o :     out unsigned(9 downto 0);          --horizonal pixel coordinates
          pixel_y_o :     out unsigned(9 downto 0);          --vertical pixel coordinated
          pixel_valid_o : out std_logic);                     --shows if the pixel coordinates are valid (in range of the actual screen)
          
          -- --OUTDATED
          -- --to source multiplexer (which forwards the signals to memory controllers and pattern generators)
          -- hsync_c_o :     out unsigned;                        --horizontal sync counter
          -- vsync_c_o :     out unsigned);                       --vertical sync counter
  end component;

  component vga_monitor
    generic(
      g_no_frames : integer range 1 to 99 := 1;
      g_path      : string                := "vga_output/"
      );
    port(
      s_reset_i     : in std_logic;
      s_vga_red_i   : in std_logic_vector(3 downto 0);
      s_vga_green_i : in std_logic_vector(3 downto 0);
      s_vga_blue_i  : in std_logic_vector(3 downto 0);
      s_vga_hsync_i : in std_logic;
      s_vga_vsync_i : in std_logic
      ); 
  end component;

  -- Declare the signals used stimulating the design's inputs.
  signal clk_i :          std_logic := '0';
  signal reset_i :        std_logic := '1';
  signal pixel_en_i :     std_logic := '0';
  signal rgb_i :          std_logic_vector(11 downto 0);-- := (others => '0');
  signal red_o :          std_logic_vector(3 downto 0);-- := (others => '0');
  signal green_o :        std_logic_vector(3 downto 0);-- := (others => '0');
  signal blue_o :         std_logic_vector(3 downto 0);-- := (others => '0');
  signal hsync_o :        std_logic;-- := '0';
  signal vsync_o :        std_logic;-- := '0';
  signal pixel_x_o :      unsigned(9 downto 0);-- := (others => '0');
  signal pixel_y_o :      unsigned(9 downto 0);-- := (others => '0');
  signal pixel_valid_o :  std_logic;-- := "0";
  
begin

  clk_i <= not clk_i after 5 ns;

  -- Instantiate the tb_io_ctrl design for testing
  i_tb_vga_ctrl : vga_ctrl
  port map
    (clk_i => clk_i,
     reset_i => reset_i,
     pixel_en_i => pixel_en_i,
     rgb_i => rgb_i,
     red_o => red_o,
     green_o => green_o,
     blue_o => blue_o,
     hsync_o => hsync_o,
     vsync_o => vsync_o,
     pixel_x_o => pixel_x_o,
     pixel_y_o => pixel_y_o,
     pixel_valid_o => pixel_valid_o);

  i_tb_vga_monitor : vga_monitor
  port map
    (s_reset_i => reset_i,
    s_vga_red_i   => red_o,
    s_vga_green_i => green_o,
    s_vga_blue_i  => blue_o,
    s_vga_hsync_i => hsync_o,
    s_vga_vsync_i => vsync_o);

  p_enable : process
    begin
      pixel_en_i <= '1';
      wait for 10 ns;
      pixel_en_i <= '0';
      wait for 30 ns;
  end process p_enable;

  p_test : process
    begin
      reset_i <= '1';
      rgb_i <= "111111001111";
      wait for 1 ms;
      reset_i <= '0';

      wait;
    end process p_test;

end sim;