# Constraints for clock generator test design
# FPGA device/board: Xilinx Artix-7 on Digilent Basys3 board
# Author: Peter Roessler
# Date: 2017-02-01 

# Note, that no clock frequency is defined in this file since this is defined
# in another XDC file that comes with the generated PLL used in this design 
set_property PACKAGE_PIN W5  [get_ports s_osc_i]
set_property PACKAGE_PIN T17 [get_ports s_btnr_i]
set_property PACKAGE_PIN U16 [get_ports s_led0_o]
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]
set_property IOSTANDARD LVCMOS33 [get_ports s_osc_i]
set_property IOSTANDARD LVCMOS33 [get_ports s_btnr_i]
set_property IOSTANDARD LVCMOS33 [get_ports s_led0_o]
