vsim -t ns -novopt -lib work work.tb_JK_FF
view *
do JK_FF_wave.do
run 1000 ns