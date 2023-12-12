-------------------------------------------------------------------------------
-- CALCULATOR PROJECT
-------------------------------------------------------------------------------
-- Author: Konstantin Haferl
--
-- Filename: alu_rtl.vhd
--
-- Date of Creation: 2023 05 05
--
-- Version: $Revision$
--
-- Design Unit: ALU (Architecture)
--
-- Description: The ALU is part of the calculator project.
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

architecture rtl of alu is
  --Operators
  constant OP_ADD : std_logic_vector(3 downto 0):= "0000";
  constant OP_SUB : std_logic_vector(3 downto 0):= "0001";
  constant OP_RE :  std_logic_vector(3 downto 0):= "0100";
  constant OP_AND : std_logic_vector(3 downto 0):= "1001";
  constant OP_ROL : std_logic_vector(3 downto 0):= "1100";

  signal s_result_o :      std_logic_vector(15 downto 0);  --result
  signal s_error_o :       std_logic;                      --error flag
  signal s_overflow_o :    std_logic;                      --overflow flag
  signal s_sign_o :        std_logic;                      --signed flag
  signal s_finished_o :    std_logic;                      --finished signal

  signal s_result_add :    std_logic_vector(12 downto 0);  --add result
  -- signal s_error_add :     std_logic;                      --add error flag
  -- signal s_overflow_add :  std_logic;                      --add overflow flag
  -- signal s_sign_add :      std_logic;                      --add signed flag
  signal s_finished_add :  std_logic;                      --add finished signal

  signal s_result_sub :    std_logic_vector(11 downto 0);  --sub result
  -- signal s_error_sub :     std_logic;                      --sub error flag
  -- signal s_overflow_sub :  std_logic;                      --sub overflow flag
  signal s_sign_sub :      std_logic;                      --sub signed flag
  signal s_finished_sub :  std_logic;                      --sub finished signal

  signal s_result_re :     std_logic_vector(11 downto 0);  --re result
  signal s_error_re :      std_logic;                      --re error flag
  -- signal s_overflow_re :   std_logic;                      --re overflow flag
  -- signal s_sign_re :       std_logic;                      --re signed flag
  signal s_finished_re :   std_logic;                      --re finished signal

  signal s_result_and :    std_logic_vector(11 downto 0);  --and result
  -- signal s_error_and :     std_logic;                      --and error flag
  -- signal s_overflow_and :  std_logic;                      --and overflow flag
  -- signal s_sign_and :      std_logic;                      --and signed flag
  signal s_finished_and :  std_logic;                      --and finished signal

  signal s_result_rol :    std_logic_vector(11 downto 0);  --rol result
  -- signal s_error_rol :     std_logic;                      --rol error flag
  -- signal s_overflow_rol :  std_logic;                      --rol overflow flag
  -- signal s_sign_rol :      std_logic;                      --rol signed flag
  signal s_finished_rol :  std_logic;                      --rol finished signal

  signal div_operation_flag : std_logic;
  signal div_ff :             unsigned(11 downto 0);
