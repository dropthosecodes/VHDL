vsim -novopt -t ps -L unisims_ver -lib work work.tb_mem_ctrl_1 work.glbl
view *
do wave_mem_ctrl_1.do
run 10 ms