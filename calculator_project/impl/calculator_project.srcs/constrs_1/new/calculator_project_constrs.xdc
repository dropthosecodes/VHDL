set_property PACKAGE_PIN L1 [get_ports {led_o[15]}]
set_property PACKAGE_PIN P1 [get_ports {led_o[14]}]
set_property PACKAGE_PIN N3 [get_ports {led_o[13]}]
set_property PACKAGE_PIN P3 [get_ports {led_o[12]}]
set_property PACKAGE_PIN U3 [get_ports {led_o[11]}]
set_property PACKAGE_PIN W3 [get_ports {led_o[10]}]
set_property PACKAGE_PIN V3 [get_ports {led_o[9]}]
set_property PACKAGE_PIN V13 [get_ports {led_o[8]}]
set_property PACKAGE_PIN V14 [get_ports {led_o[7]}]
set_property PACKAGE_PIN U14 [get_ports {led_o[6]}]
set_property PACKAGE_PIN U15 [get_ports {led_o[5]}]
set_property PACKAGE_PIN W18 [get_ports {led_o[4]}]
set_property PACKAGE_PIN V19 [get_ports {led_o[3]}]
set_property PACKAGE_PIN U19 [get_ports {led_o[2]}]
set_property PACKAGE_PIN E19 [get_ports {led_o[1]}]
set_property PACKAGE_PIN U16 [get_ports {led_o[0]}]
set_property PACKAGE_PIN W19 [get_ports {pb_i[3]}]
set_property PACKAGE_PIN U18 [get_ports {pb_i[2]}]
set_property PACKAGE_PIN T17 [get_ports {pb_i[1]}]
set_property PACKAGE_PIN U17 [get_ports {pb_i[0]}]
set_property PACKAGE_PIN R2 [get_ports {sw_i[15]}]
set_property PACKAGE_PIN T1 [get_ports {sw_i[14]}]
set_property PACKAGE_PIN U1 [get_ports {sw_i[13]}]
set_property PACKAGE_PIN W2 [get_ports {sw_i[12]}]
set_property PACKAGE_PIN R3 [get_ports {sw_i[11]}]
set_property PACKAGE_PIN T2 [get_ports {sw_i[10]}]
set_property PACKAGE_PIN T3 [get_ports {sw_i[9]}]
set_property PACKAGE_PIN V2 [get_ports {sw_i[8]}]
set_property PACKAGE_PIN W13 [get_ports {sw_i[7]}]
set_property PACKAGE_PIN W14 [get_ports {sw_i[6]}]
set_property PACKAGE_PIN V15 [get_ports {sw_i[5]}]
set_property PACKAGE_PIN W15 [get_ports {sw_i[4]}]
set_property PACKAGE_PIN W17 [get_ports {sw_i[3]}]
set_property PACKAGE_PIN W16 [get_ports {sw_i[2]}]
set_property PACKAGE_PIN V16 [get_ports {sw_i[1]}]
set_property PACKAGE_PIN V17 [get_ports {sw_i[0]}]
set_property PACKAGE_PIN W4 [get_ports {ss_sel_o[3]}]
set_property PACKAGE_PIN V4 [get_ports {ss_sel_o[2]}]
set_property PACKAGE_PIN U4 [get_ports {ss_sel_o[1]}]
set_property PACKAGE_PIN U2 [get_ports {ss_sel_o[0]}]
set_property PACKAGE_PIN W7 [get_ports {ss_o[7]}]
set_property PACKAGE_PIN W6 [get_ports {ss_o[6]}]
set_property PACKAGE_PIN U8 [get_ports {ss_o[5]}]
set_property PACKAGE_PIN V8 [get_ports {ss_o[4]}]
set_property PACKAGE_PIN U5 [get_ports {ss_o[3]}]
set_property PACKAGE_PIN V5 [get_ports {ss_o[2]}]
set_property PACKAGE_PIN U7 [get_ports {ss_o[1]}]
set_property PACKAGE_PIN V7 [get_ports {ss_o[0]}]
set_property PACKAGE_PIN W5 [get_ports clk_i]
create_clock -period 10.000 -name clk_i -waveform {0.000 5.000} [get_ports clk_i]
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]

set_property IOSTANDARD LVCMOS33 [get_ports {led_o[15]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_o[14]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_o[13]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_o[12]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_o[11]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_o[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_o[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_o[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_o[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_o[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_o[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_o[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_o[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_o[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_o[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_o[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {pb_i[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {pb_i[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {pb_i[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {pb_i[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ss_o[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ss_o[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ss_o[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ss_o[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ss_o[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ss_o[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ss_o[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ss_o[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ss_sel_o[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ss_sel_o[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ss_sel_o[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ss_sel_o[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw_i[15]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw_i[14]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw_i[13]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw_i[12]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw_i[11]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw_i[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw_i[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw_i[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw_i[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw_i[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw_i[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw_i[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw_i[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw_i[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw_i[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw_i[0]}]

set_property IOSTANDARD LVCMOS33 [get_ports clk_i]
set_property IOSTANDARD LVCMOS33 [get_ports reset_i]



set_property PACKAGE_PIN T18 [get_ports reset_i]
