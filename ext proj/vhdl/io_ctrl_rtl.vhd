-------------------------------------------------------------------------------
-- Description: The IO Control unit is part of the calculator project.
-- It manages the interface to the 7-segment displays,
-- the LEDs, the push buttons and the switches of the
-- Digilent Basys3 FPGA board.
--
-------------------------------------------------------------------------------
--
-- CVS Change Log:
--
-- $Log$
-------------------------------------------------------------------------------
-- Description: The IO Control unit is part of the calculator project.
-- It manages the interface to the 7-segment displays,
-- the LEDs, the push buttons and the switches of the
-- Digilent Basys3 FPGA board.
--
-------------------------------------------------------------------------------
--
-- CVS Change Log:
--
-- $Log$
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
architecture rtl of io_ctrl is

 constant io_prescaler : std_logic_vector(16 downto 0):= "11000011010100000"; --17bits ergibt 100k für den Counter
 signal s_enctr : std_logic_vector(16 downto 0);
 signal s_1khzen : std_logic;
 signal swsync : std_logic_vector(15 downto 0);
 signal pbsync : std_logic_vector(3 downto 0);
 signal s_ss_sel : std_logic_vector(3 downto 0);
 signal s_ss : std_logic_vector(7 downto 0);
 
 signal count: integer;
 type state_type_ss is (first_dig, second_dig, third_dig, fourth_dig);
 signal state_ss : state_type_ss;
 type state_type_db is (idle, pb_time_towait, sw_time_towait);
 signal state_db :state_type_db; 
 signal pb_val : std_logic_vector(3 downto 0);
 signal sw_val : std_logic_vector(15 downto 0);
 
  
 

begin -- rtl
 -----------------------------------------------------------------------------
 --
 -- Generate 1 kHz enable signal.
 --
 -----------------------------------------------------------------------------
 p_slowen: process (clk_i, reset_i)
	begin
		if reset_i = '1' then -- asynchronous reset (active high)
			s_1khzen <='0';
			s_enctr <= "0" & x"0000"; --Mit der x sind die Zahlen hexazahlen und diese sind dann pro Zahl 4 Stellen //lieber vereinfachen
		elsif clk_i'event and clk_i = '1' then -- rising clock edge
						-- Enable signal is inactive per default.
			if(s_enctr = io_prescaler) then 
				s_1khzen <= '1';
				s_enctr <= "0" & x"0000";
			else 
				s_1khzen <= '0';
				s_enctr <= unsigned(s_enctr) + unsigned'(x"0001"); -- As long as the terminal count is not reached: increment the counter.
			end if;
		end if ;
	end process p_slowen;
 -----------------------------------------------------------------------------
 --
 -- Debounce buttons and switches
 --
 -----------------------------------------------------------------------------
 p_debounce: process (clk_i, reset_i)
 begin
 if reset_i = '1' then -- asynchronous reset (active high)
 state_db <= idle;
 pb_val <= x"0";
 sw_val <= x"0000";
 pbsync <= x"0";
 swsync <= x"0000";
 count <= 0;
 
	elsif clk_i'event and clk_i = '1' then -- rising clock edge
		if s_1khzen = '1' then
			case (state_db) is
				when idle =>
					if (pb_i /= pb_val) then
						pb_val <= pb_i;
						state_db <= pb_time_towait;
					elsif(sw_i /= sw_val) then --sw_i has change its vlue,so it has been pushed.
						sw_val <= sw_i;
						state_db <= sw_time_towait;
					else 
						state_db <= idle;
						count <= 0;
					end if;
					when pb_time_towait =>
						if (count = 20) then --the push debounce is 20 ms.
							count <= 0;
							if (pb_i = pb_val) then
						    pbsync <= pb_val;
							end if;
							state_db <= idle;
						else 
						count <= count +1;
					end if;
					when sw_time_towait =>
						if (count = 20) then
							count <= 0;
							if (sw_i = sw_val) then
							swsync <= sw_val;
							end if;
							state_db <= idle;
						else 
						count <= count+1;
					end if;
			end case;
		end if;
	end if;					
 end process p_debounce;
 swsync_o <= swsync;
 pbsync_o <= pbsync;
 -----------------------------------------------------------------------------
 --
 -- Display controller for the 7-segment display
 --
 -----------------------------------------------------------------------------
 p_display_ctrl: process (clk_i, reset_i)
 begin
	if reset_i = '1' then -- asynchronous reset (active high)
		s_ss <= "11111111"; -- the signals in the digit is turn off.
		s_ss_sel <= "1111"; -- the 4 digit in the 7-segment is turn off.
		state_ss <= first_dig;
		elsif clk_i'event and clk_i = '1' then 
			if (s_1khzen = '1') then
				case(state_ss) is
					when(first_dig) => -- to make the 7-segment being selected in circular fashion.
					s_ss <= dig0_i;
					s_ss_sel <= "1110";
					state_ss <= second_dig;
					when(second_dig) => 
					s_ss <= dig1_i;
					s_ss_sel <= "1101";
					state_ss <= third_dig;
					when(third_dig) => 
					s_ss <= dig2_i;
					s_ss_sel <= "1011";
					state_ss <= fourth_dig;
					when(fourth_dig) => 
					s_ss <= dig3_i;
					s_ss_sel <= "0111";
					state_ss <= first_dig;
				end case;
		end if;
	end if;
end process p_display_ctrl;
 ss_o <= s_ss;
 ss_sel_o <= s_ss_sel;
 -----------------------------------------------------------------------------
 --
 -- Handle the 16 LEDs
 --
 -----------------------------------------------------------------------------
 led_o <= led_i; -- simply connect the internal to the external signals
end rtl;

