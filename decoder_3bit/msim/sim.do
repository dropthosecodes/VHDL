vsim -t ns -novopt -lib work work.tb_decoder_3bit
view *
do decoder_3bit_wave.do
run 1000 ns