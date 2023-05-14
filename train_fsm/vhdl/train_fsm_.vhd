library IEEE;
use IEEE.std_logic_1164.all;

entity train_fsm is
  port (clk_i :         in std_logic;           --clock
        reset_i :       in std_logic;           --reset
        approach_i :    in std_logic;           --train approaching sensor
        leave_i :       in std_logic;           --train leaving sensor
        up_o :          out std_logic;          --gate opening
        down_o :        out std_logic;          --gate closing
        light_o :       out std_logic;          --warning light
        gate_open_o :   out std_logic);        --shows if the gate is open for testing purposes   
end train_fsm;

