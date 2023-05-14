onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /tb_JK_FF/j_i
add wave -noupdate -format Logic /tb_JK_FF/k_i
add wave -noupdate -format Logic /tb_JK_FF/q_o
add wave -noupdate -format Logic /tb_JK_FF/clk_i
add wave -noupdate -format Logic /tb_JK_FF/reset_i
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {0 ps}
WaveRestoreZoom {0 ps} {1 ns}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -signalnamewidth 0
configure wave -justifyvalue left
