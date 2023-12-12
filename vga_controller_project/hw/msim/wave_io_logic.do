onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /tb_io_logic/clk_i
add wave -noupdate -format Logic /tb_io_logic/reset_i
add wave -noupdate -format Logic /tb_io_logic/sw_i
add wave -noupdate -format Logic /tb_io_logic/sw_o
add wave -noupdate -format Logic /tb_io_logic/pb_i
add wave -noupdate -format Logic /tb_io_logic/pb_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {0 ps}
WaveRestoreZoom {0 ps} {1 ns}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -signalnamewidth 0
configure wave -justifyvalue left
