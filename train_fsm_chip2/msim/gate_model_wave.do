onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /tb_gate_model/clk_i
add wave -noupdate -format Logic /tb_gate_model/reset_i
add wave -noupdate -format Logic /tb_gate_model/gate_up_i
add wave -noupdate -format Logic /tb_gate_model/gate_down_i
add wave -noupdate -format Logic /tb_gate_model/gate_state_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {0 ps}
WaveRestoreZoom {0 ps} {1 ns}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -signalnamewidth 0
configure wave -justifyvalue left
