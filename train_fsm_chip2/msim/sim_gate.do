vsim -t ns -novopt -lib work work.tb_gate_model
view *
do gate_model_wave.do
run 70000 ms