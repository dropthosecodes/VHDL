# compile simulation model of generated PLL
vlog ../generate/clkgen/clkgen/clkgen_clk_wiz.v
vlog ../generate/clkgen/clkgen/clkgen.v

# compile Xilinx GLBL module (required for proper initialization
# of all generated  Xilinx macros during simulation)
vlog ../generate/glbl.v

# compile clock generator test design
vcom ../hdl/test_clkgen.vhd

# compile testbench
vcom ../tb/tb_test_clkgen.vhd
