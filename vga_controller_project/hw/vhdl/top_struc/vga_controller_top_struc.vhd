-------------------------------------------------------------------------------
-- VGA CONTROLLER PROJECT
-------------------------------------------------------------------------------
-- Author: Konstantin Haferl
--
-- Filename: vga_controller_top_struc.vhd
--
-- Date of Creation: 2023 11 06
--
-- Version: 1.0
--
-- Design Unit: Top-Level Design of the VGA Controller (Architecture)
--
-- Description: This is the top-level design of the VGA Controller project.
-- It interconnects all sub-units and interfaces to the circuitry of the
-- Digilent Basys3 FPGA board.
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

architecture struc of vga_controller_top is

  component io_logic is
    port (--from FPGA board
          reset_i :       in std_logic;                       --asynchronous reset (active high)
          clk_i :         in std_logic;                       --100 MHz system clock
          sw_i :          in std_logic_vector(5 downto 0);    --the 3 input switches
          pb_i :          in std_logic_vector(3 downto 0);    --the 4 input push buttons
  
          --to source multiplexer
          sw_o :      out std_logic_vector(5 downto 0);        --state of the 3 input switches
          pb_o :      out std_logic_vector(3 downto 0));       --state of the 4 input push buttons (debounced)

  end component;

  component mem_ctrl_1 is
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

  component mem_ctrl_2 is
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

  component mem_ctrl_3 is
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

  component pattern_gen_1 is
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

  component pattern_gen_2 is
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

  component prescaler is
    port (--from FPGA board:
          clk_i :         in std_logic;                       --100 MHz system clock
          reset_i :       in std_logic;                      --asynchronous reset (active high)
  
          --to all other components
          pixel_en_o :      out std_logic);                   --25 MHz pixel enable clock
  
  end component;

  component src_mux is
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

  component vga_ctrl is
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
          pixel_x_o :     out unsigned(9 downto 0);           --horizonal pixel coordinates
          pixel_y_o :     out unsigned(9 downto 0);           --vertical pixel coordinated
          pixel_valid_o : out std_logic);                     --shows if the pixel coordinates are valid (in range of the actual screen)
          
          -- --OUTDATED
          -- --to source multiplexer (which forwards the signals to memory controllers and pattern generators)
          -- hsync_c_o :     out unsigned;                        --horizontal sync counter
          -- vsync_c_o :     out unsigned);                       --vertical sync counter
  end component;

  signal s_pixel_en : std_logic;
  signal s_pixel_x :  unsigned(9 downto 0);
  signal s_pixel_y :  unsigned(9 downto 0);
  signal s_pixel_valid : std_logic;
  signal s_sw : std_logic_vector(5 downto 0);
  signal s_pb : std_logic_vector(3 downto 0);
  signal s_rgb_mem_1 : std_logic_vector(11 downto 0);
  signal s_rgb_mem_2 : std_logic_vector(11 downto 0);
  signal s_rgb_mem_3 : std_logic_vector(11 downto 0);
  signal s_rgb_pat_1 : std_logic_vector(11 downto 0);
  signal s_rgb_pat_2 : std_logic_vector(11 downto 0);
  signal s_rgb_mux : std_logic_vector(11 downto 0);

  signal s_mem2_pixel_x : unsigned(6 downto 0);
  signal s_mem2_pixel_y : unsigned(6 downto 0);
  signal s_mem2_pixel_valid : std_logic;
  signal s_mem3_pixel_x : unsigned(6 downto 0);
  signal s_mem3_pixel_y : unsigned(6 downto 0);
  signal s_mem3_pixel_valid : std_logic;

  begin

    i_io_logic : io_logic
    port map
    (clk_i => clk_i,
      reset_i => reset_i,
      sw_i => sw_i,
      pb_i => pb_i,
      sw_o => s_sw,
      pb_o => s_pb);

    i_mem_ctrl_1 : mem_ctrl_1
    port map
    (clk_i => clk_i,
      reset_i => reset_i,
      pixel_en_i => s_pixel_en,
      pixel_x_i => s_pixel_x,
      pixel_y_i => s_pixel_y,
      pixel_valid_i => s_pixel_valid,
      rgb_o => s_rgb_mem_1);

    i_mem_ctrl_2 : mem_ctrl_2
    port map
    (clk_i => clk_i,
      reset_i => reset_i,
      pixel_en_i => s_pixel_en,
      pixel_x_i => s_mem2_pixel_x,
      pixel_y_i => s_mem2_pixel_y,
      pixel_valid_i => s_mem2_pixel_valid,
      rgb_o => s_rgb_mem_2);

    i_mem_ctrl_3 : mem_ctrl_3
    port map
    (clk_i => clk_i,
      reset_i => reset_i,
      pixel_en_i => s_pixel_en,
      pixel_x_i => s_mem3_pixel_x,
      pixel_y_i => s_mem3_pixel_y,
      pixel_valid_i => s_mem3_pixel_valid,
      rgb_o => s_rgb_mem_3);

    i_pattern_gen_1 : pattern_gen_1
    port map
    (clk_i => clk_i,
      reset_i => reset_i,
      pixel_en_i => s_pixel_en,
      pixel_x_i => s_pixel_x,
      pixel_y_i => s_pixel_y,
      pixel_valid_i => s_pixel_valid,
      rgb_o => s_rgb_pat_1);

    i_pattern_gen_2 : pattern_gen_2
    port map
    (clk_i => clk_i,
      reset_i => reset_i,
      pixel_en_i => s_pixel_en,
      pixel_x_i => s_pixel_x,
      pixel_y_i => s_pixel_y,
      pixel_valid_i => s_pixel_valid,
      rgb_o => s_rgb_pat_2);

    i_prescaler : prescaler
    port map
    (clk_i => clk_i,
      reset_i => reset_i,
      pixel_en_o => s_pixel_en);

    i_src_mux : src_mux
    port map
    (clk_i => clk_i,
      reset_i => reset_i,
      pixel_en_i => s_pixel_en,
      sw_i => s_sw,
      pb_i => s_pb,
      pat1_rgb_i => s_rgb_pat_1,
      pat2_rgb_i => s_rgb_pat_2,
      mem1_rgb_i => s_rgb_mem_1,
      mem2_rgb_i => s_rgb_mem_2,
      mem3_rgb_i => s_rgb_mem_3,
      mem2_pixel_x_o => s_mem2_pixel_x,
      mem2_pixel_y_o => s_mem2_pixel_y,
      mem2_pixel_valid_o => s_mem2_pixel_valid,
      mem3_pixel_x_o => s_mem3_pixel_x,
      mem3_pixel_y_o => s_mem3_pixel_y,
      mem3_pixel_valid_o => s_mem3_pixel_valid,
      pixel_x_i => s_pixel_x,
      pixel_y_i => s_pixel_y,
      pixel_valid_i => s_pixel_valid,
      rgb_o => s_rgb_mux);

    i_vga_ctrl : vga_ctrl
    port map
    (clk_i => clk_i,
      reset_i => reset_i,
      pixel_en_i => s_pixel_en,
      rgb_i => s_rgb_mux,
      red_o => rgb_o(11 downto 8),
      green_o => rgb_o(7 downto 4),
      blue_o => rgb_o(3 downto 0),
      hsync_o => hsync_o,
      vsync_o => vsync_o,
      pixel_x_o => s_pixel_x,
      pixel_y_o => s_pixel_y,
      pixel_valid_o => s_pixel_valid);

end struc;