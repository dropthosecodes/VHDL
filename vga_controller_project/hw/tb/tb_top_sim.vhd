-------------------------------------------------------------------------------
-- VGA CONTROLLER PROJECT
-------------------------------------------------------------------------------
-- Author: Konstantin Haferl
--
-- Filename: tb_top_sim.vhd
--
-- Date of Creation: 2023 11 06
--
-- Version: 1.0
--
-- Design Unit: Top-Level Design of the VGA Controller (Testbench)
--
-- Description: This is the top-level design of the VGA Controller project.
-- It interconnects all sub-units and interfaces to the circuitry of the
-- Digilent Basys3 FPGA board.
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

architecture sim of tb_top is

  component vga_controller_top
    port(--from FPGA board:
        reset_i :       in std_logic;                       --asynchronous reset (active high)
        clk_i :         in std_logic;                       --100 MHz system clock
        sw_i :          in std_logic_vector(5 downto 0);    --the 3 input switches
        pb_i :          in std_logic_vector(3 downto 0);    --the 4 input push buttons

        --to FPGA board:
        -- red_o :         out std_logic_vector(3 downto 0);   --red pixels (4 bit)
        -- green_o :       out std_logic_vector(3 downto 0);   --green pixels (4 bit)
        -- blue_o :        out std_logic_vector(3 downto 0);   --blue pixels (4 bit)

        rgb_o :         out std_logic_vector(11 downto 0);  --RGB signals
        hsync_o :       out std_logic;                      --horizontal sync 
        vsync_o :       out std_logic);                     --vertical sync
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
  constant LEFT : std_logic_vector(3 downto 0) := "1000";
  constant UP : std_logic_vector(3 downto 0) := "0100";
  constant DOWN : std_logic_vector(3 downto 0) := "0010";
  constant RIGHT : std_logic_vector(3 downto 0) := "0001";
  constant OFF : std_logic_vector(3 downto 0) := "0000";
  
  signal clk_i :          std_logic := '0';
  signal reset_i :        std_logic := '1';
  signal sw_i :           std_logic_vector(5 downto 0);
  signal pb_i :           std_logic_vector(3 downto 0);
  signal rgb_o :          std_logic_vector(11 downto 0);-- := (others => '0');
  signal hsync_o :        std_logic;-- := '0';
  signal vsync_o :        std_logic;-- := '0';
  
begin

  clk_i <= not clk_i after 5 ns;

  -- Instantiate the tb_io_ctrl design for testing
  i_tb_vga_controller_top : vga_controller_top
  port map
    (clk_i => clk_i,
     reset_i => reset_i,
     sw_i => sw_i,
     pb_i => pb_i,
     rgb_o => rgb_o,
     hsync_o => hsync_o,
     vsync_o => vsync_o);

  i_tb_vga_monitor : vga_monitor
  port map
    (s_reset_i => reset_i,
    s_vga_red_i   => rgb_o(11 downto 8),
    s_vga_green_i => rgb_o(7 downto 4),
    s_vga_blue_i  => rgb_o(3 downto 0),
    s_vga_hsync_i => hsync_o,
    s_vga_vsync_i => vsync_o);

  p_test : process
    begin
      reset_i <= '1';
      pb_i <= "0000";
      sw_i <= "001101"; --mem1
      -- sw_i <= "000100"; --pat1
      -- sw_i <= "000010"; --pat2
      wait for 1 ms;
      reset_i <= '0';
      wait for 100 us;

      wait;
    end process p_test;

end sim;