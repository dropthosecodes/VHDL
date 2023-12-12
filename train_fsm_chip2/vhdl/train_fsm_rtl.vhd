library IEEE;
use IEEE.std_logic_1164.all;

architecture rtl of train_fsm is

  type t_state is (CLOSING_1S, CLOSING_2S, CLOSING_3S, CLOSING_4S, CLOSED,
                   OPENING_1S, OPENING_2S, OPENING_3S, OPENING_4S, OPENED);
  signal s_state : t_state;
  signal s_up_o : std_logic;
  signal s_down_o : std_logic;
  signal s_light_o : std_logic := '0';
  signal s_gate_open_o : std_logic;

  begin
    p_train_fsm : process(clk_i, reset_i, approach_i, leave_i)

    variable light : std_logic;

    begin
      if reset_i = '1' then
        s_state <= CLOSING_1S;
        light := '1';
        s_up_o <= '0';
        s_down_o <= '1';
        s_gate_open_o <= '0';

      elsif clk_i'event and clk_i = '1' then
        case s_state is
          when CLOSED =>
            light := '1';
            s_up_o <= '0';
            s_down_o <= '0';
            if leave_i = '1' then
              s_up_o <= '1';
              s_state <= OPENING_1S;
            -- else
            --   s_state <= CLOSED;
            end if;

          when OPENED =>
            light := '0';
            s_up_o <= '0';
            s_down_o <= '0';
            --s_gate_open_o <= '1';
            if approach_i = '1' then
              light := '1';
              s_down_o <= '1';
              s_gate_open_o <= '0';
              s_state <= CLOSING_1S;
            -- else 
            --   s_state <= OPENED;
            end if;

          when CLOSING_1S =>
            light := '1';
            s_up_o <= '0';
            s_down_o <= '1';
            s_state <= CLOSING_2S;
          when CLOSING_2S =>
            light := '1';
            s_up_o <= '0';
            s_down_o <= '1';
            s_state <= CLOSING_3S;
          when CLOSING_3S =>
            light := '1';
            s_up_o <= '0';
            s_down_o <= '1';
            s_state <= CLOSING_4S;
          when CLOSING_4S =>
            light := '1';
            s_up_o <= '0';
            s_down_o <= '0';
            s_state <= CLOSED;

          when OPENING_1S =>
            light := '1';
            s_up_o <= '1';
            s_down_o <= '0';
            s_state <= OPENING_2S;
          when OPENING_2S =>
            light := '1';
            s_up_o <= '1';
            s_down_o <= '0';
            s_state <= OPENING_3S;
          when OPENING_3S =>
            light := '1';
            s_up_o <= '1';
            s_down_o <= '0';
            s_state <= OPENING_4S;
          when OPENING_4S =>
            light := '0';
            s_up_o <= '0';
            s_down_o <= '0';
            s_gate_open_o <= '1';
            s_state <= OPENED;
          
          when others => 
            s_state <= CLOSING_1S; 
        end case;
        
        if light = '1' then
          s_light_o <= not s_light_o;
        elsif light = '0' then
          s_light_o <= '0';
        end if;

      end if;
    end process p_train_fsm;

    up_o <= s_up_o;
    down_o <= s_down_o;
    light_o <= s_light_o;
    gate_open_o <= s_gate_open_o;
    
end rtl;



-- architecture rtl of train_fsm is

--   type t_state is (CLOSED, OPENED, INTERMEDIATE);
--   signal s_state : t_state;
--   signal s_up_o : std_logic;
--   signal s_down_o : std_logic;
--   signal s_light_o : std_logic := '0';
--   signal s_gate_open_o : std_logic;

--   begin
--     p_train_fsm : process(clk_i, reset_i, approach_i, leave_i)

--     variable light : std_logic;
--     variable open_close : std_logic;
--     variable timer : integer := 0;

--     begin
--       if reset_i = '1' then
--         s_state <= CLOSED;
--         s_up_o <= '0';
--         s_down_o <= '0';
--         s_gate_open_o <= '0';
--         light := '1';

--       elsif clk_i'event and clk_i = '1' then
--         case s_state is
--           when OPENED =>
--             s_gate_open_o <= '1';
--             light := '0';

--             if approach_i = '1' then
--               s_state <= INTERMEDIATE;
--               light := '1';
--               open_close := '1';
--             end if;

--           when CLOSED =>
--             s_gate_open_o <= '0';
--             light := '1';

--             if leave_i = '1' then
--               s_state <= INTERMEDIATE;
--               light := '1';
--               open_close := '0';
--             end if;
              
--           when INTERMEDIATE =>
--             light := '1';
--             s_gate_open_o <= '0';

--             if open_close = '1' then --close
--               s_down_o <= '1';
--               s_up_o <= '0';
--               if timer = 4 then
--                 s_state <= CLOSED;
--                 s_up_o <= '0';
--                 s_down_o <= '0';
--                 s_gate_open_o <= '0';
--                 light := '1';
--                 end if;
--               timer := timer + 1;
--             elsif open_close = '0' then --open
--               s_down_o <= '0';
--               s_up_o <= '1';
--               if timer = 4 then
--                 s_state <= OPENED;
--                 s_up_o <= '0';
--                 s_down_o <= '0';
--                 s_gate_open_o <= '1';
--                 light := '0';
--                 end if;
--               timer := timer + 1;
--             end if;
--           when others => 
            
--         end case;
--       end if;

--       if clk_i'event and clk_i = '1' and light = '1' then
--         s_light_o <= not s_light_o;
--       end if;

--     end process p_train_fsm;

--     up_o <= s_up_o;
--     down_o <= s_down_o;
--     light_o <= s_light_o;
--     gate_open_o <= s_gate_open_o;
    
-- end rtl;