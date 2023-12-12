#################################################################
# compile simulation models of generated PLL, ROM and RAM
#################################################################
vlog ../../generate/artix7_xc7a35tcpg263_1/prescaler/prescaler/prescaler_clk_wiz.v
vlog ../../generate/artix7_xc7a35tcpg263_1/prescaler/prescaler/prescaler.v
vlog ../../generate/artix7_xc7a35tcpg263_1/mc8051_rom/mc8051_rom/blk_mem_gen_v8_3_2/simulation/blk_mem_gen_v8_3.v
vcom ../../generate/artix7_xc7a35tcpg263_1/mc8051_rom/mc8051_rom/synth/mc8051_rom.vhd
vcom ../../generate/artix7_xc7a35tcpg263_1/mc8051_ram/mc8051_ram/synth/mc8051_ram.vhd

#################################################################
# compile Xilinx GLBL module (required for proper initialization
# of all generated  Xilinx macros during simulation)
#################################################################
vlog ../../generate/glbl.v

#################################################################
# compile mc8051
#################################################################
vcom ../../hdl/mc8051/mc8051_p.vhd
     
vcom ../../hdl/mc8051/control_mem_.vhd
vcom ../../hdl/mc8051/control_mem_rtl.vhd
vcom ../../hdl/mc8051/control_mem_rtl_cfg.vhd
     
vcom ../../hdl/mc8051/control_fsm_.vhd
vcom ../../hdl/mc8051/control_fsm_rtl.vhd
vcom ../../hdl/mc8051/control_fsm_rtl_cfg.vhd
     
vcom ../../hdl/mc8051/mc8051_control_.vhd
vcom ../../hdl/mc8051/mc8051_control_struc.vhd
vcom ../../hdl/mc8051/mc8051_control_struc_cfg.vhd
     
vcom ../../hdl/mc8051/alucore_.vhd
vcom ../../hdl/mc8051/alucore_rtl.vhd
vcom ../../hdl/mc8051/alucore_rtl_cfg.vhd
     
vcom ../../hdl/mc8051/alumux_.vhd
vcom ../../hdl/mc8051/alumux_rtl.vhd
vcom ../../hdl/mc8051/alumux_rtl_cfg.vhd
     
vcom ../../hdl/mc8051/addsub_cy_.vhd
vcom ../../hdl/mc8051/addsub_cy_rtl.vhd
vcom ../../hdl/mc8051/addsub_cy_rtl_cfg.vhd
     
vcom ../../hdl/mc8051/addsub_ovcy_.vhd
vcom ../../hdl/mc8051/addsub_ovcy_rtl.vhd
vcom ../../hdl/mc8051/addsub_ovcy_rtl_cfg.vhd
     
vcom ../../hdl/mc8051/addsub_core_.vhd
vcom ../../hdl/mc8051/addsub_core_struc.vhd
vcom ../../hdl/mc8051/addsub_core_struc_cfg.vhd
     
vcom ../../hdl/mc8051/comb_divider_.vhd
vcom ../../hdl/mc8051/comb_divider_rtl.vhd
vcom ../../hdl/mc8051/comb_divider_rtl_cfg.vhd
     
vcom ../../hdl/mc8051/comb_mltplr_.vhd
vcom ../../hdl/mc8051/comb_mltplr_rtl.vhd
vcom ../../hdl/mc8051/comb_mltplr_rtl_cfg.vhd
     
vcom ../../hdl/mc8051/dcml_adjust_.vhd
vcom ../../hdl/mc8051/dcml_adjust_rtl.vhd
vcom ../../hdl/mc8051/dcml_adjust_rtl_cfg.vhd
     
vcom ../../hdl/mc8051/mc8051_alu_.vhd
vcom ../../hdl/mc8051/mc8051_alu_struc.vhd
vcom ../../hdl/mc8051/mc8051_alu_struc_cfg.vhd
     
vcom ../../hdl/mc8051/mc8051_siu_.vhd
vcom ../../hdl/mc8051/mc8051_siu_rtl.vhd
vcom ../../hdl/mc8051/mc8051_siu_rtl_cfg.vhd
     
vcom ../../hdl/mc8051/mc8051_tmrctr_.vhd
vcom ../../hdl/mc8051/mc8051_tmrctr_rtl.vhd
vcom ../../hdl/mc8051/mc8051_tmrctr_rtl_cfg.vhd
     
vcom ../../hdl/mc8051/mc8051_core_.vhd
vcom ../../hdl/mc8051/mc8051_core_struc.vhd
vcom ../../hdl/mc8051/mc8051_core_struc_cfg.vhd
  
vcom ../../hdl/mc8051/mc8051_top_.vhd
vcom ../../hdl/mc8051/mc8051_top_struc.vhd
vcom ../../hdl/mc8051/mc8051_top_struc_cfg.vhd

#################################################################
# compile FPGA top-level design
#################################################################
vcom ../../hdl/fpga_top_.vhd
vcom ../../hdl/fpga_top_rtl.vhd
vcom ../../hdl/fpga_top_rtl_cfg.vhd
     
#################################################################
# compile testbench
#################################################################
vcom ../../tb/tb_mc8051_.vhd
vcom ../../tb/tb_mc8051_sim.vhd
vcom ../../tb/tb_mc8051_sim_cfg.vhd
