-------------------------------------------------------------------------------

-- --
-- F A C H H O C H S C H U L E - T E C H N I K U M W I E N --
-- --
-- Embedded Systems Department --
-- --
-------------------------------------------------------------------------------
--
-- Author: Ali Mousa
--
-- Filename: io_ctrl.vhd
--
-- Date of Creation:  26.05.2022
--
-- Version: $Revision$
--
-- Date of Latest Version: $Date$
--
-- Design Unit: IO Control Unit (Entity)
--
-- Description: The IO Control unit is part of the calculator project.
-- It manages the interface to the 7-segment displays,
-- the LEDs, the push buttons and the switches of the
-- Digilent Basys3 FPGA board.
--
-------------------------------------------------------------------------------
--
-- CVS Change Log
--
-- $Log$
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
entity io_ctrl is

 port (clk_i : in std_logic; -- the FPGA will run with 100 MHz system clock,
 reset_i : in std_logic; -- asynchronous reset, which is the button BTNU
 dig0_i : in std_logic_vector(7 downto 0); --Digit 0, which is the most right digit of 7 segment Display and contains like the others 3 digits eight digital signals.  
 dig1_i : in std_logic_vector(7 downto 0); --Digit 1, which is the most second right digit of 7 segment Display.
 dig2_i : in std_logic_vector(7 downto 0); --Digit 2. 
 dig3_i : in std_logic_vector(7 downto 0); --Digit 3.
 led_i : in std_logic_vector(15 downto 0); --the states of the 16 LEDs in the FPGA. 
 sw_i : in std_logic_vector(15 downto 0); --the states of 16 switches in the FPGA.
 pb_i : in std_logic_vector(3 downto 0); --the states of 4 push buttons in the FPGA (BTNR, BTND, BTNC,BTNL). BTNU is the reset global button and will not be declared in this entity.
 ss_o : out std_logic_vector(7 downto 0); -- the 8 states of the LEDS (eight digital signals) in the 7-segment display in the FPGA.
 ss_sel_o : out std_logic_vector(3 downto 0); --the 4 digit in the 7-segment Display in the FPGA. 1110 will be the most right digit
 led_o : out std_logic_vector(15 downto 0); --Connected to 16 LEDs in the FPGA.
 swsync_o: out std_logic_vector(15 downto 0); --State of 16 debounced switches in the FPGA.
 pbsync_o : out std_logic_vector(3 downto 0) --State of 4 debounced push buttons in the FPGA.
 );
end io_ctrl;


-- here the dig0_i to dig3_i will be conntected sepeartly to ss_0
-- and the buttons and the result will be connected to the ss_sel_o.
-- sw_i will be connected to swsync_o.
-- pb_i will be connected to pbsync_o.


-- the sw_i(11 downto 0) and the led_i(11 downto 0) will be conented to the operand 1 and operand 2. 