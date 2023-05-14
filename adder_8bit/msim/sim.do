vsim -t ns -novopt -lib work work.tb_adder_8bit
view *
do adder_8bit_wave.do
run 500 ns