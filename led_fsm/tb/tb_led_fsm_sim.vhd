library IEEE;
use IEEE.std_logic_1164.all;

architecture sim of tb_led_fsm is

  component led_fsm
    port (clk_i :      in std_logic;                          --clock
          reset_i :    in std_logic;                          --reset
          fwd_bwd_i :  in std_logic;                          --forward/backward
          en_i :       in std_logic;                          --enable
          start_i :    in std_logic;                          --start
          led_o :      out std_logic_vector(7 downto 0));     --led output
  end component;
  
  -- Declare the signals used stimulating the design's inputs.
  signal clk_i :      std_logic := '0';
  signal reset_i :    std_logic := '1';
  signal fwd_bwd_i :  std_logic := '0';
  signal en_i :       std_logic := '0';
  signal start_i :    std_logic := '0';
  signal led_o :      std_logic_vector(7 downto 0) := "00000000";
  
begin

  clk_i <= not clk_i after 30 ns;
  reset_i <= '0' after 100 ns;
  -- en_i <= '1' after 170 ns;
  -- start_i <= '1' after 300 ns;

  -- Instantiate the tb_led_fsm design for testing
  i_tb_led_fsm : led_fsm
  port map
    (clk_i => clk_i,
     reset_i => reset_i,
     fwd_bwd_i => fwd_bwd_i,
     en_i => en_i,
     start_i => start_i,
     led_o => led_o);

  p_test : process
    begin
      wait for 200 ns;
      en_i <= '1';
      start_i <= '1';
      fwd_bwd_i <= '0';
      wait for 30 ns;
      start_i <= '0';

      wait for 550 ns;
      en_i <= '1';
      start_i <= '1';
      fwd_bwd_i <= '1';
      wait for 30 ns;
      start_i <= '0';

      wait for 550 ns;
      en_i <= '0';
      start_i <= '1';
      fwd_bwd_i <= '1';
      wait for 60 ns;
      start_i <= '0';

      wait for 550 ns;
      en_i <= '0';
      start_i <= '1';
      fwd_bwd_i <= '0';
      wait for 30 ns;
      start_i <= '0';
      
      wait for 550 ns;
    end process p_test;

end sim;