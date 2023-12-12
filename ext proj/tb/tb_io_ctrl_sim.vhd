library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity tb_io_ctrl_sim is end tb_io_ctrl_sim;
architecture sim of tb_io_ctrl_sim is
 
 -- Declaration of the component under test
  component io_ctrl
  
 port (clk_i : in std_logic; -- 100 MHz system clock
 reset_i : in std_logic; -- asynchronous reset
 dig0_i : in std_logic_vector(7 downto 0); -- --Digit 0, which is the most right digit of 7 segment Display and contains like the others 3 digits eight digital signals.  
 dig1_i : in std_logic_vector(7 downto 0); --Digit 1, which is the most second right digit of 7 segment Display.
 dig2_i : in std_logic_vector(7 downto 0); --Digit 2. 
 dig3_i : in std_logic_vector(7 downto 0); --Digit 3.
 led_i : in std_logic_vector(15 downto 0); --the states of the 16 LEDs in the FPGA. 
 sw_i : in std_logic_vector(15 downto 0); --the states of 16 switches in the FPGA.
 pb_i : in std_logic_vector(3 downto 0); --the states of 4 push buttons in the FPGA (BTNR, BTND, BTNC,BTNL). BTNU is the reset global button and will not be declared in this entity.
 ss_o : out std_logic_vector(7 downto 0); --the 8 states of the LEDS (eight digital signals) in the 7-segment display in the FPGA.
 ss_sel_o : out std_logic_vector(3 downto 0); --Selection of a 7-segment digit on the FPGA board
 led_o : out std_logic_vector(15 downto 0); --Connected to 16 LEDs of the FPGA board
 swsync_o: out std_logic_vector(15 downto 0);--State of 16 debounced switches in the FPGA.
 pbsync_o : out std_logic_vector(3 downto 0) --State of 4 debounced push buttons in the FPGA.
 );
  end component;


 
signal clk_i : std_logic; 
signal  reset_i :std_logic; 
signal  dig0_i : std_logic_vector(7 downto 0);
signal  dig1_i : std_logic_vector(7 downto 0); 
signal  dig2_i : std_logic_vector(7 downto 0); 
signal  dig3_i : std_logic_vector(7 downto 0); 
signal  led_i :  std_logic_vector(15 downto 0); 
signal  sw_i :   std_logic_vector(15 downto 0); 
signal  pb_i :   std_logic_vector(3 downto 0); 
signal  ss_o :   std_logic_vector(7 downto 0); 
signal  ss_sel_o:std_logic_vector(3 downto 0); 
signal  led_o :  std_logic_vector(15 downto 0); 
signal  swsync_o:std_logic_vector(15 downto 0); 
signal  pbsync_o:std_logic_vector(3 downto 0); 



begin

-- Instantiate the design under test
  i_io_ctrl : io_ctrl
  
   port map (clk_i => clk_i,
             reset_i => reset_i,
             dig0_i   =>  dig0_i,
			 dig1_i   =>  dig1_i,
		     dig2_i   =>  dig2_i,
		     dig3_i   =>  dig3_i,
             led_i   => led_i,
		     sw_i   =>  sw_i,
		     pb_i   =>  pb_i,
	         ss_o   =>   ss_o,
		     ss_sel_o   =>  ss_sel_o,
             led_o   => led_o,
		     swsync_o   =>  swsync_o,
             pbsync_o   => pbsync_o);
	
	  --generate clock
  p_clk_i : process
   begin
    clk_i <= '0';
    wait for 5 ns;
    clk_i <= '1';
    wait for 5 ns;
   end process p_clk_i;
	
 p_reset_i : process
   begin
    reset_i <= '1';
    wait for 2 ms;
    reset_i <= '0';
    wait;
   end process p_reset_i;
   
   
   p_digits_i : process
   begin 
   dig0_i <= "01010001";
   dig1_i <= "10010100";
   dig2_i <= "00110100";
   dig3_i <= "00111001";
   
	led_i <= (15 downto 12 =>'1', others => '0');
	 
	wait;
	end process p_digits_i;
	
	p_debounce : process
	begin
	
		sw_i <= x"0000";
		pb_i <= x"0";
	wait for 3 ms;
	sw_i <= x"1011";
	pb_i <= x"1";
	Wait for 3 ms;
		sw_i <= x"0000";
		pb_i <= x"0";

	wait;
	end process p_debounce;

end sim;