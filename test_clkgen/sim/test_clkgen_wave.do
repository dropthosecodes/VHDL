onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic -radix hex /tb_test_clkgen/i_test_clkgen/*
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {0 ps}
WaveRestoreZoom {0 ps} {1 ns}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -signalnamewidth 0
configure wave -justifyvalue left
