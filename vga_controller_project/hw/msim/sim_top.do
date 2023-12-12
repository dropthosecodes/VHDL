vsim -t ns -novopt -lib work work.tb_top
view *
do wave_top.do
run 50 ms