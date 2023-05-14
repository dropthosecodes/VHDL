vsim -t ns -novopt -lib work work.tb_led_example
view *
do led_example_wave.do
run 150000 ms