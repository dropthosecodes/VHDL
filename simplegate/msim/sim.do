vsim -t ns -novopt -lib work work.tb_xorgate
view *
do xorgate_wave.do
run 1000 ns