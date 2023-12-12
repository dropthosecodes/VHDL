package gate_model_package is

  type t_gate_state is (OPENED, INT, CLOSED); --external

end gate_model_package;

library IEEE;
use IEEE.std_logic_1164.all;
use work.gate_model_package.all;

entity gate is
  generic (gate_init_state : in t_gate_state := OPENED);

  port (gate_up_i :       in std_logic;           --gate up signal
        gate_down_i :     in std_logic;           --gate down signal
        gate_state_o :    out t_gate_state);      --gate position (from an external POV)
end gate;




















-- package gate_model_package is

--   type t_gate_state is (OPENED, INT, CLOSED); --external

--   -- type t_gate_internal is (OPENED, OPENING, CLOSED, CLOSING); --internal

-- end gate_model_package;

-- library IEEE;
-- use IEEE.std_logic_1164.all;
-- use work.gate_model_package.all;

-- entity gate is
--   generic (gate_init_state : in t_gate_internal := OPENED); --internal gate state, used for state machine

--   port (gate_up_i :       in std_logic;           --gate up signal
--         gate_down_i :     in std_logic;           --gate down signal
--         gate_state_o :    out t_gate_state);      --gate position (from an external POV)
-- end gate;