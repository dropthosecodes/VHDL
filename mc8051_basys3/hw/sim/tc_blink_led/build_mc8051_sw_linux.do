# Linux shell script

# compile software application for mc8051 using SDCC compiler
# and generate Intel HEX file using packihx_tcl 
sdcc ../../../sw/blink_led/src/main.c -o ../../../sw/blink_led/build/
echo "sdcc: main.c sucessfully compiled"
../../../tools/packihx_tcl/linux/packihx_tcl ../../../sw/blink_led/build/main.ihx ../../../sw/blink_led/build/mc8051_rom.hex

# generate MIF and COE files out of Intel HEX file
../../../tools/convhex/linux/convhex ../../../sw/blink_led/build/mc8051_rom.hex

# copy MIF file (required for simulation only) to ModelSim simulation directory
cp ../../../sw/blink_led/build/mc8051_rom.mif ../../../hw/sim/tc_blink_led/

echo "mc8051 software application built successfully!"
