onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /tb_io_ctrl_sim/clk_i
add wave -noupdate -format Logic /tb_io_ctrl_sim/reset_i
add wave -noupdate -format Logic_vector /tb_io_ctrl_sim/dig0_i
add wave -noupdate -format Logic_vector /tb_io_ctrl_sim/dig1_i
add wave -noupdate -format Logic_vector /tb_io_ctrl_sim/dig2_i
add wave -noupdate -format Logic_vector /tb_io_ctrl_sim/dig3_i
add wave -noupdate -format Logic_vector /tb_io_ctrl_sim/led_i
add wave -noupdate -format Logic_vector /tb_io_ctrl_sim/sw_i
add wave -noupdate -format Logic_vector /tb_io_ctrl_sim/pb_i
add wave -noupdate -format Logic_vector /tb_io_ctrl_sim/ss_o
add wave -noupdate -format Logic_vector /tb_io_ctrl_sim/ss_sel_o
add wave -noupdate -format Logic_vector /tb_io_ctrl_sim/led_o
add wave -noupdate -format Logic_vector /tb_io_ctrl_sim/swsync_o
add wave -noupdate -format Logic_vector /tb_io_ctrl_sim/pbsync_o

TreeUpdate [SetDefaultTree]
WaveRestoreCursors {0 ps}
WaveRestoreZoom {0 ps} {1 ns}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -signalnamewidth 0
configure wave -justifyvalue left
