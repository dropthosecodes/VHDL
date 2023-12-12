-------------------------------------------------------------------------------
-- VGA CONTROLLER PROJECT
-------------------------------------------------------------------------------
-- Author: Konstantin Haferl
--
-- Filename: src_mux_.vhd
--
-- Date of Creation: 2023 10 10
--
-- Version: 1.0
--
-- Design Unit: Source Multiplexer (Architecture)
--
-- Description: The Source Multiplexer is part of the VGA controller project.
-- It routes the RGB signals to the VGA Control Unit according to the
-- position of the switches on the Basys3 devboard .
--
-------------------------------------------------------------------------------

library IEEE; 
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

architecture rtl of src_mux is
  
  constant DELAY : unsigned(9 downto 0) := "0000000000";   --0 --OLD: 2
  constant MOVE : unsigned(9 downto 0) := "0000100000";    --32
  constant mem23_width : unsigned(9 downto 0) := "0001100100";  --100
  constant mem23_height : unsigned(9 downto 0) := "0001100100"; --100
  constant screen_width : unsigned(9 downto 0) := "1010000000";  --640
  constant screen_height : unsigned(9 downto 0) := "0111100000";  --480

  constant mem23_min_x : unsigned(9 downto 0) := "0000000001";
  constant mem23_max_x : unsigned(9 downto 0) := (screen_width - mem23_width - DELAY);

  constant mem23_min_y : unsigned(9 downto 0) := "0000000000";
  constant mem23_max_y : unsigned(9 downto 0) := (screen_height - mem23_height);
  
  constant LEFT : std_logic_vector(3 downto 0) := "1000";
  constant UP : std_logic_vector(3 downto 0) := "0100";
  constant DOWN : std_logic_vector(3 downto 0) := "0010";
  constant RIGHT : std_logic_vector(3 downto 0) := "0001";
  constant OFF : std_logic_vector(3 downto 0) := "0000";

  constant MEM_BLACK : std_logic_vector(11 downto 0) := "000000000000"; --0

  constant C_ANIMCOUNTVAL : integer := 50000000;

  signal counter : integer := 0;
  signal s_anim : std_logic;

  signal s_rgb_o : std_logic_vector(11 downto 0);
  signal s_mem23_pixel_x : unsigned(9 downto 0);
  signal s_mem23_pixel_y : unsigned(9 downto 0);
  signal s_mem23_pixel_valid : std_logic;

  signal s_mem23_loc_x : unsigned(9 downto 0);
  signal s_mem23_loc_y : unsigned(9 downto 0);

  --MCP8051
  signal s_reset_8051 : std_logic;

  signal s_p3_i : std_logic_vector(7 downto 0);

  signal s_p0_o : std_logic_vector(7 downto 0);
  signal s_p1_o : std_logic_vector(7 downto 0);
  signal s_p2_o : std_logic_vector(7 downto 0);
  signal s_p3_o : std_logic_vector(7 downto 0);

  signal s_mc8051_loc_x : unsigned(9 downto 0);
  signal s_mc8051_loc_y : unsigned(9 downto 0);

  signal s_mc8051_int0 : std_logic_vector(C_IMPL_N_EXT-1 downto 0);

  constant C_CLKCOUNTVAL : integer := 2;
  signal s_mc8051_clock : std_logic;

