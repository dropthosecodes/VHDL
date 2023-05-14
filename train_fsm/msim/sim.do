vsim -t ns -novopt -lib work work.tb_train_fsm
view *
do train_fsm_wave.do
run 43000 ms