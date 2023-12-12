onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /tb_src_mux/clk_i
add wave -noupdate -format Logic /tb_src_mux/reset_i
add wave -noupdate -format Logic /tb_src_mux/pixel_en_i
add wave -noupdate -format Logic /tb_src_mux/sw_i
add wave -noupdate -format Logic /tb_src_mux/pb_i
add wave -noupdate -format Logic /tb_src_mux/pat1_rgb_i
add wave -noupdate -format Logic /tb_src_mux/pat2_rgb_i
add wave -noupdate -format Logic /tb_src_mux/mem1_rgb_i
add wave -noupdate -format Logic /tb_src_mux/mem2_rgb_i
add wave -noupdate -format Logic /tb_src_mux/mem3_rgb_i
add wave -noupdate -format Logic /tb_src_mux/mem2_pixel_x_o
add wave -noupdate -format Logic /tb_src_mux/mem2_pixel_y_o
add wave -noupdate -format Logic /tb_src_mux/mem2_pixel_valid_o  
add wave -noupdate -format Logic /tb_src_mux/mem3_pixel_x_o
add wave -noupdate -format Logic /tb_src_mux/mem3_pixel_y_o
add wave -noupdate -format Logic /tb_src_mux/mem3_pixel_valid_o 
add wave -noupdate -format Logic /tb_src_mux/pixel_x_i
add wave -noupdate -format Logic /tb_src_mux/pixel_y_i
add wave -noupdate -format Logic /tb_src_mux/pixel_valid_i
add wave -noupdate -format Logic /tb_src_mux/rgb_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {0 ps}
WaveRestoreZoom {0 ps} {1 ns}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -signalnamewidth 0
configure wave -justifyvalue left