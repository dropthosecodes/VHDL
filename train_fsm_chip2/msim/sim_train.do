vsim -t ns -novopt -lib work work.tb_train_model
view *
do train_model_wave.do
run 40000 ms