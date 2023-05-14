vsim -t ns -novopt -lib work work.tb_D_FF
view *
do D_FF_wave.do
run 1000 ns