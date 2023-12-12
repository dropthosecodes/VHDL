-------------------------------------------------------------------------------
-- VGA CONTROLLER PROJECT
-------------------------------------------------------------------------------
-- Author: Konstantin Haferl
--
-- Filename: tb_src_mux_sim.vhd
--
-- Date of Creation: 2023 10 10
--
-- Version: 1.0
--
-- Design Unit: Source Multiplexer (Testbench)
--
-- Description: The Source Multiplexer is part of the VGA controller project.
-- It routes the RGB signals to the VGA Control Unit according to the
-- position of the switches on the Basys3 devboard .
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

architecture sim of tb_src_mux is

  component src_mux
    port (--from FPGA board
          reset_i :        in std_logic;                          --asynchronous reset (active high)
          clk_i :          in std_logic;                          --100 MHz system clock

          --from prescaler
          pixel_en_i :     in std_logic;                          --25 MHz pixel enable clock

          --from IO Logic Unit
          sw_i :           in std_logic_vector(5 downto 0);       --state of the 3 input switches
          pb_i :           in std_logic_vector(3 downto 0);       --state of the 4 input push buttons (debounced)

          --from pattern generators
          pat1_rgb_i :     in std_logic_vector(11 downto 0);      --color information from pattern generator 1
          pat2_rgb_i :     in std_logic_vector(11 downto 0);      --color information from pattern generator 2
          
          --from memory controllers
          mem1_rgb_i :     in std_logic_vector(11 downto 0);      --color information from memory controller 1
          mem2_rgb_i :     in std_logic_vector(11 downto 0);      --color information from memory controller 2
          mem3_rgb_i :     in std_logic_vector(11 downto 0);      --color information from memory controller 3

          --to mem_ctrl2
          mem2_pixel_x_o :      out unsigned(6 downto 0);         --horizontal pixel coordinates for mem_ctrl2
          mem2_pixel_y_o :      out unsigned (6 downto 0);        --vertical pixel coordinates for mem_ctrl2
          mem2_pixel_valid_o :  out std_logic;                    --pixel valid signal for mem_ctrl2

          --to mem_ctrl3
          mem3_pixel_x_o :      out unsigned(6 downto 0);         --horizontal pixel coordinates for mem_ctrl3
          mem3_pixel_y_o :      out unsigned (6 downto 0);        --vertical pixel coordinates for mem_ctrl3
          mem3_pixel_valid_o :  out std_logic;                    --pixel valid signal for mem_ctrl3

          --from VGA control (for moving image)
          pixel_x_i :      in unsigned(9 downto 0);               --horizonal pixel coordinates
          pixel_y_i :      in unsigned(9 downto 0);               --vertical pixel coordinated
          pixel_valid_i :  in std_logic;                          --shows if the pixel coordinates are valid (in range of the actual screen)
          
          --to VGA control
          rgb_o :          out std_logic_vector(11 downto 0));    --color information for a given pixel

  end component;
  
  -- Declare the signals used stimulating the design's inputs.
  constant LEFT : std_logic_vector(3 downto 0) := "1000";
  constant UP : std_logic_vector(3 downto 0) := "0100";
  constant DOWN : std_logic_vector(3 downto 0) := "0010";
  constant RIGHT : std_logic_vector(3 downto 0) := "0001";
  constant OFF : std_logic_vector(3 downto 0) := "0000";

  signal clk_i :            std_logic := '1';
  signal reset_i :          std_logic := '1';
  signal pixel_en_i :       std_logic := '0';
  signal sw_i :             std_logic_vector(5 downto 0) := (others => '0');
  signal pb_i :             std_logic_vector(3 downto 0) := (others => '0');
  signal pat1_rgb_i :       std_logic_vector(11 downto 0) := (others => '0');
  signal pat2_rgb_i :       std_logic_vector(11 downto 0) := (others => '0');
  signal mem1_rgb_i :       std_logic_vector(11 downto 0) := (others => '0');
  signal mem2_rgb_i :       std_logic_vector(11 downto 0) := (others => '0');
  signal mem3_rgb_i :       std_logic_vector(11 downto 0) := (others => '0');
  signal mem2_pixel_x_o :   unsigned(6 downto 0) := (others => '0');
  signal mem2_pixel_y_o :   unsigned(6 downto 0) := (others => '0');
  signal mem2_pixel_valid_o : std_logic := '0';
  signal mem3_pixel_x_o :   unsigned(6 downto 0) := (others => '0');
  signal mem3_pixel_y_o :   unsigned(6 downto 0) := (others => '0');
  signal mem3_pixel_valid_o : std_logic := '0';
  signal pixel_x_i :        unsigned(9 downto 0) := (others => '0');
  signal pixel_y_i :        unsigned(9 downto 0) := (others => '0');
  signal pixel_valid_i :    std_logic := '0';
  
  signal rgb_o :          std_logic_vector(11 downto 0);
  
begin

  clk_i <= not clk_i after 5 ns;

  -- Instantiate the tb_src_mux design for testing
  i_tb_src_mux : src_mux
  port map
    (clk_i => clk_i,
     reset_i => reset_i,
     pixel_en_i => pixel_en_i,
     sw_i => sw_i,
     pb_i => pb_i,
     pat1_rgb_i => pat1_rgb_i,
     pat2_rgb_i => pat2_rgb_i,
     mem1_rgb_i => mem1_rgb_i,
     mem2_rgb_i => mem2_rgb_i,
     mem3_rgb_i => mem3_rgb_i,
     mem2_pixel_x_o => mem2_pixel_x_o,
     mem2_pixel_y_o => mem2_pixel_y_o,
     mem2_pixel_valid_o => mem2_pixel_valid_o,
     mem3_pixel_x_o => mem3_pixel_x_o,
     mem3_pixel_y_o => mem3_pixel_y_o,
     mem3_pixel_valid_o => mem3_pixel_valid_o,
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

  p_test : process
    begin
      wait for 50 ns;
      reset_i <= '0';
      wait for 10 us;
      sw_i <= "000110";
      pat2_rgb_i <= "101010101010";
      wait for 1 us;
      pb_i <= "1000";
      wait for 1 us;
      pb_i <= "0100";
      wait for 1 us;
      pb_i <= "0010";
      wait for 1 us;
      pb_i <= "0001";
      wait;

      pb_i <= RIGHT; 
      wait for 1 ns;
      pb_i <= OFF;     
      wait;
    end process p_test;

end sim;