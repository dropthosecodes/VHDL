library IEEE;
use IEEE.std_logic_1164.all;
use work.gate_model_package.all;

architecture rtl of gate is

  type t_direction is (UP, DOWN);
  type t_moving is (YES, NO);

  signal s_gate_state_o : t_gate_state;
  signal s_direction : t_direction := DOWN;
  signal s_moving : t_moving := NO;
  signal s_position : time := 0 sec;
  -- signal t : time := 0 sec;

  begin

    p_gate : process(gate_up_i, gate_down_i, s_position, s_moving)
    begin
      case s_gate_state_o is
        when OPENED =>
          s_moving <= NO;
          if (gate_up_i = '0' and gate_down_i = '1') then
            s_gate_state_o <= INT;
            s_moving <= YES;
            s_direction <= DOWN;
            s_position <= 0 sec;
            -- t <= now;
          end if;
            
        when CLOSED =>
        s_moving <= NO;
          if (gate_up_i = '1' and gate_down_i = '0') then
            s_gate_state_o <= INT;
            s_moving <= YES;
            s_direction <= UP;
            s_position <= 0 sec;
            -- t <= now;
          end if;

        --DIRECTION CHANGE NOT POSSIBLE ATM
        when INT =>
          if s_direction = DOWN then
            --SHOW CLOSED AFTER 4 SECONDS OF MOVING
            if(s_position >= 4 sec) then
              s_gate_state_o <= CLOSED;
            --CONTINUE MOVING DOWN
            elsif (gate_up_i = '0' and gate_down_i = '1') then
              s_position <= (s_position + 1 sec) after 1 sec;
            --STOP MOVEMENT
            elsif ( (gate_up_i = '1' and gate_down_i = '1') or (gate_up_i = '0' and gate_down_i = '0') ) then
              s_position <= s_position;
            --CHANGE DIRECTION TO UP
            elsif (gate_up_i = '1' and gate_down_i = '0') then
              s_direction <= UP;
              s_position <= 4 sec after (4 sec - s_position);
              -- s_position <= (4 sec - s_position) after 0 sec; --funktioniert bei 2 sec ned ?????
            end if;

          elsif s_direction = UP then
            --SHOW OPEN AFTER 4 SECONDS OF MOVING
            if(s_position >= 4 sec) then
              s_gate_state_o <= OPENED;
            --CONTINUE MOVING UP
            elsif (gate_up_i = '1' and gate_down_i = '0')  then
              s_position <= (s_position + 1 sec) after 1 sec;
            --STOP MOVEMENT
            elsif ( (gate_up_i = '1' and gate_down_i = '1') or (gate_up_i = '0' and gate_down_i = '0') ) then
              s_position <= s_position;
            --CHANGE DIRECTION TO DOWN
            elsif (gate_up_i = '0' and gate_down_i = '1') then
              s_direction <= DOWN;
              s_position <= 4 sec after (4 sec - s_position);
              -- s_position <= (4 sec - s_position) after 0 sec;
            end if;

          end if;

        when others =>
              s_direction <= DOWN;

      end case;
    end process p_gate;

    gate_state_o <= s_gate_state_o;
end rtl;



-- library IEEE;
-- use IEEE.std_logic_1164.all;
-- use work.gate_model_package.all;

-- architecture rtl of gate is

--   type t_direction is (UP, DOWN);
--   type t_moving is (YES, NO);

--   signal s_gate_state_o : t_gate_state;
--   signal s_direction : t_direction := DOWN;
--   signal s_moving : t_moving := NO;
--   signal s_position : time := 0 sec;
--   signal t : time := 0 sec;

--   begin

--     p_gate : process(gate_up_i, gate_down_i, s_moving, s_position)
--     begin
--       case s_gate_state_o is
--         when OPENED =>
--           if (gate_up_i = '0' and gate_down_i = '1') then
--             s_gate_state_o <= INT;
--             s_moving <= YES;
--             s_direction <= DOWN;
--             s_position <= 4 sec;
--             t <= now;
--             end if;
            
--         when CLOSED =>
--           if (gate_up_i = '1' and gate_down_i = '0') then
--             s_gate_state_o <= INT;
--             s_moving <= YES;
--             s_direction <= UP;
--             s_position <= 4 sec;
--             t <= now;
--             end if;

--         --DIRECTION CHANGE NOT POSSIBLE ATM --> extra flag?
--         when INT =>
--           if s_direction = DOWN then
--             if (gate_up_i = '0' and gate_down_i = '1') then
--               s_position <= (s_position - 1 sec) after 1 sec;
--             elsif ( (gate_up_i = '1' and gate_down_i = '1') or (gate_up_i = '0' and gate_down_i = '0') ) then
--               s_position <= s_position;
--             elsif (gate_up_i = '1' and gate_down_i = '0') then
--               s_position <= s_position;
--               s_direction <= UP;
--               if s_position = 3 sec then
--                 s_position <= 1 sec;
--               elsif s_position = 1 sec then
--                 s_position <= 3 sec;
--               end if;
--             end if;

--             if(s_position = 0 sec) then
--               s_gate_state_o <= CLOSED;
--             end if;

--           elsif s_direction = UP then
--             if (gate_up_i = '1' and gate_down_i = '0')  then
--               s_position <= (s_position - 1 sec) after 1 sec;
--             elsif ( (gate_up_i = '1' and gate_down_i = '1') or (gate_up_i = '0' and gate_down_i = '0') ) then
--               s_position <= s_position;
--             elsif (gate_up_i = '0' and gate_down_i = '1') then
--               s_position <= s_position;
--               s_direction <= DOWN;
--             end if;

--             if(s_position = 0 sec) then
--               s_gate_state_o <= OPENED;
--             end if;
--           end if;

--         when others =>

--       end case;
--     end process p_gate;

--     gate_state_o <= s_gate_state_o;
-- end rtl;






















-- library IEEE;
-- use IEEE.std_logic_1164.all;
-- use work.gate_model_package.all;

-- architecture rtl of gate is

--   signal s_gate_internal : t_gate_internal := gate_init_state;
--   signal s_gate_state_o : t_gate_state;
--   signal t : time := 0 sec;
--   signal timeflag : std_logic := '0';

--   begin

--     p_gate : process(gate_up_i, gate_down_i, timeflag)
--     begin
--       case s_gate_internal is
--         when OPENED =>
--           if (gate_up_i = '0' and gate_down_i = '1') then
--             s_gate_internal <= CLOSING;
--             s_gate_state_o <= INT;
--             timeflag <= '1' after 4 sec;
--           end if;

--         when CLOSING =>
--           if timeflag = '0' then
--             s_gate_internal <= CLOSING;
--           elsif timeflag = '1' then
--             s_gate_internal <= CLOSED;
--             s_gate_state_o <= CLOSED;
--             timeflag <= '0';
--           end if;

--         when CLOSED =>
--           if (gate_up_i = '1' and gate_down_i = '0') then
--             s_gate_internal <= OPENING;
--             s_gate_state_o <= INT;
--             timeflag <= '1' after 4 sec;
--         end if;

--         when OPENING =>
--           if timeflag = '0' then
--             s_gate_internal <= OPENING;
--           elsif timeflag = '1' then
--             s_gate_internal <= OPENED;
--             s_gate_state_o <= OPENED;
--             timeflag <= '0';
--           end if;

--         when others =>

--       end case;
--     end process p_gate;

--     gate_state_o <= s_gate_state_o;
-- end rtl;