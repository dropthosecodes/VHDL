vsim -t ns -novopt -lib work work.tb_vectorgates
view *
do vectorgates_wave.do
run 1000 ns