begin

  -- instantiation of the mc8051 IP core:
  i_mc8051_top : mc8051_top
  port map (
    reset     => reset_i,
    int0_i    => s_mc8051_int0,
    int1_i    => (others => '1'), -- not used in this design
    all_t0_i  => (others => '0'), -- not used in this design
    all_t1_i  => (others => '0'), -- not used in this design
    all_rxd_i => (others => '0'), -- not used in this design
    all_rxd_o => open,            -- not used in this design
    all_txd_o => open,            -- not used in this design  
    clk       => s_mc8051_clock,
    p0_i      => (others => '0'), -- not used in this design
    p1_i      => (others => '0'), -- not used in this design
    p2_i      => (others => '0'), -- not used in this design
    p3_i      => s_p3_i,          --
    p0_o      => s_p0_o,          --
    p1_o      => s_p1_o,          --
    p2_o      => s_p2_o,          --
    p3_o      => open,            --
    test_o    => open             -- not used in this design
    );

  --generates the 25MHz clock for the MC8051 MCU
  p_mc8051_clock: process (clk_i, reset_i)
  variable counter : integer := 0;
  begin
    if reset_i = '1' then --asynchronous reset (active high)
      s_mc8051_clock <= '0';
      counter := 0;
    elsif clk_i'event and clk_i = '1' then --rising clock edge
      counter := counter + 1;
      if counter = C_CLKCOUNTVAL then
        s_mc8051_clock <= not s_mc8051_clock;
        counter := 0;
      end if;
    end if;
  end process p_mc8051_clock;
  
  --handles push button inputs for the MC8051 MCU
  p_pb_handler: process(clk_i, reset_i)
  begin
    if reset_i = '1' then --asynchronous reset (active high)
      s_mc8051_int0 <= (others => '1');
    elsif clk_i'event and clk_i = '1' then --rising clock edge
      if pb_i /= "0000" then
        s_mc8051_int0 <= (others => '0'); --interrupt @ falling edge
        s_p3_i(7 downto 4) <= "0000";
        s_p3_i(3 downto 0) <= pb_i; --INPUT
      else
        s_mc8051_int0 <= (others => '1');
      end if;
    end if;
  end process p_pb_handler;

  --generates a slow signal for the animation of the moveable object
  p_anim: process (clk_i, reset_i)
  begin
    if reset_i = '1' then --asynchronous reset (active high)
      s_anim <= '0';
      counter <= 0;
    elsif clk_i'event and clk_i = '1' then --rising clock edge
      counter <= counter + 1;
      if counter >= C_ANIMCOUNTVAL then
        s_anim <= not s_anim;
        counter <= 0;
      end if;
    end if;
  end process p_anim;

  --main multiplexing process, handles the rgb output
  p_mux: process (clk_i, reset_i)

  variable screen :  integer := 0;

  begin
    if reset_i = '1' then --asynchronous reset (active high)
      s_rgb_o <= (others => '0');
    elsif clk_i'event and clk_i = '1' then --rising clock edge
      if pixel_en_i = '1' then

        --BACKGROUND PATTERN START
        case sw_i(1 downto 0) is
          when "00" =>
            s_rgb_o <= pat1_rgb_i;
          when "10" =>
            s_rgb_o <= pat2_rgb_i;
          when others =>  --"01" or "11"
            s_rgb_o <= mem1_rgb_i;
        end case;
        --BACKGROUND PATTERN END

        --MOVABLE OBJECT START
        case sw_i(2) is
          when '1' =>

            case sw_i(5) is

              --MOVEABLE OBJECT IMPLEMENTED IN VHDL
              when '0' | '1' =>
                if (pixel_x_i >= (s_mem23_loc_x + DELAY)) and (pixel_x_i < (s_mem23_loc_x + mem23_width + DELAY)) then
                  if (pixel_y_i >= s_mem23_loc_y) and (pixel_y_i < (s_mem23_loc_y + mem23_height)) then

                    --STATIC IMAGE / ANIMATION SELECTION START
                    case sw_i(4) is

                      --STATIC IMAGE
                      when '0' =>
                        s_rgb_o <= mem2_rgb_i;

                        --TRANSPARENCY
                        if mem2_rgb_i = MEM_BLACK and sw_i(3) = '1' then
                          case sw_i(1 downto 0) is
                            when "00" =>
                              s_rgb_o <= mem2_rgb_i or pat1_rgb_i;
                            when "10" =>
                              s_rgb_o <= mem2_rgb_i or pat2_rgb_i;
                            when others =>  --"01" or "11"
                              s_rgb_o <= mem2_rgb_i or mem1_rgb_i;
                          end case;
                        end if;
                      
                      --ANIMATION
                      when others => --'1'
                        case s_anim is

                          --MEM2
                          when '0' =>
                            s_rgb_o <= mem2_rgb_i;

                            --TRANSPARENCY
                            if mem2_rgb_i = MEM_BLACK  and sw_i(3) = '1' then
                              case sw_i(1 downto 0) is
                                when "00" =>
                                  s_rgb_o <= mem2_rgb_i or pat1_rgb_i;
                                when "10" =>
                                  s_rgb_o <= mem2_rgb_i or pat2_rgb_i;
                                when others =>  --"01" or "11"
                                  s_rgb_o <= mem2_rgb_i or mem1_rgb_i;
                              end case;
                            end if;

                          --MEM3
                          when others => --'1'
                            s_rgb_o <= mem3_rgb_i;

                            --TRANSPARENCY
                            if mem3_rgb_i = MEM_BLACK and sw_i(3) = '1' then
                              case sw_i(1 downto 0) is
                                when "00" =>
                                  s_rgb_o <= mem3_rgb_i or pat1_rgb_i;
                                when "10" =>
                                  s_rgb_o <= mem3_rgb_i or pat2_rgb_i;
                                when others =>  --"01" or "11"
                                  s_rgb_o <= mem3_rgb_i or mem1_rgb_i;
                              end case;
                            end if;

                        end case;

                    end case;
                    --STATIC IMAGE / ANIMATION SELECTION END
    
                  end if;
                end if;

              --MOVEABLE OBJECT IMPLEMENTED IN MCP8051
              when others => --'1'
                --MCP8051 CODE HERE
            end case;
            --MCP8051 OR VHDL SELECTION END
           
          when others => --sw_i(2) = '0'
            --nothing
        end case;
        --MOVABLE OBJECT END

      end if;
    end if;
  end process p_mux;

  --computes the correct pixel x and y coordinates for the memory controller of the moving 100x100 image
  p_overlay: process(clk_i, reset_i)
  begin
    if reset_i = '1' then
      s_mem23_pixel_x <= (others => '0');
      s_mem23_pixel_y <= (others => '0');
      s_mem23_pixel_valid <= '0';
    elsif clk_i'event and clk_i = '1' then --rising clock edge
      -- if pixel_en_i = '1' then --OLD
        case sw_i(2) is 
          when '1' =>

            if (pixel_x_i >= (s_mem23_loc_x)) and (pixel_x_i < (s_mem23_loc_x + mem23_width)) then
              if (pixel_y_i >= s_mem23_loc_y) and (pixel_y_i < (s_mem23_loc_y + mem23_height)) then
                s_mem23_pixel_valid <= '1';
                s_mem23_pixel_x <= pixel_x_i - (s_mem23_loc_x - 1);
                s_mem23_pixel_y <= pixel_y_i - (s_mem23_loc_y - 1);
              else
                s_mem23_pixel_valid <= '0';
              end if;
            else
              s_mem23_pixel_valid <= '0';
            end if;

          when others => --sw_i(2) = '0'
            --nothing
        end case;

      -- end if;
    end if;
  end process p_overlay;

  --computes the location of the moving 100x100 image
  p_move: process(clk_i, reset_i)
  begin
    if reset_i = '1' then
      s_mem23_loc_x <= mem23_min_x;
      s_mem23_loc_y <= (others => '0');
    elsif clk_i'event and clk_i = '1' then --rising clock edge

      --MCP8051 OR VHDL SELECTION START
      case sw_i(5) is

        --MOVEABLE OBJECT IMPLEMENTED IN VHDL
        when '0' =>
          case pb_i is
            when LEFT =>
              if s_mem23_loc_x <= MOVE then
                s_mem23_loc_x <= mem23_min_x;
              else
                s_mem23_loc_x <= (s_mem23_loc_x - MOVE);
              end if;
            when UP =>
              if s_mem23_loc_y <= MOVE then
                s_mem23_loc_y <= mem23_min_y;
              else
                s_mem23_loc_y <= (s_mem23_loc_y - MOVE);
              end if;
            when DOWN =>
              if s_mem23_loc_y >= (mem23_max_y - MOVE) then
                s_mem23_loc_y <= mem23_max_y;
              else
                s_mem23_loc_y <= (s_mem23_loc_y + MOVE);
              end if;
            when RIGHT =>
              if s_mem23_loc_x >= (mem23_max_x - MOVE) then
                s_mem23_loc_x <= mem23_max_x;
              else
                s_mem23_loc_x <= (s_mem23_loc_x + MOVE);
              end if;
            when others =>
              s_mem23_loc_x <= s_mem23_loc_x;
              s_mem23_loc_y <= s_mem23_loc_y;
          end case;

        --MOVEABLE OBJECT IMPLEMENTED IN MC8051
        when others => --'1'
          s_mem23_loc_x(9 downto 8) <= unsigned(s_p0_o(1 downto 0));
          s_mem23_loc_x(7 downto 0) <= unsigned(s_p1_o);
          
          s_mem23_loc_y(9 downto 8) <= unsigned(s_p0_o(7 downto 6));
          s_mem23_loc_y(7 downto 0) <= unsigned(s_p2_o);
      end case;
      
    end if;
  end process p_move;

  mem2_pixel_x_o <= s_mem23_pixel_x(6 downto 0);
  mem2_pixel_y_o <= s_mem23_pixel_y(6 downto 0);
  mem2_pixel_valid_o <= s_mem23_pixel_valid;

  mem3_pixel_x_o <= s_mem23_pixel_x(6 downto 0);
  mem3_pixel_y_o <= s_mem23_pixel_y(6 downto 0);
  mem3_pixel_valid_o <= s_mem23_pixel_valid;
  -- mem3_pixel_valid_o <= s_mc8051_clock;

  rgb_o <= s_rgb_o;

end rtl;