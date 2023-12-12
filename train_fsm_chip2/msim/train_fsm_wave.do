onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /tb_train_fsm/clk_i
add wave -noupdate -format Logic /tb_train_fsm/reset_i
add wave -noupdate -format Logic /tb_train_fsm/approach_i
add wave -noupdate -format Logic /tb_train_fsm/leave_i
add wave -noupdate -format Logic /tb_train_fsm/up_o
add wave -noupdate -format Logic /tb_train_fsm/down_o
add wave -noupdate -format Logic /tb_train_fsm/light_o
add wave -noupdate -format Logic /tb_train_fsm/gate_open_o
add wave -noupdate -format Logic /tb_train_fsm/gate_state_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {0 ps}
WaveRestoreZoom {0 ps} {1 ns}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -signalnamewidth 0
configure wave -justifyvalue left
