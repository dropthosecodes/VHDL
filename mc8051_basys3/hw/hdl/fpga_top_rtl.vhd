-- MC8051 IP Core Demo Design, Top-level Architecture
-- FPGA device/board: Xilinx Artix-7 on Digilent Basys3 board
-- Author: Peter Roessler
-- Date: 2017-02-08

architecture rtl of fpga_top is
       
  signal s_p2_o : std_logic_vector(7 downto 0); -- 8-bit port P2 of mc8051

  signal s_locked : std_logic; -- becomes high when PLL is locked
  signal s_sync_locked : std_logic_vector(2 downto 0); -- sync shift register

  signal s_reset_8051 : std_logic; -- high-active reset for mc8051
  signal s_clk_8051 : std_logic; -- 25 MHz clock for mc8051
   
  begin

  -- Generates reset signal for the mc8051:
  -- Synchronizes signal "locked" from the PLL to the 25 MHz domain
  -- and deasserts mc8051 reset at the falling clock edge  
  p_reset_generator : process (reset, s_clk_8051)
  begin
    if reset = '1' then
      s_reset_8051 <= '1';
      s_sync_locked <= (others => '0');
    elsif s_clk_8051'event and s_clk_8051='0' then
      s_sync_locked(0) <= s_locked;
      s_sync_locked(1) <= s_sync_locked(0);
      s_sync_locked(2) <= s_sync_locked(1);
        
      if (s_sync_locked(1)='1') and (s_sync_locked(2)='0') then
        s_reset_8051 <= '0';
      end if;
    end if;  
  end process p_reset_generator;

  -- PLL which generates clock for mc8051:
  i_prescaler : prescaler
    port map (
      clk_in1  => clk,        -- PLL clock input, 100 MHz
      clk_out1 => s_clk_8051, -- PLL clock output, 25 MHz
      reset    => reset,      -- PLL high-active reset input 
      locked   => s_locked    -- use "PLL locked" signal as reset signal for remaining logic
      );
   
  -- instantiation of the mc8051 IP core:
  i_mc8051_top : mc8051_top
    port map (
      reset     => s_reset_8051,
      int0_i    => (others => '1'), -- not used in this design
      int1_i    => (others => '1'), -- not used in this design
      all_t0_i  => (others => '0'), -- not used in this design
      all_t1_i  => (others => '0'), -- not used in this design
      all_rxd_i => (others => '0'), -- not used in this design
      all_rxd_o => open,            -- not used in this design
      all_txd_o => open,            -- not used in this design  
      clk       => s_clk_8051,
      p0_i      => (others => '0'), -- not used in this design
      p1_i      => (others => '0'), -- not used in this design
      p2_i      => (others => '0'), -- not used in this design
      p3_i      => (others => '0'), -- not used in this design
      p0_o      => open,            -- not used in this design
      p1_o      => open,            -- not used in this design
      p2_o      => s_p2_o,
      p3_o      => open,            -- not used in this design
      test_o    => open             -- not used in this design
      );

  -- Only LED0 is used in this design:
  -- led_o(0) <= s_p2_o(0);
  -- led_o(7 downto 1) <= (others => '0');

  led_o(7 downto 0) <= s_p2_o(7 downto 0);
  
end rtl;