begin

  --Add operation
  p_op_add: process (clk_i, reset_i)
  begin
    if reset_i = '1' then --asynchronous reset (active high)
      s_result_add <= (others => '0');
      -- s_error_add <= '0';
      -- s_overflow_add <= '0';
      -- s_sign_add <= '0';
      s_finished_add <= '0';
    elsif clk_i'event and clk_i = '1' then --rising clock edge
      if optype_i = OP_ADD then
        if start_i = '1' then  
          s_result_add(12 downto 0) <= std_logic_vector((unsigned(op1_i) + resize(unsigned(op2_i), 13)));
          -- s_error_add <= '0';
          -- s_overflow_add <= '0';
          -- s_sign_add <= '0';
          s_finished_add <= '1';
        else 
         s_finished_add <= '0';
        end if;
      end if;
    end if;
  end process p_op_add;

  --Subtraction
  p_op_sub: process (clk_i, reset_i)
  begin
    if reset_i = '1' then --asynchronous reset (active high)
      s_result_sub <= (others => '0');
      -- s_error_sub <= '0';
      -- s_overflow_sub <= '0';
      s_sign_sub <= '0';
      s_finished_sub <= '0';
    elsif clk_i'event and clk_i = '1' then --rising clock edge
      if optype_i = OP_SUB then
        if start_i = '1' then  
          if unsigned(op1_i) >= unsigned(op2_i) then
            s_result_sub(11 downto 0) <= std_logic_vector( unsigned(op1_i) - unsigned(op2_i) );
            s_sign_sub <= '0';
          else 
            s_result_sub(11 downto 0) <= std_logic_vector( (not (unsigned(op1_i) - unsigned(op2_i))) + unsigned(to_signed(1, 1)));
            s_sign_sub <= '1';
          end if;
          -- s_error_sub <= '0';
          -- s_overflow_sub <= '0';
          s_finished_sub <= '1';
        else 
         s_finished_sub <= '0';
        end if;
      end if;
    end if;
  end process p_op_sub;

  --Remainder of Division 
  p_op_re: process (clk_i, reset_i)
  variable counter : integer;
  begin
    if reset_i = '1' then --asynchronous reset (active high)
      div_operation_flag <= '0';
      div_ff <= (others => '0');
      counter := 0;

      s_result_re <= (others => '0');
      s_error_re <= '0';
      -- s_overflow_re <= '0';
      -- s_sign_re <= '0';
      s_finished_re <= '0';
    elsif clk_i'event and clk_i = '1' then --rising clock edge
      if optype_i = OP_RE then
        if start_i = '1' then
          div_operation_flag <= '1';
          div_ff(11 downto 0) <= unsigned(op1_i);
          counter := 0;
        end if;

        if div_operation_flag = '1' then
          if unsigned(op2_i) = 0 then
            s_error_re <= '1';
            s_finished_re <= '1';
          elsif div_ff(11 downto 0) >= unsigned(op2_i) then
            div_ff(11 downto 0) <= unsigned(div_ff(11 downto 0) - unsigned(op2_i));
            counter := counter + 1;
          else
            s_result_re(11 downto 0) <= std_logic_vector(div_ff(11 downto 0));
            div_operation_flag <= '0';
            s_error_re <= '0';
            -- s_overflow_re <= '0';
            -- s_sign_re <= '0';
            s_finished_re <= '1';
          end if;
        else
          s_finished_re <= '0';
        end if;
      end if;
    end if;
  end process p_op_re;

  --Logical And
  p_op_and: process (clk_i, reset_i)
  begin
    if reset_i = '1' then --asynchronous reset (active high)
      s_result_and <= (others => '0');
      -- s_error_and <= '0';
      -- s_overflow_and <= '0';
      -- s_sign_and <= '0';
      s_finished_and <= '0';
    elsif clk_i'event and clk_i = '1' then --rising clock edge
      if optype_i = OP_AND then
        if start_i = '1' then  
          s_result_and <= op1_i(11 downto 0) and op2_i(11 downto 0);
          -- s_error_and <= '0';
          -- s_overflow_and <= '0';
          -- s_sign_and <= '0';
          s_finished_and <= '1';
        else 
          s_finished_and <= '0';
        end if;
      end if;
    end if;
  end process p_op_and;

  --Rotate left
  p_op_rol: process (clk_i, reset_i)
  begin
    if reset_i = '1' then --asynchronous reset (active high)
      s_result_rol <= (others => '0');
      -- s_error_rol <= '0';
      -- s_overflow_rol <= '0';
      -- s_sign_rol <= '0';
      s_finished_rol <= '0';
    elsif clk_i'event and clk_i = '1' then --rising clock edge
      if optype_i = OP_ROL then
        if start_i = '1' then  
          s_result_rol(11 downto 0) <= std_logic_vector(rotate_left(unsigned(op1_i), 1));
          -- s_error_rol <= '0';
          -- s_overflow_rol <= '0';
          -- s_sign_rol <= '0';
          s_finished_rol <= '1';
        else 
         s_finished_rol <= '0';
        end if;
      end if;
    end if;
  end process p_op_rol;

  --Multiplexer used to select the appropriate result and error signals
  p_mux: process (clk_i, reset_i)
  begin
    if reset_i = '1' then --asynchronous reset (active high)
      s_result_o <= (others => '0');
      s_error_o <= '0';
      s_overflow_o <= '0';
      s_sign_o <= '0';
      s_finished_o <= '0';
    elsif clk_i'event and clk_i = '1' then --rising clock edg
      case optype_i is
        when OP_ADD =>
          s_result_o(12 downto 0) <= s_result_add;
          s_error_o <= '0';
          s_overflow_o <= '0';
          s_sign_o <= '0';
          s_finished_o <= s_finished_add;

        when OP_SUB =>
          s_result_o(11 downto 0) <= s_result_sub;
          s_error_o <= '0';
          s_overflow_o <= '0';
          s_sign_o <= s_sign_sub;
          s_finished_o <= s_finished_sub;

        when OP_RE =>
          s_result_o(11 downto 0) <= s_result_re;
          s_error_o <= s_error_re;
          s_overflow_o <= '0';
          s_sign_o <= '0';
          s_finished_o <= s_finished_re;

        when OP_AND =>
          s_result_o(11 downto 0) <= s_result_and;
          s_error_o <= '0';
          s_overflow_o <= '0';
          s_sign_o <= '0';
          s_finished_o <= s_finished_and;
        when OP_ROL =>
          s_result_o(11 downto 0) <= s_result_rol;
          s_error_o <= '0';
          s_overflow_o <= '0';
          s_sign_o <= '0';
          s_finished_o <= s_finished_rol;

        when others =>
          s_error_o <= '1';
          if start_i <= '1' then
            s_finished_o <= '1';
          else
            s_finished_o <= '1';
          end if;
      end case;
    end if;
  end process p_mux;

  result_o <= s_result_o;
  error_o <= s_error_o;
  overflow_o <= s_overflow_o;
  sign_o <= s_sign_o;
  finished_o <= s_finished_o;
  
