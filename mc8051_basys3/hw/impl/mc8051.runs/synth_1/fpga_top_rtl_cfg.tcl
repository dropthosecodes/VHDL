# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a35tcpg236-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir C:/Users/hafer/Desktop/VHDL/mc8051_basys3/hw/impl/mc8051.cache/wt [current_project]
set_property parent.project_path C:/Users/hafer/Desktop/VHDL/mc8051_basys3/hw/impl/mc8051.xpr [current_project]
set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
add_files C:/Users/hafer/Desktop/VHDL/mc8051_basys3/sw/blink_led/build/mc8051_rom.coe
add_files -quiet C:/Users/hafer/Desktop/VHDL/mc8051_basys3/hw/generate/artix7_xc7a35tcpg263_1/mc8051_rom/mc8051_rom/mc8051_rom.dcp
set_property used_in_implementation false [get_files C:/Users/hafer/Desktop/VHDL/mc8051_basys3/hw/generate/artix7_xc7a35tcpg263_1/mc8051_rom/mc8051_rom/mc8051_rom.dcp]
add_files -quiet C:/Users/hafer/Desktop/VHDL/mc8051_basys3/hw/generate/artix7_xc7a35tcpg263_1/prescaler/prescaler/prescaler.dcp
set_property used_in_implementation false [get_files C:/Users/hafer/Desktop/VHDL/mc8051_basys3/hw/generate/artix7_xc7a35tcpg263_1/prescaler/prescaler/prescaler.dcp]
add_files -quiet C:/Users/hafer/Desktop/VHDL/mc8051_basys3/hw/generate/artix7_xc7a35tcpg263_1/mc8051_ram/mc8051_ram/mc8051_ram.dcp
set_property used_in_implementation false [get_files C:/Users/hafer/Desktop/VHDL/mc8051_basys3/hw/generate/artix7_xc7a35tcpg263_1/mc8051_ram/mc8051_ram/mc8051_ram.dcp]
read_vhdl -library xil_defaultlib {
  C:/Users/hafer/Desktop/VHDL/mc8051_basys3/hw/hdl/mc8051/addsub_ovcy_.vhd
  C:/Users/hafer/Desktop/VHDL/mc8051_basys3/hw/hdl/mc8051/mc8051_p.vhd
  C:/Users/hafer/Desktop/VHDL/mc8051_basys3/hw/hdl/mc8051/addsub_cy_.vhd
  C:/Users/hafer/Desktop/VHDL/mc8051_basys3/hw/hdl/mc8051/comb_mltplr_.vhd
  C:/Users/hafer/Desktop/VHDL/mc8051_basys3/hw/hdl/mc8051/addsub_ovcy_rtl.vhd
  C:/Users/hafer/Desktop/VHDL/mc8051_basys3/hw/hdl/mc8051/addsub_cy_rtl.vhd
  C:/Users/hafer/Desktop/VHDL/mc8051_basys3/hw/hdl/mc8051/alumux_.vhd
  C:/Users/hafer/Desktop/VHDL/mc8051_basys3/hw/hdl/mc8051/alucore_.vhd
  C:/Users/hafer/Desktop/VHDL/mc8051_basys3/hw/hdl/mc8051/comb_divider_.vhd
  C:/Users/hafer/Desktop/VHDL/mc8051_basys3/hw/hdl/mc8051/control_fsm_.vhd
  C:/Users/hafer/Desktop/VHDL/mc8051_basys3/hw/hdl/mc8051/dcml_adjust_.vhd
  C:/Users/hafer/Desktop/VHDL/mc8051_basys3/hw/hdl/mc8051/addsub_core_.vhd
  C:/Users/hafer/Desktop/VHDL/mc8051_basys3/hw/hdl/mc8051/control_mem_.vhd
  C:/Users/hafer/Desktop/VHDL/mc8051_basys3/hw/hdl/mc8051/dcml_adjust_rtl.vhd
  C:/Users/hafer/Desktop/VHDL/mc8051_basys3/hw/hdl/mc8051/mc8051_alu_.vhd
  C:/Users/hafer/Desktop/VHDL/mc8051_basys3/hw/hdl/mc8051/mc8051_control_.vhd
  C:/Users/hafer/Desktop/VHDL/mc8051_basys3/hw/hdl/mc8051/alumux_rtl.vhd
  C:/Users/hafer/Desktop/VHDL/mc8051_basys3/hw/hdl/mc8051/alucore_rtl.vhd
  C:/Users/hafer/Desktop/VHDL/mc8051_basys3/hw/hdl/mc8051/mc8051_tmrctr_.vhd
  C:/Users/hafer/Desktop/VHDL/mc8051_basys3/hw/hdl/mc8051/control_fsm_rtl.vhd
  C:/Users/hafer/Desktop/VHDL/mc8051_basys3/hw/hdl/mc8051/addsub_core_struc.vhd
  C:/Users/hafer/Desktop/VHDL/mc8051_basys3/hw/hdl/mc8051/mc8051_siu_.vhd
  C:/Users/hafer/Desktop/VHDL/mc8051_basys3/hw/hdl/mc8051/control_mem_rtl.vhd
  C:/Users/hafer/Desktop/VHDL/mc8051_basys3/hw/hdl/mc8051/comb_mltplr_rtl.vhd
  C:/Users/hafer/Desktop/VHDL/mc8051_basys3/hw/hdl/mc8051/comb_divider_rtl.vhd
  C:/Users/hafer/Desktop/VHDL/mc8051_basys3/hw/hdl/mc8051/mc8051_alu_struc.vhd
  C:/Users/hafer/Desktop/VHDL/mc8051_basys3/hw/hdl/mc8051/mc8051_tmrctr_rtl.vhd
  C:/Users/hafer/Desktop/VHDL/mc8051_basys3/hw/hdl/mc8051/mc8051_siu_rtl.vhd
  C:/Users/hafer/Desktop/VHDL/mc8051_basys3/hw/hdl/mc8051/mc8051_core_.vhd
  C:/Users/hafer/Desktop/VHDL/mc8051_basys3/hw/hdl/mc8051/mc8051_control_struc.vhd
  C:/Users/hafer/Desktop/VHDL/mc8051_basys3/hw/hdl/mc8051/mc8051_core_struc.vhd
  C:/Users/hafer/Desktop/VHDL/mc8051_basys3/hw/hdl/mc8051/mc8051_top_.vhd
  C:/Users/hafer/Desktop/VHDL/mc8051_basys3/hw/hdl/fpga_top_.vhd
  C:/Users/hafer/Desktop/VHDL/mc8051_basys3/hw/hdl/mc8051/mc8051_top_struc.vhd
  C:/Users/hafer/Desktop/VHDL/mc8051_basys3/hw/hdl/fpga_top_rtl.vhd
  C:/Users/hafer/Desktop/VHDL/mc8051_basys3/hw/hdl/fpga_top_rtl_cfg.vhd
}
foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc C:/Users/hafer/Desktop/VHDL/mc8051_basys3/hw/impl/mc8051.constrs/mc8051.xdc
set_property used_in_implementation false [get_files C:/Users/hafer/Desktop/VHDL/mc8051_basys3/hw/impl/mc8051.constrs/mc8051.xdc]


synth_design -top fpga_top_rtl_cfg -part xc7a35tcpg236-1


write_checkpoint -force -noxdef fpga_top_rtl_cfg.dcp

catch { report_utilization -file fpga_top_rtl_cfg_utilization_synth.rpt -pb fpga_top_rtl_cfg_utilization_synth.pb }