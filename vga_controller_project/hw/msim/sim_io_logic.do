vsim -t ns -novopt -lib work work.tb_io_logic
view *
do wave_io_logic.do
run 15 ms