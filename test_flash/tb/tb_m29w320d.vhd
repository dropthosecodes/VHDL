-- Testbench for 29w320d FLASH memory simulation model from Micron
-- Author: Peter Roessler
-- Date: 2015-06-08 
--
-- If you want to use the FLASH simulation model to model the FLASH device that
-- is contained on the Terasic DE0 FPGA board please note the following things:
-- * Package "generic_data" must be included (see line 16) 
-- * Use the values shown in line 79-85 for the generics and the ports 
-- * Add the lines 103-104 and connect the signals s_reset_n and VppWP_N_std_logic
--   to your design
-- * Apply the start-up sequence that is shown in lines 118-129 to avoid warnings
--   from the FLASH simulation model
 
library IEEE;
use IEEE.std_logic_1164.all;
use work.generic_data.all;

entity tb_m29w320d is
end tb_m29w320d;

architecture sim of tb_m29w320d is

-- m29w320d FLASH memory simulation model from Micron
component m29w320d is
  generic(
    organization : string;
    memoryfile   : string;
    time_access  : time
    );
  port(
    Vcc     : in    real;
    Vss     : in    real;
    W_N     : in    std_logic;
    E_N     : in    std_logic;
    G_N     : in    std_logic;
    RP_N    : in    real;
    Byte_N  : in    std_logic;
    RB      : out   std_logic;
    A       : in    std_logic_vector(Addr_Bus_Dim - 1 downto 0);
    DQ      : inout std_logic_vector(Data_Bus_Dim - 2 downto 0);
    DQ15A_1 : inout std_logic;
    VppWP_N : in    real
    );
end component;

-- signals of m29w320d FLASH memory simulation model
signal W_N : std_logic;
signal E_N : std_logic;
signal G_N : std_logic;
signal RP_N : real;
signal Byte_N : std_logic;
signal RB : std_logic;
signal A : std_logic_vector(Addr_Bus_Dim - 1 downto 0);
signal ADDR : std_logic_vector(Addr_Bus_Dim - 2 downto 0);
signal DQ : std_logic_vector(Data_Bus_Dim - 1 downto 0);
signal VppWP_N : real;
signal VppWP_N_std_logic : std_logic;

-- clock and active low reset signal
signal s_clk : std_logic;
signal s_reset_n : std_logic;

begin

  -- simulate 50 MHz clock oscillator
  p_clk : process
  begin
    loop
      s_clk <= '0';
      wait for 10 ns;
      s_clk <= '1';
      wait for 10 ns;
    end loop;
  end process p_clk;

  -- instantiate m29w320d FLASH memory simulation model
  i_m29w320d : m29w320d
    generic map(
      organization => "top",                    -- memory organization = top
      memoryfile   => "../mem/memory_file",     -- file, that defines FLASH memory content
      time_access  => 70 ns                     -- FLASH access time = 70 ns
      )
    port map(
      Vcc     => 3.3,                           -- supply voltage = 3.3 V
      Vss     => 0.0,                           -- device ground potential = 0 V
      W_N     => W_N,                           -- write enable (active low)
      E_N     => E_N,                           -- chip enable (active low)
      G_N     => G_N,                           -- output enable (active low)
      RP_N    => RP_N,                          -- device reset (active low)
      Byte_N  => Byte_N,                        -- selecte 8-bit (0) or 16-bit (1) mode
      RB      => RB,                            -- ready/busy output
      A       => A,                             -- 21 address inputs
      DQ      => DQ(Data_Bus_Dim - 2 downto 0), -- 15 least significant data inputs/outputs
      DQ15A_1 => DQ(Data_Bus_Dim - 1),          -- most significant data input/output
      VppWP_N => VppWP_N                        -- write protect/programming acceleration input
      );

  -- The Terasic DE0 FPGA board is equipped with a FLASH device that does not
  -- make use of address line A[21]
  A <= '0' & ADDR;

  -- convert from std_logic to real
  RP_N <= 0.0 when s_reset_n='0' else 3.3;
  VppWP_N <= 0.0 when VppWP_N_std_logic='0' else 3.3;
  
  -- timing of simulation
  p_tb : process
  begin
    -- initial states of all inputs and bi-directional signals
    W_N <= '1';
    E_N <= '1';
    G_N <= '1';
    Byte_N <= '1';
    ADDR <= b"0000_0000_0000_0000_0110"; -- address = 0x6
    DQ <= (others => 'Z');
    VppWP_N_std_logic <= '0';

    -- correct start-up sequence to avoid warnings from simulation model:
    -- set RP_N to 0 V for 400 ns
    -- followed by RP_N = 3.3 V for 400 ns
    -- followed by E_N = 0 for 400 ns
    -- followed by G_N = 0  
    s_reset_n <= '0';
    wait for 20*20 ns;
    s_reset_n <= '1';
    wait for 20*20 ns;
    E_N <= '0';
    wait for 20*20 ns;
    G_N <= '0';

    -- read from FLASH address 0x7
    wait for 8*20 ns;
    ADDR <= b"0000_0000_0000_0000_0111";

    -- read from FLASH address 0x7ffff
    wait for 8*20 ns;
    ADDR <= b"0111_1111_1111_1111_1111";

    -- read from FLASH address 0x0e
    wait for 8*20 ns;
    ADDR <= b"0000_0000_0000_0000_1110";

    -- read from FLASH address 0x0f
    wait for 8*20 ns;
    ADDR <= b"0000_0000_0000_0000_1111";

    -- wait until end of simulation
    wait;
  end process;

end sim;
