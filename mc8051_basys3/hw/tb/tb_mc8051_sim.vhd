-- MC8051 IP Core Demo Design, Top-level Testbench Architecture 
-- Author: Peter Roessler
-- Date: 2017-02-08

architecture sim of tb_mc8051 is

  component fpga_top is
    port(
      clk   : in  std_logic;
      reset : in  std_logic;
      led_o : out std_logic_vector(7 downto 0)
      );
  end component;

  signal clk : std_logic := '0'; -- clock signal coming from oscillator
  signal reset : std_logic := '0'; -- reset signal coming from reset button BTNC  
  signal led_o : std_logic_vector(7 downto 0); -- LEDs LED0 - LED7
  
begin

  clk   <= not clk after 5 ns; -- 100 MHz clock
  reset <= '1', '0' after 50 ns; -- generate reset after power-up

  i_fpga_top : fpga_top
    port map (
      clk   => clk,
      reset => reset,
      led_o => led_o
      );
    
end;
