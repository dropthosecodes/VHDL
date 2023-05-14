library IEEE;
use IEEE.std_logic_1164.all;

architecture sim of tb_led_example is

  component train_fsm
    port (leds : out std_logic_vector(15 downto 0);
          reset : in std_logic;
          clk : in std_logic); 
  end component;
  
  -- Declare the signals used stimulating the design's inputs.
  signal clk :      std_logic := '0';
  signal reset :    std_logic := '1';
  signal leds :     std_logic_vector(15 downto 0) := (others => '0');
  
begin

  clk <= not clk after 5 ns;

  -- Instantiate the tb_led_example design for testing
  i_tb_led_example : train_fsm
  port map
    (clk => clk,
     reset => reset,
     leds => leds);

  p_test : process
    begin
      reset <= '1';
      wait for 1000 ms;
      reset <= '0';
      wait for 20000 ms;
    end process p_test;

end sim;