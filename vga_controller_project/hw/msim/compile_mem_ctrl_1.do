vlog ../generate/rom1/rom1/blk_mem_gen_v8_3_2/simulation/blk_mem_gen_v8_3.v
vcom ../generate/rom1/rom1/synth/rom1.vhd

vlog ../generate/glbl.v

vcom ../vhdl/mem_ctrl_1/mem_ctrl_1_.vhd
vcom ../vhdl/mem_ctrl_1/mem_ctrl_1_rtl.vhd
vcom ../vhdl/mem_ctrl_1/mem_ctrl_1_rtl_cfg.vhd
vcom ../tb/tb_mem_ctrl_1_.vhd
vcom ../tb/tb_mem_ctrl_1_sim.vhd