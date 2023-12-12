-------------------------------------------------------------------------------
-- VGA CONTROLLER PROJECT
-------------------------------------------------------------------------------
-- Author: Konstantin Haferl
--
-- Filename: vga_ctrl_rtl.vhd
--
-- Date of Creation: 2023 09 18
--
-- Version: 1.0
--
-- Design Unit: VGA Control Unit (Architecture)
--
-- Description: The VGA Control unit is part of the VGA controller project
-- It drives the VGA signals and generates the horizontal any vertical sync
-- counters for the memory controllers and pattern generators
--
-------------------------------------------------------------------------------

library IEEE; 
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

architecture rtl of vga_ctrl is

  constant h_visible_len :    integer := 640;   --25.6 us
  constant h_frontporch_len : integer := 16;    --0.64 us
  constant h_sync_pulse_len : integer := 96;    --3.84 us
  constant h_backporch_len :  integer := 48;    --1.92 us
  constant h_no_sync_len :    integer := 704;   --
  constant h_entire_len :     integer := 800;   --32 us

  constant v_visible_len :    integer := 480;   --15.36 ms
  constant v_frontporch_len : integer := 10;    --0.32 ms
  constant v_sync_pulse_len : integer := 2;     --0.064 ms
  constant v_backporch_len :  integer := 33;    --1.056 ms
  constant v_no_sync_len :    integer := 523;   --
  constant v_entire_len :     integer := 525;   --16.8 ms

  signal s_hcounter : integer;
  signal s_vcounter : integer;

  type t_region is (v_backporch_s, v_sync_s, v_frontporch_s, 
                    h_backporch_s, h_sync_s, h_frontporch_s, display_s);

  signal s_region : t_region;

  signal s_rgb_o :          std_logic_vector(11 downto 0);
  signal s_hsync_o :        std_logic;
  signal s_vsync_o :        std_logic;
  signal s_pixel_x_o :      unsigned(9 downto 0);
  signal s_pixel_y_o :      unsigned(9 downto 0);
  signal s_pixel_valid_o :  std_logic;
  signal vsync_flag :       integer;

begin

  --2 processes: 
  --    process 1 sets s_region state via s_hcounter and v_hcounter and the defined constant lengths
  --    process 2 defines what happens inside the states, e.g.
  
  p_control_state: process (clk_i, reset_i)
  begin
    if reset_i = '1' then --asynchronous reset (active high)
      s_hcounter <= 0;
      s_vcounter <= 0;
      s_region <= v_backporch_s;
      s_hsync_o <= '0';
      s_vsync_o <= '0';
      s_pixel_x_o <= (others => '0');
      s_pixel_y_o <= (others => '0');
      s_pixel_valid_o <= '0';
      vsync_flag <= 0;
    elsif clk_i'event and clk_i = '1' then --rising clock edge
      if pixel_en_i = '1' then
        s_hcounter <= s_hcounter + 1; --increase horizontal counter at every pixel enable clock
        case s_region is
          when v_backporch_s =>
            if s_hcounter = (h_no_sync_len - 1) then
              s_region <= h_sync_s;
              s_hsync_o <= '1';
            end if;
            
          when h_backporch_s =>
            if s_hcounter = (h_backporch_len - 1) then
              s_region <= display_s;
              s_pixel_valid_o <= '1';
            end if;

          when display_s =>
            s_pixel_x_o <= to_unsigned(to_integer(s_pixel_x_o) + 1, 10);

            if s_hcounter = (h_backporch_len + h_visible_len - 1) then
              s_region <= h_frontporch_s;
              s_pixel_valid_o <= '0';
              s_pixel_y_o <= to_unsigned(to_integer(s_pixel_y_o) + 1, 10);
            end if;

          when h_frontporch_s =>
            if s_hcounter = (h_no_sync_len - 1) then
                s_region <= h_sync_s;
                s_hsync_o <= '1';
            end if;

          when h_sync_s =>
            if s_hcounter = (h_entire_len - 1) then
              s_hcounter <= 0;
              
              --IM VERTICAL SYNC
              if s_vcounter >= (v_no_sync_len) then
                s_vcounter <= s_vcounter + 1;
                s_region <= v_sync_s;
                s_hsync_o <= '0';
                if vsync_flag = 2 then
                  s_vcounter <= 0;
                  s_hcounter <= 0;
                  s_region <= v_backporch_s;
                  s_vsync_o <= '0';
                  s_hsync_o <= '0';
                  s_pixel_x_o <= (others => '0');
                  s_pixel_y_o <= (others => '0');
                  vsync_flag <= 0;
                end if;
                
              --IM VERTICAL FRONTPORCH
              elsif s_vcounter >= (v_backporch_len + v_visible_len-1) then
                s_vcounter <= s_vcounter + 1;
                s_region <= v_frontporch_s;
                s_hsync_o <= '0';
                
                --end of display
                if s_vcounter = (v_no_sync_len-1) then
                  s_hcounter <= 0;
                  s_region <= v_sync_s;
                  s_vsync_o <= '1';
                end if;
              --IM VERTICAL BACKPORCH
              elsif s_vcounter < (v_backporch_len-1) then
                s_vcounter <= s_vcounter + 1;
                s_region <= v_backporch_s;
                s_hsync_o <= '0';
              --DAZWISCHEN
              else
                s_vcounter <= s_vcounter + 1;
                s_region <= h_backporch_s;
                s_hsync_o <= '0';
                s_pixel_x_o <= (others => '0');
              end if;
          end if;

          when v_frontporch_s =>
            if s_hcounter = (h_no_sync_len - 1) then
              s_region <= h_sync_s;
              s_hsync_o <= '1';
            end if;

          when v_sync_s => --vsync duration = 2 lines
            case vsync_flag is
              when 0 =>
                if s_hcounter = (h_no_sync_len - 1) then
                  s_region <= h_sync_s;
                  s_hsync_o <= '1';
                  vsync_flag <= 1;
                end if;
              when 1 =>
                s_hsync_o <= '0';
                if s_hcounter = (h_no_sync_len - 1) then
                  s_region <= h_sync_s;
                  s_hsync_o <= '1';
                  vsync_flag <= 2;
                end if;
              when others =>
            end case;
        end case;
      end if;
    end if;
  end process p_control_state;

  p_control: process (clk_i, reset_i)
  begin
    if reset_i = '1' then --asynchronous reset (active high)
      s_rgb_o <= (others => '0');
    elsif clk_i'event and clk_i = '1' then --rising clock edge
      case s_region is
        when v_backporch_s =>
          s_rgb_o <= (others => '0');
        when v_sync_s =>
          s_rgb_o <= (others => '0');
        when v_frontporch_s =>
          s_rgb_o <= (others => '0');
        when h_backporch_s =>
          s_rgb_o <= (others => '0');
        when h_sync_s =>
          s_rgb_o <= (others => '0');
        when h_frontporch_s =>
          s_rgb_o <= (others => '0');
        when display_s => --timing & delay gschichtln
          s_rgb_o <= rgb_i;
        when others =>
      end case;
    end if;
  end process p_control;

  hsync_o <= s_hsync_o;
  vsync_o <= s_vsync_o;
  pixel_x_o <= s_pixel_x_o;
  pixel_y_o <= s_pixel_y_o;
  pixel_valid_o <= s_pixel_valid_o;

  red_o <= s_rgb_o(11 downto 8);
  green_o <= s_rgb_o(7 downto 4);
  blue_o <= s_rgb_o(3 downto 0);

end rtl;