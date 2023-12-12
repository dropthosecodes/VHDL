# copy .mif file (which holds content of 1k ROM) into ModelSim simulation directory
file copy -force ../generate/rom1k/rom1k/rom1k.mif ./

# compile simulation model of generated 1k ROM
vlog ../generate/rom1k/rom1k/blk_mem_gen_v8_3_2/simulation/blk_mem_gen_v8_3.v
vcom ../generate/rom1k/rom1k/synth/rom1k.vhd

# compile Xilinx GLBL module (required for proper initialization
# of all generated  Xilinx macros during simulation)
vlog ../generate/glbl.v

# compile test design for 1k ROM
vcom ../hdl/test_rom1k.vhd

# compile testbench
vcom ../tb/tb_test_rom1k.vhd


