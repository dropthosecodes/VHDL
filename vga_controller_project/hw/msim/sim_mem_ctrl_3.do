vsim -novopt -t ps -L unisims_ver -lib work work.tb_mem_ctrl_3 work.glbl
view *
do wave_mem_ctrl_3.do
run 800 us