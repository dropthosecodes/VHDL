vsim -novopt -t ps -L unisims_ver -lib work work.tb_test_clkgen work.glbl  
view *
do test_clkgen_wave.do
run 8000 ns
