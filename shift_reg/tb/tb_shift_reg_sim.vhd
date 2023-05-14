library IEEE;
use IEEE.std_logic_1164.all;

architecture sim of tb_shift_reg is

  component shift_reg
    port (d_i :     	 in std_logic_vector(3 downto 0); 	  --data in
          clk_i :      in std_logic;                        --clock
          reset_i :    in std_logic;                        --reset
          en_i :       in std_logic;                        --enable
          sh_i :       in std_logic;                        --shift
          q_o :        out std_logic_vector(3 downto 0));   --data out
  end component;
  
  -- Declare the signals used stimulating the design's inputs.
  signal d_i :      std_logic_vector(3 downto 0) := "0000";
  signal clk_i :    std_logic := '0';
  signal reset_i :  std_logic := '1';
  signal en_i :     std_logic := '0';
  signal sh_i :     std_logic := '0';
  signal q_o :      std_logic_vector(3 downto 0);
  
begin

  clk_i <= not clk_i after 30 ns;
  reset_i <= '0' after 200 ns;

  -- Instantiate the tb_shift_reg design for testing
  i_tb_shift_reg : shift_reg
  port map
    (d_i  => d_i,
     clk_i => clk_i,
     reset_i => reset_i,
     en_i => en_i,
     sh_i => sh_i,
     q_o => q_o);

  p_test : process
    begin
      en_i <= '1';
      d_i <= "0001";
      wait for 100 ns;
      d_i <= "0001";
      wait for 100 ns;
      d_i <= "0001";
      wait for 100 ns;
      sh_i <= '1';
      wait for 1000 ns;
    end process p_test;

end sim;