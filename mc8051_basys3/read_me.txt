Title: mc8051 IP Core Demo Design
Date: 2017-02-26
Author: Peter Roessler
WWW: http://embsys.technikum-wien.at
======================================

This is a demo design which shows how to to implement the mc8051 IP core from Oregano Systems
into a Xilinx Artix-7 xc7a35tcpg263-1 FPGA contained on a Digilent Basys3 board. The mc8051
is processing a simple program which toggles a GPIO pin connected to a LED.

Tool flow:

- ModelSim-Intel FPGA Starter Edition 10.5b
- Xilinx Vivado 2016.1 HL WebPACK
- SDCC (Small Device C Compiler) 3.6.0. Win64

Directory structure of this design:

- mc8051_basys3

  - doc ... Documents (User Guides, Datasheets, ...)

  - hw ...  All hardware related design data
    - generate ... Generated hardware blocks (RAM, ROM, PLL, ...)
      - artix7_xc7a35tcpg263_1 ... Generated blocks for Xilinx Artix-7 xc7a35tcpg263-1 FPGA
    - hdl ... HDL code (VHDL)
      - mc8051 ... HDL code of the mc8051 IP core
    - impl ... Implementation directory (Xilinx Vivado project directory)
    - sim ... ModelSim working directory
      - tc_blink_led ... Test Case "Blink LED"
    - tb ... Testbenches

  - sw ...  All software related design data
    - blink_led ... "Blink LED" software application, running on the mc8051
      - build ... SDCC compiler working directory
      - src ... C source code of the mc8051 "Blink LED" example
   
  - tools ... Misc. tools
    - convhex ... convhex tool (referenced by the ModelSim do-files)
      - src ... C source code of convhex tool
      - win ... Windows executable of convhex tool
      - linux ... Linux executable of convhex tool
  - packihx_tcl ... packihx tool, TCL version (referenced by the ModelSim do-files)
      - src ... C source code of packihx tool
      - win ... Windows executable of packihx tool
      - linux ... Linux executable of packihx tool

More information can be found in the following lecture notes of the Dept. of Embedded Systems,
University of Applied Sciences Technikum Wien:

- DSD2_mc8051_Intro_vX_YYYY.pdf
- Getting_Started_with_mc8051_vX_YYYY.pdf

---
