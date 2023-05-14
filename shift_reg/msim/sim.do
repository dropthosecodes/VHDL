vsim -t ns -novopt -lib work work.tb_shift_reg
view *
do shift_reg_wave.do
run 1000 ns