onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /tb_train_model/clk_i
add wave -noupdate -format Logic /tb_train_model/reset_i
add wave -noupdate -format Logic /tb_train_model/approach_o
add wave -noupdate -format Logic /tb_train_model/leave_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {0 ps}
WaveRestoreZoom {0 ps} {1 ns}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -signalnamewidth 0
configure wave -justifyvalue left
