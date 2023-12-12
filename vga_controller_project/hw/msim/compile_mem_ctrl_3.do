vlog ../generate/rom3/rom3/blk_mem_gen_v8_3_2/simulation/blk_mem_gen_v8_3.v
vcom ../generate/rom3/rom3/synth/rom3.vhd

vlog ../generate/glbl.v

vcom ../vhdl/mem_ctrl_3/mem_ctrl_3_.vhd
vcom ../vhdl/mem_ctrl_3/mem_ctrl_3_rtl.vhd
vcom ../vhdl/mem_ctrl_3/mem_ctrl_3_rtl_cfg.vhd
vcom ../tb/tb_mem_ctrl_3_.vhd
vcom ../tb/tb_mem_ctrl_3_sim.vhd