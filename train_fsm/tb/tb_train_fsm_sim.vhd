library IEEE;
use IEEE.std_logic_1164.all;

architecture sim of tb_train_fsm is

  component train_fsm
    port (clk_i :      in std_logic;        --clock
          reset_i :    in std_logic;        --reset
          approach_i : in std_logic;        --train approaching sensor
          leave_i :    in std_logic;        --train leaving sensor
          up_o :       out std_logic;       --gate opening
          down_o :     out std_logic;       --gate closing
          light_o :    out std_logic;     --warning light
          gate_open_o :   out std_logic);        --shows if the gate is open for testing purposes   
  end component;
  
  -- Declare the signals used stimulating the design's inputs.
  signal clk_i :      std_logic := '0';
  signal reset_i :    std_logic := '1';
  signal approach_i : std_logic := '0';
  signal leave_i :    std_logic := '0';
  signal up_o :       std_logic := '0';
  signal down_o :     std_logic := '0';
  signal light_o :    std_logic := '0';
  signal gate_open_o :std_logic := '0';
  
begin

  clk_i <= not clk_i after 500 ms;
  --reset_i <= '0' after 1000 ms;
  --reset_i <= '1' after 34000 ms;

  -- Instantiate the tb_train_fsm design for testing
  i_tb_train_fsm : train_fsm
  port map
    (clk_i => clk_i,
     reset_i => reset_i,
     approach_i => approach_i,
     leave_i => leave_i,
     up_o => up_o,
     down_o => down_o,
     light_o => light_o,
     gate_open_o => gate_open_o);

  p_test : process
    begin
      reset_i <= '1';
      wait for 1000 ms;
      reset_i <= '0';
      wait for 2000 ms;
      approach_i <= '1';
      wait for 1500 ms;
      approach_i <= '0';
      wait for 3000 ms;
      leave_i <= '1';
      wait for 1500 ms;
      leave_i <= '0';
      wait for 10000 ms;
      approach_i <= '1';
      wait for 1500 ms;
      approach_i <= '0';
      wait for 6000 ms;
      leave_i <= '1';
      wait for 1500 ms;
      leave_i <= '0';
      wait for 6000 ms;
      reset_i <= '1';
      wait for 300 ms;
      reset_i <= '0';
      wait for 15000 ms;
    end process p_test;

end sim;