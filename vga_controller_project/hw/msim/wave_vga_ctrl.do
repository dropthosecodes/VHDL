onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /tb_vga_ctrl/clk_i
add wave -noupdate -format Logic /tb_vga_ctrl/reset_i
add wave -noupdate -format Logic /tb_vga_ctrl/pixel_en_i
add wave -noupdate -format Logic /tb_vga_ctrl/rgb_i
add wave -noupdate -format Logic /tb_vga_ctrl/red_o
add wave -noupdate -format Logic /tb_vga_ctrl/green_o
add wave -noupdate -format Logic /tb_vga_ctrl/blue_o
add wave -noupdate -format Logic /tb_vga_ctrl/hsync_o
add wave -noupdate -format Logic /tb_vga_ctrl/vsync_o
add wave -noupdate -format Logic /tb_vga_ctrl/pixel_x_o
add wave -noupdate -format Logic /tb_vga_ctrl/pixel_y_o
add wave -noupdate -format Logic /tb_vga_ctrl/pixel_valid_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {0 ps}
WaveRestoreZoom {0 ps} {1 ns}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -signalnamewidth 0
configure wave -justifyvalue left