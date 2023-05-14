library IEEE;
use IEEE.std_logic_1164.all;

entity shift_reg is
  port (d_i :     	 in std_logic_vector(3 downto 0); 	  --data in
        clk_i :      in std_logic;                        --clock
        reset_i :    in std_logic;                        --reset
        en_i :       in std_logic;                        --enable
        sh_i :       in std_logic;                        --shift
        q_o :        out std_logic_vector(3 downto 0));   --data out
end shift_reg;

