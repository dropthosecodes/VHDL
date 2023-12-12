library IEEE;
use IEEE.std_logic_1164.all;

package train_model_package is

  procedure train
    (constant pass_time :      in time;
    signal last_time :         inout time;
    signal train_approach_o :  out std_logic;
    signal train_leave_o :     out std_logic);

end train_model_package;

package body train_model_package is
  procedure train
      (constant pass_time :      in time;
      signal last_time :         inout time;
      signal train_approach_o :  out std_logic;
      signal train_leave_o :     out std_logic) is

  begin
    
    if pass_time < 6 sec then
      report "Train interval too short" severity warning;
    end if;

    last_time <= now;
    train_approach_o <= '1', '0' after 1.5 sec;
    train_leave_o <= '1' after pass_time, '0' after pass_time + 1.5 sec;

    if (now < last_time + pass_time) then
      report "Too little time has passed since the last train" severity warning;
    end if;

  end train;
end train_model_package;
