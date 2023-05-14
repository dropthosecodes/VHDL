onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /tb_led_fsm/clk_i
add wave -noupdate -format Logic /tb_led_fsm/reset_i
add wave -noupdate -format Logic /tb_led_fsm/fwd_bwd_i
add wave -noupdate -format Logic /tb_led_fsm/en_i
add wave -noupdate -format Logic /tb_led_fsm/start_i
add wave -noupdate -format Logic /tb_led_fsm/led_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {0 ps}
WaveRestoreZoom {0 ps} {1 ns}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -signalnamewidth 0
configure wave -justifyvalue left
