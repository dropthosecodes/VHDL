vsim -t ns -novopt -lib work work.tb_vga_ctrl
view *
do wave_vga_ctrl.do
run 40 ms