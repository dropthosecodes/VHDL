vsim -t ns -novopt -lib work work.tb_led_fsm
view *
do led_fsm_wave.do
run 2300 ns