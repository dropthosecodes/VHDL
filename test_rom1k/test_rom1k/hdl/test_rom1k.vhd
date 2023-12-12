-- Test design for 1k ROM
-- FPGA device/board: Xilinx Artix-7 on Digilent Basys3 board
-- Author: Peter Roessler
-- Date: 2017-02-02 

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned."+";

entity test_rom1k is
  port(
    s_clk_i      : in  std_logic; -- 100 MHz clock (coming from board's clock oscillator)
    s_rst_i      : in  std_logic; -- asynchonrous reset (push button BTNR) 
    s_inc_fast_i : in  std_logic; -- "increment fast" signal (push button BTNL)
    s_led_o      : out std_logic_vector(9 downto 0) -- 10 LEDs
    );
end test_rom1k;

architecture rtl of test_rom1k is

-- 1k ROM (generated via Xilinx Vivado IP Catalog/Block Memory Generator)
component rom1k is
  port(
    clka  : in  std_logic; -- ROM clock
    addra : in  std_logic_vector(9 downto 0); -- ROM address
    douta : out std_logic_vector(9 downto 0) -- ROM data outputs
    );
end component;

-- internal signals
signal s_1pps_cnt : std_logic_vector(25 downto 0); 
signal s_1pps : std_logic;
signal s_rom1k_addr : std_logic_vector(9 downto 0); 
signal s_rom1k_dout : std_logic_vector(9 downto 0); 

begin

  -- "1 pulse per second" counter
  -- (actually, not really exactly 1 second but 1.5 Hz ...)  
  p_1pps_cnt : process (s_clk_i, s_rst_i)
  begin
    if (s_rst_i='1') then
      s_1pps_cnt <= (others => '0');
    elsif (s_clk_i'event and s_clk_i='1') then
      s_1pps_cnt <= s_1pps_cnt + '1';
    end if;
  end process p_1pps_cnt;

  -- generate "1 pulse per second" signal 
  s_1pps <= '1' when (s_1pps_cnt = (s_1pps_cnt'range => '0')) else '0';

  -- ROM address counter, increments either every second or every
  -- clock cycle, depending on whether BTNL is pressed or not  
  p_rom1k_addr_cnt : process (s_clk_i, s_rst_i)
  begin
    if (s_rst_i='1') then
      s_rom1k_addr <= (others => '0');
    elsif (s_clk_i'event and s_clk_i='1') then
      if (s_1pps = '1' or s_inc_fast_i = '1') then
        s_rom1k_addr <= s_rom1k_addr + '1';
      end if;
    end if;
  end process p_rom1k_addr_cnt;

  -- instantiate 1k ROM
  i_rom1k : rom1k
    port map(
      clka  => s_clk_i,
      addra => s_rom1k_addr,
      douta => s_rom1k_dout
      );
  
  -- connect ROM data outputs to 10 LEDs  
  s_led_o <= s_rom1k_dout;
        
end rtl;
