library IEEE;
use IEEE.std_logic_1164.all;
use work.train_model_package.all; 

architecture sim of tb_train_model is

  -- Declare the signals used stimulating the design's inputs.
  signal clk_i :      std_logic := '0';
  signal reset_i :    std_logic := '1';
  signal approach_o : std_logic := '0';
  signal leave_o :    std_logic := '0';

  signal pass_time :    time := 6 sec;
  signal current_time : time := 0 sec;
begin

  clk_i <= not clk_i after 500 ms;

  p_test : process
    begin
      reset_i <= '1';
      wait for 1000 ms;
      reset_i <= '0';
      wait for 5000 ms;
      current_time <= now;
      train(pass_time, current_time, approach_o, leave_o);
      wait for 15000 ms;
      current_time <= now;
      train(pass_time, current_time, approach_o, leave_o);
      wait for 15000 ms;
      current_time <= now;
      train(pass_time, current_time, approach_o, leave_o);
      wait for 15000 ms;
      current_time <= now;
      train(pass_time, current_time, approach_o, leave_o);
      wait;
    end process p_test;

end sim;
