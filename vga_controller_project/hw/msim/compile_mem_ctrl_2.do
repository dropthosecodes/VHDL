vlog ../generate/rom2/rom2/blk_mem_gen_v8_3_2/simulation/blk_mem_gen_v8_3.v
vcom ../generate/rom2/rom2/synth/rom2.vhd

vlog ../generate/glbl.v

vcom ../vhdl/mem_ctrl_2/mem_ctrl_2_.vhd
vcom ../vhdl/mem_ctrl_2/mem_ctrl_2_rtl.vhd
vcom ../vhdl/mem_ctrl_2/mem_ctrl_2_rtl_cfg.vhd
vcom ../tb/tb_mem_ctrl_2_.vhd
vcom ../tb/tb_mem_ctrl_2_sim.vhd