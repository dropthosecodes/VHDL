vcom ../generate/mc8051_rom/mc8051_rom/synth/mc8051_rom.vhd
vcom ../generate/mc8051_ram/mc8051_ram/synth/mc8051_ram.vhd

vlog ../generate/glbl.v

vcom ../vhdl/mc8051/mc8051_p.vhd
     
vcom ../vhdl/mc8051/control_mem_.vhd
vcom ../vhdl/mc8051/control_mem_rtl.vhd
vcom ../vhdl/mc8051/control_mem_rtl_cfg.vhd
     
vcom ../vhdl/mc8051/control_fsm_.vhd
vcom ../vhdl/mc8051/control_fsm_rtl.vhd
vcom ../vhdl/mc8051/control_fsm_rtl_cfg.vhd
     
vcom ../vhdl/mc8051/mc8051_control_.vhd
vcom ../vhdl/mc8051/mc8051_control_struc.vhd
vcom ../vhdl/mc8051/mc8051_control_struc_cfg.vhd
     
vcom ../vhdl/mc8051/alucore_.vhd
vcom ../vhdl/mc8051/alucore_rtl.vhd
vcom ../vhdl/mc8051/alucore_rtl_cfg.vhd
     
vcom ../vhdl/mc8051/alumux_.vhd
vcom ../vhdl/mc8051/alumux_rtl.vhd
vcom ../vhdl/mc8051/alumux_rtl_cfg.vhd
     
vcom ../vhdl/mc8051/addsub_cy_.vhd
vcom ../vhdl/mc8051/addsub_cy_rtl.vhd
vcom ../vhdl/mc8051/addsub_cy_rtl_cfg.vhd
     
vcom ../vhdl/mc8051/addsub_ovcy_.vhd
vcom ../vhdl/mc8051/addsub_ovcy_rtl.vhd
vcom ../vhdl/mc8051/addsub_ovcy_rtl_cfg.vhd
     
vcom ../vhdl/mc8051/addsub_core_.vhd
vcom ../vhdl/mc8051/addsub_core_struc.vhd
vcom ../vhdl/mc8051/addsub_core_struc_cfg.vhd
     
vcom ../vhdl/mc8051/comb_divider_.vhd
vcom ../vhdl/mc8051/comb_divider_rtl.vhd
vcom ../vhdl/mc8051/comb_divider_rtl_cfg.vhd
     
vcom ../vhdl/mc8051/comb_mltplr_.vhd
vcom ../vhdl/mc8051/comb_mltplr_rtl.vhd
vcom ../vhdl/mc8051/comb_mltplr_rtl_cfg.vhd
     
vcom ../vhdl/mc8051/dcml_adjust_.vhd
vcom ../vhdl/mc8051/dcml_adjust_rtl.vhd
vcom ../vhdl/mc8051/dcml_adjust_rtl_cfg.vhd
     
vcom ../vhdl/mc8051/mc8051_alu_.vhd
vcom ../vhdl/mc8051/mc8051_alu_struc.vhd
vcom ../vhdl/mc8051/mc8051_alu_struc_cfg.vhd
     
vcom ../vhdl/mc8051/mc8051_siu_.vhd
vcom ../vhdl/mc8051/mc8051_siu_rtl.vhd
vcom ../vhdl/mc8051/mc8051_siu_rtl_cfg.vhd
     
vcom ../vhdl/mc8051/mc8051_tmrctr_.vhd
vcom ../vhdl/mc8051/mc8051_tmrctr_rtl.vhd
vcom ../vhdl/mc8051/mc8051_tmrctr_rtl_cfg.vhd
     
vcom ../vhdl/mc8051/mc8051_core_.vhd
vcom ../vhdl/mc8051/mc8051_core_struc.vhd
vcom ../vhdl/mc8051/mc8051_core_struc_cfg.vhd
  
vcom ../vhdl/mc8051/mc8051_top_.vhd
vcom ../vhdl/mc8051/mc8051_top_struc.vhd
vcom ../vhdl/mc8051/mc8051_top_struc_cfg.vhd

vcom ../vhdl/src_mux/src_mux_.vhd
vcom ../vhdl/src_mux/src_mux_rtl.vhd
vcom ../vhdl/src_mux/src_mux_rtl_cfg.vhd
vcom ../tb/tb_src_mux_.vhd
vcom ../tb/tb_src_mux_sim.vhd