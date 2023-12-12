vsim -novopt -t ns -L unisims_ver -lib work work.tb_test_rom1k work.glbl 
view *
do test_rom1k_wave.do
run 500 ns
