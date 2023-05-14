onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /tb_shift_reg/d_i
add wave -noupdate -format Logic /tb_shift_reg/q_o
add wave -noupdate -format Logic /tb_shift_reg/clk_i
add wave -noupdate -format Logic /tb_shift_reg/en_i
add wave -noupdate -format Logic /tb_shift_reg/sh_i
add wave -noupdate -format Logic /tb_shift_reg/reset_i
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {0 ps}
WaveRestoreZoom {0 ps} {1 ns}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -signalnamewidth 0
configure wave -justifyvalue left
