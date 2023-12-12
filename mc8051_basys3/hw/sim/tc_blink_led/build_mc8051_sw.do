# Windows console script

# compile software application for mc8051 using SDCC compiler
# and generate Intel HEX file using packihx_tcl.exe 
sdcc ../../../sw/blink_led/src/main.c -o ../../../sw/blink_led/build/
echo "sdcc: main.c sucessfully compiled"
../../../tools/packihx_tcl/win/packihx_tcl.exe ../../../sw/blink_led/build/main.ihx ../../../sw/blink_led/build/mc8051_rom.hex

# generate MIF and COE files out of Intel HEX file
../../../tools/convhex/win/convhex.exe ../../../sw/blink_led/build/mc8051_rom.hex

# copy MIF file (required for simulation only) to ModelSim simulation directory
file copy -force ../../../sw/blink_led/build/mc8051_rom.mif ../../../hw/sim/tc_blink_led/

echo "mc8051 software application built successfully!"