end rtl;

-- p_calc: process (clk_i, reset_i)
-- variable div_ff: integer;
-- variable div_counter: integer;
-- begin
--   if reset_i = '1' then --asynchronous reset (active high)
--     div_ff := 0;
--     div_counter := 0;
--     s_result_add <= (others => '0');
--     s_error_add <= '0';
--     s_overflow_add <= '0';
--     s_sign_add <= '0';
--     s_finished_add <= '0';
--     s_result_sub <= (others => '0');
--     s_error_sub <= '0';
--     s_overflow_sub <= '0';
--     s_sign_sub <= '0';
--     s_finished_sub <= '0';
--     s_result_re <= (others => '0');
--     s_error_re <= '0';
--     s_overflow_re <= '0';
--     s_sign_re <= '0';
--     s_finished_re <= '0';
--     s_result_and <= (others => '0');
--     s_error_and <= '0';
--     s_overflow_and <= '0';
--     s_sign_and <= '0';
--     s_finished_and <= '0';
--     s_result_rol <= (others => '0');
--     s_error_rol <= '0';
--     s_overflow_rol <= '0';
--     s_sign_rol <= '0';
--     s_finished_rol <= '0';
--   elsif clk_i'event and clk_i = '1' then --rising clock edge
--     if start_i = '1' then
--       case optype_i is
--         when OP_ADD =>
--           s_result_add(15 downto 0) <= std_logic_vector((unsigned(op1_i) + resize(unsigned(op2_i), 15+1)));
--           s_error_add <= '0';
--           s_overflow_add <= '0';
--           s_sign_add <= '0';
--           s_finished_add <= '1';

--         when OP_SUB =>
--           if op1_i >= op2_i then --TYPECAST?
--             s_result_sub(11 downto 0) <= std_logic_vector( unsigned(op1_i) - unsigned(op2_i) );
--             s_sign_sub <= '0';
--           else 
--             --s_result_sub(11 downto 0) <= std_logic_vector(unsigned( (not std_logic_vector(unsigned(op1_i) - unsigned(op2_i))) ) + unsigned(to_signed(1, 1)) );
--             s_result_sub(11 downto 0) <= std_logic_vector( (not (unsigned(op1_i) - unsigned(op2_i))) + unsigned(to_signed(1, 1)));
--             s_sign_sub <= '1';
--           end if;
--           s_error_sub <= '0';
--           s_overflow_sub <= '0';
--           s_finished_sub <= '1';

--         when OP_RE =>
--           if unsigned(op2_i) = 0 then
--             s_error_re <= '1';
--           elsif unsigned(op1_i) < unsigned(op2_i) then
--             s_result_re(11 downto 0) <= op1_i;
--             s_error_re <= '0';
--           else
--             div_counter := 0;
--             div_ff := to_integer(unsigned(op1_i));

--             while div_ff >= to_integer(unsigned(op2_i)) loop    --illegal
--               div_counter := div_counter + 1;
--               div_ff := div_ff - to_integer(unsigned(op2_i));
--             end loop;
            
--             s_result_re(15 downto 0) <= std_logic_vector(unsigned(to_signed(div_ff, 16)));
--             s_error_re <= '0';
            
--           end if;
--           s_overflow_re <= '0';
--           s_sign_re <= '0';
--           s_finished_re <= '1';

--         when OP_AND =>
--           s_result_and(11 downto 0) <= op1_i(11 downto 0) and op2_i(11 downto 0);
--           s_error_and <= '0';
--           s_overflow_and <= '0';
--           s_sign_and <= '0';
--           s_finished_and <= '1';

--         when OP_ROL =>
--           s_result_rol(11 downto 0) <= std_logic_vector(rotate_left(unsigned(op1_i), 1));
--           s_error_rol <= '0';
--           s_overflow_rol <= '0';
--           s_sign_rol <= '0';
--           s_finished_rol <= '1';

--         when others => null;
--       end case;
--     else
--       s_finished_add <= '0';
--       s_finished_sub <= '0';
--       s_finished_re <= '0';
--       s_finished_and <= '0';
--       s_finished_rol <= '0';
--     end if;
--   end if;
-- end process p_calc;