library IEEE;
use IEEE.std_logic_1164.all;

entity led_fsm is
  port (clk_i :      in std_logic;                          --clock
        reset_i :    in std_logic;                          --reset
        fwd_bwd_i :  in std_logic;                          --forward/backward
        en_i :       in std_logic;                          --enable
        start_i :    in std_logic;                          --start
        led_o :      out std_logic_vector(7 downto 0));     --led output
end led_fsm;

