onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /tb_mem_ctrl_3/clk_i
add wave -noupdate -format Logic /tb_mem_ctrl_3/reset_i
add wave -noupdate -format Logic /tb_mem_ctrl_3/pixel_en_i
add wave -noupdate -format Logic /tb_mem_ctrl_3/pixel_x_i
add wave -noupdate -format Logic /tb_mem_ctrl_3/pixel_y_i
add wave -noupdate -format Logic /tb_mem_ctrl_3/pixel_valid_i
add wave -noupdate -format Logic /tb_mem_ctrl_3/rgb_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {0 ps}
WaveRestoreZoom {0 ps} {1 ns}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -signalnamewidth 0
configure wave -justifyvalue left
