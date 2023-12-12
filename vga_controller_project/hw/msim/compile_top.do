
vcom ../vhdl/io_logic/io_logic_.vhd
vcom ../vhdl/io_logic/io_logic_rtl.vhd
vcom ../vhdl/io_logic/io_logic_rtl_cfg.vhd

vlog ../generate/rom1/rom1/blk_mem_gen_v8_3_2/simulation/blk_mem_gen_v8_3.v
vcom ../generate/rom1/rom1/synth/rom1.vhd
vlog ../generate/glbl.v
vcom ../vhdl/mem_ctrl_1/mem_ctrl_1_.vhd
vcom ../vhdl/mem_ctrl_1/mem_ctrl_1_rtl.vhd
vcom ../vhdl/mem_ctrl_1/mem_ctrl_1_rtl_cfg.vhd

vlog ../generate/rom2/rom2/blk_mem_gen_v8_3_2/simulation/blk_mem_gen_v8_3.v
vcom ../generate/rom2/rom2/synth/rom2.vhd
vlog ../generate/glbl.v
vcom ../vhdl/mem_ctrl_2/mem_ctrl_2_.vhd
vcom ../vhdl/mem_ctrl_2/mem_ctrl_2_rtl.vhd
vcom ../vhdl/mem_ctrl_2/mem_ctrl_2_rtl_cfg.vhd

vlog ../generate/rom3/rom3/blk_mem_gen_v8_3_2/simulation/blk_mem_gen_v8_3.v
vcom ../generate/rom3/rom3/synth/rom3.vhd
vlog ../generate/glbl.v
vcom ../vhdl/mem_ctrl_3/mem_ctrl_3_.vhd
vcom ../vhdl/mem_ctrl_3/mem_ctrl_3_rtl.vhd
vcom ../vhdl/mem_ctrl_3/mem_ctrl_3_rtl_cfg.vhd

vcom ../vhdl/pattern_gen_1/pattern_gen_1_.vhd
vcom ../vhdl/pattern_gen_1/pattern_gen_1_rtl.vhd
vcom ../vhdl/pattern_gen_1/pattern_gen_1_rtl_cfg.vhd

vcom ../vhdl/pattern_gen_2/pattern_gen_2_.vhd
vcom ../vhdl/pattern_gen_2/pattern_gen_2_rtl.vhd
vcom ../vhdl/pattern_gen_2/pattern_gen_2_rtl_cfg.vhd

vcom ../vhdl/prescaler/prescaler_.vhd
vcom ../vhdl/prescaler/prescaler_rtl.vhd
vcom ../vhdl/prescaler/prescaler_rtl_cfg.vhd



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



vcom ../vhdl/vga_ctrl/vga_ctrl_.vhd
vcom ../vhdl/vga_ctrl/vga_ctrl_rtl.vhd
vcom ../vhdl/vga_ctrl/vga_ctrl_rtl_cfg.vhd

vcom ../tb/vga_monitor/vga_monitor_.vhd
vcom ../tb/vga_monitor/vga_monitor_sim.vhd

vcom ../vhdl/top_struc/vga_controller_top_.vhd
vcom ../vhdl/top_struc/vga_controller_top_struc.vhd
vcom ../vhdl/top_struc/vga_controller_top_struc_cfg.vhd

vcom ../tb/tb_top_.vhd
vcom ../tb/tb_top_sim.vhd