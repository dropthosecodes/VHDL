----------------------------------------------------------------------------
----------------------------------------------------------------------------
--   32 Mbit (4Mb x 8 or 2Mb x 16) Boot Block Flash Memory VHDL Model     --
--                                                                        --
--   Type Name  : M29W320D                                                --
--                                                                        --
--   Copyright (c) 2001 STMicroelectronics                                --
--                                                                        --
----------------------------------------------------------------------------
----------------------------------------------------------------------------
--                                                                        --
--   Version History                                                      --
--   ---------------                                                      -- 
--                                                                        -- 
--   Version 1.0                                                          -- 
--   Author :  Pugliese Andrea                                            -- 
--                                                                        --
--                                                                        -- 
--   Based on Draft Release Product Preview of M29W320D Spec Datasheet    -- 
--   (June 2001) Low voltage Flash, Top or Bottom Parameter Block         -- 
--   Organization, Program Erase Controller                               --         
--   Program Erase Controller                                             --
--                                                                        --
--                                                                        --
--                                                                        -- 
--  THIS PROGRAM IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND,        --
--  EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO, THE        --
--  IMPLIED WARRANTY OF MERCHANTABILITY AND FITNESS for A PARTICULAR      --
--  PURPOSE. THE ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF         --
--  THE PROGRAM is WITH YOU. SHOULD THE PROGRAM PROVE DEFECTIVE, YOU      --
--  ASSUME THE COST OF ALL NECESSARY SERVICING, REPAIR OR CORRECTION.     --
--                                                                        --
--                                                                        --
----------------------------------------------------------------------------
--
--
-- 
-- Library import
library ieee; 
use ieee.std_logic_1164.all;
package generic_data is
  
  -- Memory characteristics and organization
  constant Addr_Bus_Dim    : natural := 21;          -- address bus dimension (2Mb x 16 mode)
  constant Data_Bus_Dim    : natural := 16;          -- data bus dimension (2Mb x 16 mode)
  constant Memory_Dim      : natural := 2**Addr_Bus_Dim - 1;     -- memory cell number
  constant CFIBlock_Dim    : natural := 100;         -- CFI memory block dimension
  type memoryArray is array (Memory_Dim downto 0) of std_logic_vector(Data_Bus_Dim - 1 downto 0);     -- Memory (2Mb x 16)
  type CFIBlock is array (CFIBlock_Dim downto 0) of std_logic_vector(Data_Bus_Dim - 1 downto 0);      -- CFI Memory Block  
  constant MainBlock_Dim   : natural := 32768;        -- main block dimension  (64Kbytes/32Kwords)
  constant SmallBlock_Dim  : natural := 16384;        -- small main block dimension (32Kbytes/16Kwords)
  constant ParamBlock_Dim  : natural := 4096;         -- parametric block dimension (8Kbytes/4Kwords)
  constant BootBlock_Dim   : natural := 8192;         -- boot block dimension (16Kbytes/8Kwords) 
  constant MainBlock_Num   : natural := 63;
  constant SmallBlock_Num  : natural := 1;
  constant ParamBlock_Num  : natural := 2;
  constant BootBlock_Num   : natural := 1;
  constant Blocks_Num      : natural := MainBlock_Num + SmallBlock_Num + ParamBlock_Num + BootBlock_Num;

  type Addr_Block_Type is array (0 to Blocks_Num - 1) of natural;          -- memory block addresses array 
    
  constant StartAddrCFI_block : natural := 16#00000#;     -- CFI block start address
  constant EndAddrCFI_block   : natural := 16#00064#;     -- CFI block end address        

  -- Memory command codes
  constant RD     : natural := 16#F0#;   -- Read Memory Array and Reset Memory op.code
  constant AS     : natural := 16#90#;   -- Auto select and Unlock Bypass Reset op.code
  constant PG     : natural := 16#A0#;   -- Program and Unlock Bypass Program op.code
  constant UB     : natural := 16#20#;   -- Unlock Bypass op.code
  constant UBR    : natural := 16#00#;   -- Unlock Bypass Reset confirm op.code
  constant EE     : natural := 16#10#;   -- Chip Erase op.code
  constant EES    : natural := 16#B0#;   -- Erase Suspend op.code
  constant EER    : natural := 16#30#;   -- Block Erase and Erase Resume op.code
  constant RCFI   : natural := 16#98#;   -- Read CFI op.code
  constant I1     : natural := 16#AA#;   -- Item1 bus write operation
  constant I2     : natural := 16#55#;   -- Item2 bus write operation
  constant I3     : natural := 16#80#;   -- Item3 bus write operation
  
  -- Memory command address 
  constant addr_1 : natural := 16#555#;   -- Address write bus operation 
  constant addr_2 : natural := 16#2AA#;   -- Address write bus operation 
  constant addr_3 : natural := 16#AAA#;   -- Address write bus operation 


  -- voltage DC characteristics 
  constant VLKO         : real := 2.3;        -- Program/Erase lockout supply voltage: worst case
  constant VID_min      : real := 11.5;       -- Identification voltage: min value
  constant VID_max      : real := 12.5;       -- Identification voltage: max value
   
  -- timing read AC Characteristics 
  constant tAXQX     : time := 0 ns;    -- address transition to output valid 
  constant tEHQX     : time := 0 ns;    -- chip enable high to output transition
  constant tELQX     : time := 0 ns;    -- chip enable low to output transition
  constant tGHQX     : time := 0 ns;    -- output enable high to output transition
  constant tGLQX     : time := 0 ns;    -- output enable low to output transition
  constant tELBL     : time := 5 ns;    -- chip enable low to byte enable low
  constant tELBH     : time := 5 ns;    -- chip enable low to byte enable high

  -- timing read AC characteristics time memory access depended 
  signal tAVAV  : time;      -- address valid to next address valid 
  signal tAVQV  : time;      -- address valid to output valid
  signal tEHQZ  : time;      -- chip enable high to output high-z
  signal tELQV  : time;      -- chip enable low to output valid
  signal tGHQZ  : time;      -- output enable high to output high-z
  signal tGLQV  : time;      -- output enable low to output valid
  signal tBLQZ  : time;      -- byte enable low to output high-z 
  signal tBHQV  : time;      -- byte enable high to output valid

  -- timing write AC characteristics write enable controlled
  constant tAVWL     : time := 0 ns;    -- address valid to Write Enable Low
  constant tELWL     : time := 0 ns;    -- chip enable low to Write Enable Low 
  constant tWHDX     : time := 0 ns;    -- Write Enable High to data transition
  constant tWHEH     : time := 0 ns;    -- Write Enable High to Chip Enable High 
  constant tWHGL     : time := 0 ns;    -- Write Enable High to Output Enable Low 
  constant tWHWL     : time := 30 ns;   -- Write Enable High to write enable low
  constant tGHWL     : time := 0 ns;    -- output enable high to write enable low
  constant tVCHEL    : time := 500 ns;  -- REAL 50 us : Vcc high to chip enable low
 
  -- timing write AC characteristics write enable controlled time memory access depended
  signal tWLWH     : time;   -- Write Enable low to write enable high
  signal tWHRL     : time;   -- write enable High to RB low 
  signal tDVWH     : time;   -- data valid to Write Enable High
  signal tWLAX     : time;   -- write enable Low to address transition
  
  -- timing write AC characteristics chip enable controlled
  constant tWLEL     : time := 0 ns;    -- write enable low to chip enable low
  constant tEHDX     : time := 0 ns;    -- chip enable high to input transition
  constant tEHWH     : time := 0 ns;    -- chip enable high to write enable high
  constant tEHEL     : time := 30 ns;   -- chip enable high to chip enable low
  constant tAVEL     : time := 0 ns;    -- address valid to chip enable low
  constant tGHEL     : time := 0 ns;    -- output enable high to chip enable low
  constant tEHGL     : time := 0 ns;    -- chip enable high to output enable low
  constant tVCHWL    : time := 500 ns;  -- REAL 50 us : Vcc high to write enable low

  -- timing write AC characteristics chip enable controlled time memory access depended
  signal tELEH     : time;     -- chip enable low to chip enable high
  signal tEHRL     : time;     -- chip enable high to RB Low
  signal tELAX     : time;     -- chip enable low to address transition
  signal tDVEH     : time;     -- data valid to Chip Enable High

  -- reset/block temporary unprotect AC characteristics
  constant tPHWL   : time := 50 ns;     -- reset high to write enable low
  constant tPHEL   : time := 50 ns;     -- reset high to chip enable low
  constant tPHGL   : time := 50 ns;     -- reset high to output enable low 
  constant tRHWL   : time := 0 ns;      -- RB high to write enable low
  constant tRHEL   : time := 0 ns;      -- RB high to chip enable low
  constant tRHGL   : time := 0 ns;      -- RB high to output enable low
  constant tPLPH   : time := 500 ns;    -- reset pulse width 
  constant tPLYH   : time := 1 us;      -- REAL 10 us : reset low to RB high
  constant tPHPHH  : time := 500 ns;    -- RP rise time to VID  
  constant tVHH    : time := 250 ns;    -- VPP/WP_N rise and fall time

  -- others timing AC characteristics
  constant Reset_time               : time := tPLYH;      -- Reset Time 
  constant ChipErase_time           : time := 40 us;      -- REAL TYPICAL VALUE: 40 s. Chip Erase time 
  constant BlockErase_time          : time := 8 us;       -- REAL TYPICAL VALUE: 0.8 s. Block Erase time  
  constant Program_time             : time := 1 us;       -- REAL TYPICAL VALUE: 10 us. Program word/byte time
  constant EEsuspend_latency        : time := 1.5 us;     -- REAL TYPICAL VALUE: 15 us. Erase suspend latency 
  constant EEabort_latency          : time := 10 us;      -- REAL TYPICAL VALUE: 100 us. Erase abort latency
  constant PGabort_latency          : time := 500 ns;     -- REAL TYPICAL VALUE: 1 us. Program abort latency  
  constant EEstart_latency          : time := 5 us;       -- REAL TYPICAL VALUE: 50 us. Erase start delay time after the last bus write op.    
  constant Back2Back_latency        : time := 15 ns;      -- Back to back reading time latency  

  -- CUI status
  type BusReadStatus_type is (ReadStatusReg, ReadArray, ReadSpecialData, ReadCFIData, ReadCFIData_AS);    -- memory bus read operation status
  type BusWriteStatus_type is (cmd_cycle1, cmd_cycle2, Unlock_BP, Unlock_BR, cmd_cycle3, 
                               cmd_cycle4, Program, cmd_cycle5, cmd_cycle6, EraseWait,
                               BypassPG, BypassPG_cycle2, BypassPG_cycle3);        -- memory bus write operation status
  -- P/E controller  status
  type Running_type is (Free, Program, BlockErase, ChipErase, EEwait, EEsuspend, Reset);  -- memory program/erase/suspend, bypass program, reset status
   
end;    -- package generic_data 

-- Library import
library ieee; 
use ieee.std_logic_1164.all;
package utility_pack is

 function char2quad_bits(c: character) return std_logic_vector;
 function slv2int(value: std_logic_vector) return integer;
 function sl2int(value: std_logic) return integer;

end; -- package utility_pack


package body utility_pack is  

  --This function converts ascii-hex character into a std_logic_vector--
  function char2quad_bits(c: character) return std_logic_vector is
     variable result : std_logic_vector(3 downto 0);
  begin
     case c is
	when '0' => result :=  "0000";
	when '1' => result :=  "0001";
	when '2' => result :=  "0010";
	when '3' => result :=  "0011";
	when '4' => result :=  "0100";
	when '5' => result :=  "0101";
	when '6' => result :=  "0110";
	when '7' => result :=  "0111";
	when '8' => result :=  "1000";
	when '9' => result :=  "1001";
	when 'A' => result :=  "1010";
	when 'B' => result :=  "1011";
	when 'C' => result :=  "1100";
	when 'D' => result :=  "1101";
	when 'E' => result :=  "1110";
	when 'F' => result :=  "1111";
	when 'a' => result :=  "1010";
	when 'b' => result :=  "1011";
	when 'c' => result :=  "1100";
	when 'd' => result :=  "1101";
	when 'e' => result :=  "1110";
	when 'f' => result :=  "1111";
	when others => result := "0000";
     end case;
   return result;
  end char2quad_bits;

  -- This function converts std_logic_vector into integer value.
  function slv2int(value: std_logic_vector) return integer is
     variable sum :      integer := 0;
  begin
    sum := 0;
    for i in value'range loop
       if value(i) = '1'  then
           sum := (sum * 2) + 1;
       elsif value(i) = '0'  then
           sum:= sum*2;
       end if;
    end loop;
    return (sum);
  end slv2int;


  --This function converts std_logic value into integer value.
  function sl2int(value: std_logic) return integer is
    variable sum : integer := 0;
      begin
        sum := 0;
        if value = '0' then
           sum:=0;
        else
           sum:=1;
        end if;
      return (sum);
  end sl2int;

end utility_pack;



-- Library import
library ieee;
use std.textio.all;
use ieee.std_logic_1164.all;
use work.generic_data.all;
use work.utility_pack.all;

-- Entity declaration
entity m29w320d is
 
  generic (
     organization     : string := "top";                       -- memory organization
     memoryfile       : string := "./memory_file";             -- memory load file location
     time_access      : time := 70 ns                          -- memory time access

  );
  
  port (
    -- supply pins
    Vcc       : in real; 
    Vss       : in real;
    -- control pins
    W_N       : in std_logic;
    E_N       : in std_logic;
    G_N       : in std_logic;
    RP_N      : in real;
    Byte_N    : in std_logic;
    RB        : out std_logic;
    -- buses
    A         : in std_logic_vector(Addr_Bus_Dim - 1 downto 0);
    DQ        : inout std_logic_vector(Data_Bus_Dim - 2 downto 0);
    -- other pins
    DQ15A_1   : inout std_logic;
    VppWP_N   : in real
  );
 
end m29w320d;

architecture behavior of m29w320d is

 
  
  -----------------------------------------
  --
  --          SIGNAL DECLARATION
  --
  -----------------------------------------
  signal Address_bus   : std_logic_vector(Addr_Bus_Dim downto 0);        -- internal address signal  (4Mb x 8) 
  signal Data_bus_in   : std_logic_vector(Data_Bus_Dim - 1 downto 0);  
  signal Data_bus_out  : std_logic_vector(Data_Bus_Dim - 1 downto 0);  
  signal RB_internal   : std_logic;
  
  signal RP_Nsig       : bit_vector(1 downto 0) := "00";
  signal WP_N          : bit := '1';
  signal Vpp_sig       : bit := '0';

  signal Vcc_sig       : bit := '0';   

  signal timeRPL       : time := 0 ns;          -- RP_Nsig Low Time
  signal timeRPH       : time := 0 ns;          -- RP_Nsig High Time
  signal timeRPVID     : time := 0 ns;          -- RP_Nsig VID time
  signal timeWL        : time := 0 ns;          -- W_N Low time
  signal timeWH        : time := 0 ns;          -- W_N High time
  signal timeEL        : time := 0 ns;          -- E_N Low time
  signal timeEH        : time := 0 ns;          -- E_N High time
  signal timeVPPL_H    : time := 0 ns;          -- VppWP_N Low/High time
  signal timeVPPVID    : time := 0 ns;          -- VppWp_N Vid time
  
  signal start         : boolean := false;      -- used to init voltage signals
  signal out_data      : boolean := false;      -- used to put out data to bus
  signal completion    : boolean := false;      -- used to simulate latency in program/erase/suspend operations 

  signal mode16bit     : boolean := false;      -- flag 16/8 bit modality

  -----------------------------------------
  --          TYPE DECLARATION
  -----------------------------------------
  type ErasingBlock_type is array (Blocks_Num - 1 downto 0) of boolean;        
  type message_err_type is (inv_erasing_addr, inv_addrSpecData, inv_addrCFIData, device_busy);
  
  type BlockProtect_type is array (Blocks_Num - 1 downto 0) of boolean;


begin
   
  -----------------------------------------
  --          ARCHITECTURE CODE
  -----------------------------------------

  
  in2out_process: process(RB_internal, Data_bus_out, mode16bit)
  begin
    if RB_internal = '1' then
       RB <= 'Z';
    else
      RB <= 'L';
    end if; 
    if mode16bit then
      DQ15A_1 <= Data_bus_out(Data_Bus_Dim - 1);   
      DQ(Data_Bus_Dim - 2 downto 0) <= Data_bus_out(Data_Bus_Dim - 2 downto 0);
    else
      DQ(Data_Bus_Dim - 2 downto 8) <= (others => 'Z');
      DQ(7 downto 0) <= Data_bus_out(7 downto 0);

      DQ15A_1 <= 'Z';

    end if; 
  end process in2out_process; 
  
  
  byte_mode_check : process(Byte_N, A, DQ, DQ15A_1) 
  begin
   if Byte_N = '1' then                       -- 2Mb x 16 
      if (Byte_N'event and E_N = '0') then
         assert (E_N'last_event >= tELBL)
         report "(Chip Enable low to Byte_N low time violation (tELBL = 5 ns)!!)" 
         severity warning; 
      end if;
      Address_bus(Addr_Bus_Dim) <= '0';
      Address_bus(Addr_Bus_Dim - 1 downto 0) <= A(Addr_Bus_Dim - 1 downto 0);
      Data_bus_in(Data_Bus_Dim - 1) <= DQ15A_1;
      Data_bus_in(Data_Bus_Dim - 2 downto 0) <= DQ (Data_Bus_Dim - 2 downto 0);
      mode16bit <= true;
   else                                       -- 4Mb x 8
      if (Byte_N'event and E_N = '0') then
         assert (E_N'last_event >= tELBH)
         report "(Chip Enable low to Byte_N high time violation (tELBH = 5 ns)!!)" 
         severity warning; 
      end if;
      Address_bus(Addr_Bus_Dim downto 1) <= A(Addr_Bus_Dim - 1 downto 0);
      Address_bus(0) <= DQ15A_1; 
      Data_bus_in(Data_Bus_Dim - 1 downto 8) <= (others => 'Z');
      Data_bus_in(7 downto 0) <= DQ (7 downto 0);
      mode16bit <= false;
   end if;
  end process byte_mode_check; 

    
  -----------------------------------
  -- ANALOG SIGNALS CHECK PROCESS
  -----------------------------------  
  analogCheck_process : process (Vcc, RP_N, VppWP_N, start)
  begin
    if (Vcc'event or start'event)   then                   
       if (Vcc >= VLKO) then  
          Vcc_sig <= '1';                              -- Vcc in valid range             
       else
          Vcc_sig <= '0';
       end if;
    end if;
    
    if (VppWP_N'event or start'event) then
       if (VppWP_N >= VID_min and RP_N <= VID_max) then
          Vpp_sig <= '1';
          WP_N <= '1'; 
          timeVPPVID <= now;  
       elsif (VppWP_N >= 0.7 * Vcc and VppWP_N <= Vcc + 0.3) then
          Vpp_sig <= '0';
          WP_N <= '1'; 
          timeVPPL_H <= now;
       else 
          Vpp_sig <= '0';
          WP_N <= '0'; 
          timeVPPL_H <= now;
       end if;
    end if;

    if (RP_N'event or start'event) then
       if (RP_N >= VID_min and RP_N <= VID_max) then
          RP_Nsig <= "10";
          timeRPVID <= now;  
       elsif (RP_N >= 0.7 * Vcc and RP_N <= Vcc + 0.3) then
          RP_Nsig <= "01";
          timeRPH <= now;
       else 
          RP_Nsig <= "00";
          timeRPL <= now;
       end if;
    end if;
  end process analogCheck_process; 


  -----------------------------------
  --   TIMING CHECK PROCESS
  -----------------------------------
  timingCheck_process : Process (Address_bus, Data_bus_out, E_N, G_N, W_N)  
    variable timeADXC : time := 0 ns;
   
  begin   
   if (now >= Reset_time) then  
     if (Address_bus'event) then 
        assert(now - timeADXC >= tAVAV)                   
        report "(Address valid to next address valid time violation (tAVAV = 70/90 ns) !!)"
        severity warning;
        
        timeADXC := now;   

        if (W_N = '1') then
          assert(now - timeWL >= tWLAX)                   
          report "(Write enable low to Address transition time violation (tWLAX = 45/50 ns) !!)"
          severity warning;
        end if;

        if (E_N = '1') then
          assert(now - timeEL >= tELAX)                   
          report "(Write enable low to Address transition time violation (tELAX = 45/50 ns) !!)"
          severity warning;
        end if;
     end if;
     
     if (Data_bus_out'event)  then 
       if (W_N = '1') then
         assert( (W_N'last_event) >= tWHDX )
         report "(Data Hold from Write Enable High time violation (tWHDX = 0 ns) !!)"
         severity warning;
       end if;

       if (E_N = '1') then
          assert( (E_N'last_event) >= tEHDX )
         report "(Data Hold from Write Enable High time violation (tEHDX = 0 ns) !!)"
         severity warning;
       end if;
     end if;
       
     if (G_N'event and G_N = '0') then
       if (E_N = '1') then 
          assert (E_N'last_event >= tEHGL)
          report "(Chip enable high to output enable low Violation (tEHGL = 0 ns) !!)"
          severity warning;
       end if;
       
       if (W_N = '1') then
          assert (W_N'last_event >= tWHGL)
          report "(Write enable high to output enable low Violation (tWHGL = 0 ns) !!)"
          severity warning; 
       end if; 

       if (RP_Nsig = "01" and (timeRPH - timeRPL) >= tPLPH) then     
          assert (RP_Nsig'last_event >= tPHGL)
          report "(Reset High to output enable Low Time Violation (tPHGL = 50 ns) !!)"
          severity warning;
       end if;
       
       if (RB_internal = '1') then
          assert (RB_internal'last_event >= tRHGL)
          report "(RB High to Write Enable Low Time Violation (tRHGL = 0 ns) !!)"
          severity warning;
       end if;          
     end if; 
               
     if (W_N'Event) then 
       if (W_N = '0') then
         timeWL <= now;
  
         assert (now - timeWH >= tWHWL)
         report "(Write Enable high to write enable low time violation (tWHWL = 30 ns) !!)"
         severity warning;
            
         if (E_N = '0') then  
           assert (E_N'last_event >= tELWL)
           report "(Chip enable Low to Write Enable Low Time Violation (tELWL = 0 ns) !!)"
           severity warning;
         end if;
         
         assert ((Address_bus'last_event) >= tAVWL)
         report "(Setup time address transaction time violation (tAVWL = 0 ns) !!)"
         severity warning;
         
         if (G_N = '1') then
           assert (G_N'last_event >= tGHWL)
           report "(Output enable high to Write enable Low Time Violation (tGHWL = 0 ns) !!)"
           severity warning;
         end if;
         
         if (RP_Nsig = "01" and (timeRPH - timeRPL) >= tPLPH) then     
            assert (RP_Nsig'last_event >= tPHWL)
            report "(Reset High to Write Enable Low Time Violation (tPHWL = 50 ns) !!)"
            severity warning;
          end if;
         
         if (RB_internal = '1') then
            assert (RB_internal'last_event >= tRHWL)
            report "(RB High to Write Enable Low Time Violation (tRHWL = 0 ns) !!)"
            severity warning;
         end if;          

       else 
         timeWH <= now;
         
         assert (now - timeWL >= tWLWH)
         report "(Write Enable low to write enable high time violation (tWLWH = 45/50 ns) !!)"
         severity warning;
           
         if (E_N = '1') then   
           assert ((E_N'last_event)>= tEHWH)
           report "(Chip enable high to write enable High time violation (tEHWH = 0 ns) !!)"
           severity warning;
         end if; 
            
         assert ((Data_bus_out'last_event) >= tDVWH)
         report "(Setup time data transaction time violation (tDVWH = 45/50 ns) !!)"
         severity warning;

         end if; 

          if (Vcc_sig = '1') then
              assert (Vcc_sig'last_event >= tVCHWL)
              report "(Vcc high to chip enable low Time Violation (tVCHWL = 500 ns (real value 50 us)) !!)"
              severity warning;
            end if;
      end if;

      if (E_N'Event) then 
         if (E_N ='0') then
            timeEL <= now;
            
            assert ((Address_bus'last_event) >= tAVEL)
            report "(Setup time address transaction time violation (tAVEL = 0 ns) !!)"
            severity warning;
            
            if (W_N ='0') then  
              assert (W_N'last_event >= tWLEL)
              report "(Write  Enable Low to Chip Enable High Time  Violation (tWLEL = 0 ns) !!)"
              severity warning;
            end if;

            assert (now - timeEH >= tEHEL)
            report "(Chip enable pulse width H -> L time violation (tEHEL = 30 ns) !!)"
            severity warning;
           
            if (G_N = '1') then
              assert (G_N'last_event >= tGHEL)
              report "(Output Enable high to Chip Enable low Time  Violation (tGHEL = 0 ns) !!)"
              severity warning;
            end if;
            
            if (Vcc_sig = '1') then
              assert (Vcc_sig'last_event >= tVCHEL)
              report "(Vcc high to chip enable low Time Violation (tVCHEL = 500 ns (real value 50 us)) !!)"
              severity warning;
            end if;
            
            if (RP_Nsig = "01" and (timeRPH - timeRPL) >= tPLPH) then     
              assert (RP_Nsig'last_event >= tPHEL)
              report "(Reset High to Write Enable Low Time Violation (tPHEL = 50 ns) !!)"
              severity warning;
            end if;

            if (RB_internal = '1') then
              assert (RB_internal'last_event >= tRHEL)
              report "(RB High to Write Enable Low Time Violation (tRHEL = 0 ns) !!)"
              severity warning;
            end if;          
         else 
            timeEH <= now;
            
            assert ((Data_bus_out'last_event) >= tDVEH)
            report "(Setup time data transaction violation (tDVEH = 45/50 ns) !!)"
            severity warning;
            
            assert (now - timeEL >= tELEH)
            report "(Chip enable pulse width L -> H Time Violation (tELEH = 45/50 ns) !!)"
            severity warning;
             
            if (W_N = '1') then  
              assert (W_N'last_event >= tWHEH)
              report "(Write Enable high to chip enable high Time Violation (tWHEH = 0 ns) !!)"
              severity warning;
            end if;
          
         end if; 
      end if;
   end if;        

  end process;
     
  
  ---------------------------
  --      MAIN PROCESS
  ---------------------------
  main : process (Address_bus, Data_bus_in, RP_Nsig, Vcc_sig, WP_N, Vpp_sig, W_N, E_N, G_N, Byte_N, out_data, completion)
  ---------------------------
  --main process declarations
  --------------------------- 
    variable memory       : memoryArray;                             -- The Memory
    variable QueryTable   : CFIBlock;                                -- CFI Block
    variable Write_status : BusWriteStatus_type := cmd_cycle1;       -- CUI bus write state variable
    variable Read_status  : BusReadStatus_type  := ReadArray;        -- CUI read state variable  
    variable Running      : Running_type        := Free;             -- P/E controller state variable 
    variable init         : boolean             := false;            -- flag memory init

    variable StartBlock_addr  : Addr_Block_Type;         -- First block addresses      
    variable EndBlock_addr    : Addr_Block_Type;         -- Last block addresses
    
    variable num_block        : natural := 0;            -- Current block addresses  
    variable ErasingBlock     : ErasingBlock_type;       -- Erasing block addresses flags 
    variable currBlock_protect: boolean := false;        -- Current block protection status    

    variable boot_block_num   : natural := 0;           -- boot 16k memory block 
       
    
    variable outdata_flag_err : boolean  := false;      -- used to display assert message when an error occurs
   
    variable timeEES      : time := 0 ns;               -- Block Erase time before Erase suspend   
    variable timeEE       : time := 0 ns;               -- Block Erase operation start time 
    variable timePG       : time := 0 ns;               -- Program word/byte operation start time
    variable timeRST      : time := 0 ns;               -- Reset start time   
 
    variable command      : integer := 0;                                 -- command Code    
    variable cmd_addr     : integer := 0;                                 -- command Address 
    variable address      : integer := 0;                                 -- current address 
    variable hold_addr    : std_logic_vector(Addr_Bus_Dim downto 0);      -- latched address (4Mb x 8) 
    variable hold_data    : std_logic_vector(Data_Bus_Dim - 1 downto 0);  -- latched data
   
    variable SR              : std_logic_vector(7 downto 0) := (others => '0');        -- Status Register 
    variable ManufCode_reg   : std_logic_vector(Data_Bus_Dim - 1 downto 0) := "0000000000100000";  -- Manufacturer code reg 0020H 
    variable DevCodeTop_reg  : std_logic_vector(Data_Bus_Dim - 1 downto 0) := "0010001011001010";  -- Device Code top reg 22CAH
    variable DevCodeBot_reg  : std_logic_vector(Data_Bus_Dim - 1 downto 0) := "0010001011001011";  -- Device Code bottom reg 22CBH
    
    variable Block_Protect : BlockProtect_type;         -- Block Protection Status flag         
         

    variable message_err :  message_err_type;
    
    variable EE_susp     : boolean  := false;           -- block erase suspend
    variable EE_1stBlock : boolean  := true;            -- block erase first cycle 
   
    variable EEabort_flag : boolean := false; 

    variable BypassPG_fromCUI : boolean := false;
   
  ---------------------------
  --main process procedures
  --------------------------- 
 -- CFI Memory Block Init Procedure
  procedure CFIBlock_proc is
  begin
     for i in 0 to CFIBlock_Dim loop
        QueryTable(i) := (others => '0');  
     end loop;
     QueryTable(16#10#) := "0000000001010001"; 	-- "Q"
     QueryTable(16#11#) := "0000000001010010"; 	-- "R"
     QueryTable(16#12#) := "0000000001011001"; 	-- "Y"
     QueryTable(16#13#) := "0000000000000010";
     QueryTable(16#14#) := "0000000000000000";
     QueryTable(16#15#) := "0000000001000000"; 	--   = location of
     QueryTable(16#16#) := "0000000000000000"; 	--   extended qry table
     QueryTable(16#17#) := "0000000000000000";
     QueryTable(16#18#) := "0000000000000000";
     QueryTable(16#19#) := "0000000000000000";
     QueryTable(16#1A#) := "0000000000000000";
     QueryTable(16#1B#) := "0000000000100111"; 	-- Vcc Min Write/Erase Voltage
     QueryTable(16#1C#) := "0000000000110110"; 	-- Vcc Max Write/Erase Voltage
     QueryTable(16#1D#) := "0000000010110101"; 	-- Vpp Min Write/Erase Voltage
     QueryTable(16#1E#) := "0000000011000101"; 	-- Vpp Max Write/Erase Voltage
     QueryTable(16#1F#) := "0000000000000100";
     QueryTable(16#20#) := "0000000000000000";
     QueryTable(16#21#) := "0000000000001010";
     QueryTable(16#22#) := "0000000000000000";
     QueryTable(16#23#) := "0000000000000101";
     QueryTable(16#24#) := "0000000000000000";
     QueryTable(16#25#) := "0000000000000100";
     QueryTable(16#26#) := "0000000000000000";
     QueryTable(16#27#) := "0000000000010110"; 	
     QueryTable(16#28#) := "0000000000000010"; 	
     QueryTable(16#29#) := "0000000000000000";
     QueryTable(16#2A#) := "0000000000000000"; 
     QueryTable(16#2B#) := "0000000000000000"; 
     QueryTable(16#2C#) := "0000000000000100"; 
     QueryTable(16#2D#) := "0000000000000000"; 	
     QueryTable(16#2E#) := "0000000000000000"; 
     QueryTable(16#2F#) := "0000000000000100"; 	
     QueryTable(16#30#) := "0000000000000000"; 	
     QueryTable(16#31#) := "0000000000000001";
     QueryTable(16#32#) := "0000000000000000";
     QueryTable(16#33#) := "0000000000000010";
     QueryTable(16#34#) := "0000000000000000";
     QueryTable(16#35#) := "0000000000000000";
     QueryTable(16#36#) := "0000000000000000";
     QueryTable(16#37#) := "0000000000001000";
     QueryTable(16#38#) := "0000000000000000";
     QueryTable(16#39#) := "0000000000111110";
     QueryTable(16#3A#) := "0000000000000000";
     QueryTable(16#3B#) := "0000000000000000";
     QueryTable(16#3C#) := "0000000000000001";
     QueryTable(16#40#) := "0000000001010000";
     QueryTable(16#41#) := "0000000001010010";
     QueryTable(16#42#) := "0000000001001001";
     QueryTable(16#43#) := "0000000000110001";
     QueryTable(16#44#) := "0000000000110000";
     QueryTable(16#45#) := "0000000000000000";
     QueryTable(16#46#) := "0000000000000010";
     QueryTable(16#47#) := "0000000000000100";
     QueryTable(16#48#) := "0000000000000001";
     QueryTable(16#49#) := "0000000000000100"; 
     QueryTable(16#4A#) := "0000000000000000";
     QueryTable(16#4B#) := "0000000000000000";
     QueryTable(16#4C#) := "0000000000000000";
     QueryTable(16#4D#) := "0000000010110101";
     QueryTable(16#4E#) := "0000000011000101";
     if organization = "top" then 
        QueryTable(16#4F#) := "0000000000000011";
     elsif organization = "bottom" then
        QueryTable(16#4F#) := "0000000000000010";
     end if; 
  end CFIBlock_proc;
 
  -- Block Protection Init Procedure
  procedure blockProtect_proc (protect : boolean) is
  begin
     for i in 0 to Blocks_Num - 1 loop
       Block_Protect(i) := protect;   
     end loop;
  end blockProtect_proc;

  -- procedure for memory init
  procedure init_proc is 
 
    file memory_file : text is in memoryfile;
    variable l       : line;
    variable char1, char2, char3, char4, char5, char6, char7  : character;
    variable address : integer;
    variable data    : std_logic_vector(Data_Bus_Dim - 1 downto 0);  
    variable addr_offset : natural;
    variable block_offset : natural;

  begin
    -- timing values setting
    if (time_access = 70 ns) then
       tAVAV <= 70 ns; 
       tAVQV <= 70 ns;
       tEHQZ <= 25 ns;
       tELQV <= 70 ns;
       tGHQZ <= 25 ns;
       tGLQV <= 30 ns;
       tBLQZ <= 25 ns; 
       tBHQV <= 30 ns;
       tWLWH <= 45 ns;
       tWHRL <= 30 ns;
       tELEH <= 45 ns;
       tEHRL <= 30 ns;  
       tDVWH <= 45 ns;
       tWLAX <= 45 ns; 
       tDVEH <= 45 ns;
       tELAX <= 45 ns;
    elsif (time_access = 90 ns) then
       tAVAV <= 90 ns; 
       tAVQV <= 90 ns;
       tEHQZ <= 30 ns;
       tELQV <= 90 ns;
       tGHQZ <= 30 ns;
       tGLQV <= 35 ns;
       tBLQZ <= 30 ns; 
       tBHQV <= 40 ns;
       tWLWH <= 50 ns;
       tWHRL <= 35 ns;
       tELEH <= 50 ns;
       tEHRL <= 35 ns;  
       tDVWH <= 50 ns;  
       tWLAX <= 50 ns; 
       tDVEH <= 50 ns; 
       tELAX <= 50 ns;
    else
      assert (0>1)
      report "(Error: Invalid memory access time !!!)"
      severity error;
    end if;

    -- setup memory block locations
    if organization = "top" then
       for i in 0 to MainBlock_Num - 1 loop                                   -- main blocks 
          StartBlock_addr(i) := MainBlock_Dim * i;
          EndBlock_addr(i) := StartBlock_addr(i) + MainBlock_Dim - 1;  
       end loop;
       addr_offset := MainBlock_Dim * MainBlock_Num;
       block_offset := MainBlock_Num;
       for i in block_offset to block_offset + SmallBlock_Num - 1 loop        -- small main blocks 
          StartBlock_addr(i) := addr_offset + SmallBlock_Dim * (i - block_offset);
          EndBlock_addr(i) := StartBlock_addr(i) + SmallBlock_Dim - 1;
       end loop;
       addr_offset := addr_offset + SmallBlock_Dim * SmallBlock_Num;
       block_offset := block_offset + SmallBlock_Num;
       for i in block_offset to block_offset + ParamBlock_Num - 1 loop        -- parametric blocks
          StartBlock_addr(i) := addr_offset + ParamBlock_Dim * (i - block_offset);
          EndBlock_addr(i) := StartBlock_addr(i) + ParamBlock_Dim - 1;
       end loop;   
       addr_offset := addr_offset + ParamBlock_Dim * ParamBlock_Num;
       block_offset := block_offset + ParamBlock_Num;
       for i in block_offset to block_offset + BootBlock_Num - 1 loop         -- boot blocks
          StartBlock_addr(i) := addr_offset + BootBlock_Dim * (i - block_offset);
          EndBlock_addr(i) := StartBlock_addr(i) + BootBlock_Dim - 1;
       end loop;  

       boot_block_num :=  Blocks_Num - 1;

    elsif organization = "bottom" then
       for i in 0 to BootBlock_Num - 1 loop                                   -- boot blocks 
          StartBlock_addr(i) := BootBlock_Dim * i;
          EndBlock_addr(i) := StartBlock_addr(i) + BootBlock_Dim - 1;  
       end loop;
       addr_offset := BootBlock_Dim * BootBlock_Num;
       block_offset := BootBlock_Num;
       for i in block_offset to block_offset + ParamBlock_Num - 1 loop        -- parametric blocks 
          StartBlock_addr(i) := addr_offset + ParamBlock_Dim * (i - block_offset);
          EndBlock_addr(i) := StartBlock_addr(i) + ParamBlock_Dim - 1;
       end loop;
       addr_offset := addr_offset + ParamBlock_Dim * ParamBlock_Num;
       block_offset := block_offset + ParamBlock_Num;
       for i in block_offset to block_offset + SmallBlock_Num - 1 loop        -- small main blocks
          StartBlock_addr(i) := addr_offset + SmallBlock_Dim * (i - block_offset);
          EndBlock_addr(i) := StartBlock_addr(i) + SmallBlock_Dim - 1;
       end loop;   
       addr_offset := addr_offset + SmallBlock_Dim * SmallBlock_Num;
       block_offset := block_offset + SmallBlock_Num;
       for i in block_offset to block_offset + MainBlock_Num - 1 loop         -- main blocks
          StartBlock_addr(i) := addr_offset + MainBlock_Dim * (i - block_offset);
          EndBlock_addr(i) := StartBlock_addr(i) + MainBlock_Dim - 1;
       end loop;  
        
       boot_block_num :=  0; 
        
    else 
       assert (0>1)
       report "(Error: Invalid memory organization !!!)"
       severity error;
    end if; 

    -- memory erase
    for i in 0 to Memory_Dim loop
      memory(i) := (others => '1');
    end loop;
   
    -- memory loading with external file--
    if (memoryfile/="") then              
     while not endfile (memory_file) loop
       readline  (memory_file,l);
       read (l, char1); read (l, char2); read (l, char3); read (l, char4); read (l, char5); read (l, char6); read (l, char7);
       address := 1048576*slv2int(char2quad_bits(char1)) + 
                    65536*slv2int(char2quad_bits(char2)) + 
                     4096*slv2int(char2quad_bits(char3)) + 
                      256*slv2int(char2quad_bits(char4)) +
                       16*slv2int(char2quad_bits(char5)) +
                          slv2int(char2quad_bits(char6));
       read (l, char1); read (l, char2); read (l, char3); read (l, char4); 
       data := (char2quad_bits(char1))&(char2quad_bits(char2))&(char2quad_bits(char3))&(char2quad_bits(char4));
       memory(address) := data;   
      end loop;
    end if;
   
    -- CFI Block Init
    CFIBlock_proc;
    
    for i in 0 to Blocks_Num - 1 loop
      ErasingBlock(i) := false;
    end loop;

    -- Block Protection Init 
--    blockProtect_proc(false);
    blockProtect_proc(true);


    outdata_flag_err := true;
    EE_susp := false;
    EE_1stBlock := true;
   

    -- internal signal init 
    Data_bus_out <= (others => 'Z');
    RB_internal <= '0';            -- memory busy
    Running := Reset;
    completion <= not completion after Reset_time;

 
  end init_proc;      -- procedure init_proc 

  procedure bad_command is

  begin   
    assert (0>1)
    report "(Invalid command sequence, device busy, bypass modality set or unset or P/E Controller error!)"
    severity warning;
     
    if (Write_status /= BypassPG and Write_status /= BypassPG_cycle2 and  Write_status /= BypassPG_cycle3) then 
      Write_status := cmd_cycle1;
    else 
      Write_status := BypassPG;
    end if;

  end bad_command;
 
  -- Memory Read op. procedure    
  procedure Data2DQ is 
    variable time_end : time;
                 
  begin
  
    time_end := tGLQV - G_N'last_event; 
    if (time_end < tAVQV - Address_bus'last_event) then  time_end := tAVQV - Address_bus'last_event; end if;
    if (time_end < tELQV - E_N'last_event) then  time_end := tELQV - E_N'last_event; end if;
    
    -- last event of Byte_N is H -> L or L -> H
    if (time_end < tBHQV - Byte_N'last_event) then time_end := tBHQV - Byte_N'last_event; end if;  
   
    -- last event of W_N is L -> H
    if (W_N'last_event - G_N'last_event < Back2Back_latency) then
       time_end := time_end + Back2Back_latency - (W_N'last_event - G_N'last_event);
    end if;  

    if (time_end < 0 ns) then time_end := 0 ns; end if; 
    
    out_data <= not out_data after time_end;

  end Data2DQ;

  

  -- Number block addresses calculation 
  procedure find_block (value : integer) is 
  begin
   
   for i in 0 to Blocks_Num - 1 loop 
     if (StartBlock_addr(i) <= value and value <= EndBlock_addr(i)) then
        num_block := i;
        
     end if;
   end loop;
  end find_block;  

  
  procedure NextWriteCycle is
    variable next_status      : BusWriteStatus_type; 
    variable command_address  : natural;
  begin
     case Write_status is
        when cmd_cycle1 => 
             next_status := cmd_cycle2;
             if (mode16bit) then  command_address := addr_1;
             else command_address := addr_3;
             end if;
        when cmd_cycle2 =>  
             next_status := cmd_cycle3;
             if (mode16bit) then  command_address := addr_2;
             else command_address := addr_1;
             end if;
        when cmd_cycle3 =>  
             next_status := cmd_cycle4;
             if (mode16bit) then  command_address := addr_1;
             else command_address := addr_3;
             end if;
        when cmd_cycle4 =>  
             next_status := cmd_cycle5;
             if (mode16bit) then command_address := addr_1; 
             else command_address := addr_3;
             end if;
        when cmd_cycle5 => 
             next_status := cmd_cycle6; 
             if (mode16bit) then command_address := addr_2; 
             else command_address := addr_1;
             end if;
        when others =>
             command_address := 0; 
     end case;    

     if (cmd_addr /= command_address) then 
        assert (0>1)
        report "(Invalid address during bus write operation!)"
        severity warning; 
        Write_status := cmd_cycle1; 
     else
        Write_status := next_status;
     end if;    
  end NextWriteCycle;


  -- Program Operation Procedure  
  procedure Pgm_proc is
  begin
      
   timePG := now;
   find_block(address);
   
   currBlock_protect := (Block_Protect(num_block) and RP_Nsig /= "10") or (num_block = boot_block_num and WP_N = '0');   

   Read_status := ReadStatusReg; 
   -- Status Register Management
   SR(7) := not hold_data(7); 
   SR(2) := '0'; 
   RB_internal <= '0' after tWHRL;  -- tEHRL busy  
   Running := Program;
   
   if (EE_susp and ErasingBlock(num_block) ) then 
      assert (0>1)
      report "(Invalid Address: It is not possible to program cells in Erasing Block addresses!)"
      severity warning;
      completion <= not(completion) after PGabort_latency;
   elsif currBlock_protect then      -- check block protection 
      assert (0>1)
      report "(Invalid address: this block is write protected!)"
      severity note;  
      completion <= not(completion) after PGabort_latency;
   else -- program operation maybe possible
      Running := Program;
      
      if mode16bit then
         if ( (memory(address) and  hold_data) /= hold_data ) then
            assert (0>1)
            report "(Attention! The memory location addressed is not empty. This operation is not allowed!!)"
            severity warning;
            SR(5) := '1';         -- program fail
         else
            -- CELL PROGRAM 
            memory(address) := memory(address) and hold_data;  
            completion <= not(completion) after Program_time;
         end if; 
      else
        if (hold_addr(0) = '0') then
           if ( (memory(address)(7 downto 0) and hold_data(7 downto 0)) /= hold_data(7 downto 0) ) then
              assert (0>1)
              report "(Attention! The memory location addressed is not empty. This operation is not allowed!!)"
              severity warning;
              SR(5) := '1';         -- program fail
           else
              -- CELL PROGRAM 
              memory(address)(7 downto 0) := memory(address)(7 downto 0) and hold_data(7 downto 0);
              completion <= not(completion) after Program_time;
           end if;
        else
           if ((memory(address)(Data_Bus_Dim - 1 downto 8) and hold_data(7 downto 0)) /= hold_data(7 downto 0) ) then
              assert (0>1)
              report "(Attention! The memory location addressed is not empty. This operation is not allowed!!)"
              severity warning;
              SR(5) := '1';         -- program fail
           else
              -- CELL PROGRAM 
              memory(address)(Data_Bus_Dim - 1 downto 8) := memory(address)(Data_Bus_Dim - 1 downto 8) and hold_data(7 downto 0);
              completion <= not(completion) after Program_time;       
           end if; 
        end if;
      end if;
   end if;
                      
  end Pgm_proc; 


  -- Block Erase Procedure
  procedure BlkEE_proc(nblock : integer) is
  begin
    for i in StartBlock_addr(nblock) to EndBlock_addr(nblock) loop      -- Block Erase op. 
       memory(i) := (others => '1'); 
    end loop;
  end BlkEE_proc;
 
 
  procedure Reset_proc is
  begin 
     Running := Reset;
     SR := (others => '0');
     outdata_flag_err := true;
     EE_1stBlock := true;
     Data_bus_out <= (others => 'Z');
     RB_internal <= '0';            -- memory busy
     timeRST := now;
  end Reset_proc; 
 
 
  -- Read/Reset procedure
  procedure RDRS_proc is 
  begin 
    
    outdata_flag_err := true; 
    if (Running = Free or SR(5) = '1') then
      if SR(5) = '1' then                -- After a programming or erase error
        Reset_proc;  
        Running := Free;
        completion <= not completion;
      end if;
      if (Read_status = ReadCFIData_AS) then
         Read_status := ReadSpecialData;
      else
         Read_status := ReadArray;
         SR(5) := '0';
         if (Vpp_sig = '1' and Running = Free) then Write_status := BypassPG; 
         end if;
      end if;
    else bad_command;     -- Program, ChipErase, Reset
    end if;
  end RDRS_proc;
  

  -- CFI Block Read procedure
  procedure readCFIData_proc is
  begin
    if (address <= EndAddrCFI_block and address >= StartAddrCFI_block)  then  
       outdata_flag_err := false;
       hold_data := QueryTable(address);
    else   -- invalid address
       hold_data := (others => 'X');
       message_err := inv_addrCFIData;  
    end if;
   
    Data2DQ;   -- out data
  end readCFIData_proc;

  -- Auto Select Read procedure
  procedure readAutoSelect_proc is
     variable addrInput  : std_logic_vector(1 downto 0);   
  begin  
        
     if (mode16bit) then addrInput := hold_addr(1 downto 0);
     else addrInput := hold_addr(2 downto 1);
     end if; 
                

     if (addrInput = "10") then      -- Block Protection Status read
         outdata_flag_err := false;
         find_block(address);
         
         currBlock_protect := (Block_Protect(num_block) and RP_Nsig /= "10") or (num_block = boot_block_num and WP_N = '0');   
        
         hold_data(Data_Bus_Dim - 1 downto 8) := (others => '1');
         if currBlock_protect then 
              hold_data(7 downto 0) := "00000001";
         else hold_data(7 downto 0) := (others => '0');
         end if;
      elsif (addrInput = "00") then   -- Manufacturer Code read
         outdata_flag_err := false;
         hold_data := ManufCode_reg;
      elsif (addrInput = "01") then   -- Device Code read
         outdata_flag_err := false;
         if organization = "top" then
            hold_data := DevCodeTop_reg;
         else 
            hold_data := DevCodeBot_reg;
         end if; 
      else   -- invalid address
         message_err := inv_addrSpecData; 
         hold_data := (others => 'X'); 
      end if; 
                
      Data2DQ;   -- out data
  end readAutoSelect_proc;
  

  ---------------------------
  --   main process code
  ---------------------------
  begin
     -- memory init
     if (not init) then
        init_proc;  
        init := not init;  
        start <= not start; -- after Reset_time;
     end if;       
     
      
     if (now >= Reset_time) then 
        if (Vcc_sig'event) then
          if Vcc_sig = '1' then
            Running := Free;
            if (Vpp_sig = '0' or SR(5) = '1') then Write_status := cmd_cycle1; 
            else Write_status := BypassPG;
            end if;
            Read_status  := ReadArray;
            SR := (others => '0');
            RB_internal <= '1';
          else
            Running := Reset;
            Reset_proc;
            EE_susp := false; 
            assert (0>1)
            report "(Vcc out of range. All operations will be aborted !!)" 
            severity warning;
            completion <= not completion;  
          end if;  
        end if;

        if (Address_bus'event)  then 
           if (E_N = '0' and G_N = '0') then 
              Data_bus_out <= (others => 'X') after tAXQX;
           end if;
           
           -- error flag reset
           outdata_flag_err := true;      
           
           -- Address latching during bus read op. 
           if (E_N = '0' and G_N = '0' and W_N = '1') then
             -- Address latch
             hold_addr := Address_bus;
             if mode16bit then address := slv2int(hold_addr);
             else address := slv2int(hold_addr(Addr_bus_dim downto 1));
             end if;
             find_block(address);
           end if;           
 
        end if;
  
        -- Address latching during bus write op.
        if (E_N'event and E_N = '0') then
           if (G_N = '1' and W_N = '0') then
             -- Address latch
             hold_addr := Address_bus;
             if mode16bit then address := slv2int(hold_addr);
             else address := slv2int(hold_addr(Addr_bus_dim downto 1));
             end if;
             find_block(address);  
           end if; 
        end if;

        -- Address latching during bus write op.
        if (W_N'event and W_N = '0') then
           if (G_N = '1' and E_N = '0') then
             -- Address latch
             hold_addr := Address_bus;
             if mode16bit then address := slv2int(hold_addr);
             else address := slv2int(hold_addr(Addr_bus_dim downto 1));
             end if;
             find_block(address);  
           end if; 
        end if;
 
        if (E_N'Event and G_N = '0') then  
          if (E_N = '0') then
             Data_bus_out <= (others => 'X') after tELQX;
          else 
             Data_bus_out <= (others => 'X') after tEHQX, (others => 'Z') after (tEHQZ - tEHQX);
          end if;
        end if;

        if (G_N'Event and E_N = '0') then 
          if (G_N = '0') then
             -- error flag reset
             outdata_flag_err := true;      
             Data_bus_out <= (others => 'X') after tGLQX; 
          else 
             Data_bus_out <= (others => 'X') after tGHQX, (others => 'Z') after (tGHQZ - tGHQX);
          end if;
        end if;

        if (Byte_N'event and E_N = '0' and G_N = '0') then
           Data_bus_out <= (others => 'Z') after tBLQZ; 
        end if;      
        
        if (Vpp_sig'event) then
           if (Vpp_sig = '0') then
             
             if not (Read_status = ReadArray and Running = Free and SR(5) = '0') then
                assert (0>1)
                report "(Attention!! The memory is not free! The device may become unreliable!!)"
                severity warning;
             elsif not BypassPG_fromCUI then
                Write_status := cmd_cycle1;  
             end if;        
             
             if Running = Program and SR(5) = '0' then
                assert (0>1)
                report "(Attention! The Program operation will be aborted!)"
                severity warning; 

                SR(5) := '1';         -- program fail
                Write_status := cmd_cycle1;    
                completion <= not completion;    
             end if;
   
           else                                              -- FAST PROGRAM
             assert (timeVPPVID - timeVPPL_H >= tVHH)
             report "(VppWP_N Rise time to VID violation (tVHH = 250 ns) !!)"
             severity warning;         
             
             if not (Read_status = ReadArray and Running = Free and SR(5) = '0') then 
               assert (0>1)
               report "(Attention!! The memory is not free! The device may become unreliable!!)"
               severity warning;
             elsif (Write_status = BypassPG) then
               BypassPG_fromCUI := true;
             else
               BypassPG_fromCUI := false;
               Write_status := BypassPG;
             end if;
              
           end if;
        end if; 
  
     end if;


     ------------------------------
     --   Reset signal check
     ------------------------------
     if (RP_Nsig'event) then
       if RP_Nsig = "10" then         -- SPECIAL BUS OPERATION: block unprotection
          assert (timeRPVID - timeRPH >= tPHPHH)
          report "(RP Rise time to VID violation (tPHPHH = 500 ns) !!)"
          severity warning;              
          
          
          assert (0>1)
          report "(Attention! All protected blocks are temporary unprotect (16Kb boot block is protected if VppWP_N is low)!!)"
          severity note;              

       elsif RP_Nsig = "00" then      -- MEMORY STANDBY/OUTPUT DISABLE   
          Data_bus_out <= (others => 'Z');
       elsif RP_Nsig = "01" then      -- READ MODE
          if ((timeRPH - timeRPL) >= tPLPH) then   -- reset threshold
             Reset_proc;
             EE_susp := false;
             assert (0>1)
             report "(Hardware Reset. All operations will be aborted !!)" 
             severity warning;
             completion <= not completion;
          end if; 
       end if;
     end if;     


     ------------------------------
     --        CUI code
     ------------------------------
     
     if ((RP_Nsig = "01" or RP_Nsig = "10") and now >= Reset_time and Vcc_sig = '1') then    -- MEMORY READY STATE  
        
        if ( (E_N = '0' and W_N = '1' and (G_N = '0' and not(out_data'event))) or 
             (E_N = '0' and W_N = '1' and (G_N'event and G_N = '0')) )             then        -- MEMORY READ CYCLE
           
           hold_addr := Address_bus;
           if mode16bit then address := slv2int(hold_addr);
           else address := slv2int(hold_addr(Addr_bus_dim downto 1));       
           end if;       
   
           -- Bus read operation case structure
           case Read_status is
              when ReadStatusReg     =>     -- Memory Status Register Read op.
                   
                   outdata_flag_err := false;
                   hold_data(Data_Bus_Dim - 1 downto 8) := (others => '1');
                   hold_data(7 downto 0)  := SR;
                   
                   -- Status Register update
                   if (G_N'event and G_N = '0') then
                     find_block(address);
                     currBlock_protect := (Block_Protect(num_block) and RP_Nsig /= "10") or (num_block = boot_block_num and WP_N = '0');   
                    
                     -- Bit 6 - Bit 2 toggling
                     case Running is
                       when Program => 
                          SR(6) := not SR(6); 
                       when ChipErase =>
                          SR(6) := not SR(6); 
                          if (not currBlock_protect) then 
                             SR(2) := not SR(2);  
                          end if;
                       when EEwait =>
                          if (ErasingBlock(num_block) and not currBlock_protect) then SR(2) := not SR(2);  
                          end if;
                          SR(6) := not SR(6);
                       when BlockErase =>
                          if (ErasingBlock(num_block) and not currBlock_protect) then SR(2) := not SR(2);  
                          end if;
                          SR(6) := not SR(6);
                       when EEsuspend =>
                          if (ErasingBlock(num_block) and not currBlock_protect) then SR(2) := not SR(2);  
                          end if;
                          SR(6) := not SR(6);
                       when Free =>
                          if (EE_susp and ErasingBlock(num_block))  then      -- Read op. during an Erase Suspend  
                            SR(7) := '1';
                            SR(2) := not SR(2);   
                          end if;
                       when others =>
                     end case;     
                     if (SR(5) = '1' and SR(3) = '1') then              
                        if currBlock_protect  then SR(2) := not SR(2);
                        end if;
                        SR(7) := '0';
                        SR(6) := not SR(6);
                     end if;
              
                   end if;
                
                   Data2DQ;     -- out data

              when ReadArray         =>     -- Memory Read Array op.
                 if (Running = Free and hold_addr(9) = 'H' and mode16bit) or
                    (Running = Free and hold_addr(10) = 'H' and not mode16bit)  then
                     readAutoSelect_proc;   -- AutoSelect modality A9 = VID
                 else
                   if (Running = Free) then 
                     find_block(address);
                      -- memory read op always possible
                     if (EE_susp and ErasingBlock(num_block) )  then      -- Read op. during an Erase Suspend 
                        message_err := inv_erasing_addr;
                        -- read status register
                        if (G_N'event and G_N = '0') then
                          SR(7) := '1';
                          SR(2) := not SR(2); 
                          SR(3) := '1'; 
                        end if;
  
                        hold_data(7 downto 0)  := SR;
                     else    
                        outdata_flag_err := false;
                        if mode16bit then
                           hold_data := memory(address); 
                        else
                           hold_data(Data_bus_dim - 1 downto 8) := (others => '1');
                           if (hold_addr(0) = '0') then
                             hold_data(7 downto 0) := memory(address)(7 downto 0);
                           else
                             hold_data(7 downto 0) := memory(address)(Data_bus_dim - 1 downto 8);
                           end if;
                        end if;
                     end if;
                   else
                     hold_data := (others => 'X');
                     message_err := device_busy;
                   end if;
                         
                   Data2DQ;   -- out data
                 end if;
   
              when ReadSpecialData   =>     -- Memory Special Bus Read op.
                      readAutoSelect_proc;
              when ReadCFIData       =>     -- Memory Security Data Read op. 
                   if (hold_addr(9) = 'H' and mode16bit) or
                      (hold_addr(10) = 'H' and not mode16bit)  then
                      readAutoSelect_proc;     -- AutoSelect modality A9 = VID
                   else
                      readCFIData_proc;
                   end if; 
              when ReadCFIData_AS    =>     -- Memory Security Data Read op. from Auto Select mode
                   if (hold_addr(9) = 'H' and mode16bit) or
                      (hold_addr(10) = 'H' and not mode16bit)  then
                      readAutoSelect_proc;     -- AutoSelect modality A9 = VID
                   else
                      readCFIData_proc;
                   end if; 
              when others =>   
                   assert (0>1)
                   report "(Invalid bus read status!)"
                   severity error;
           end case;           
        
        elsif ((E_N = '0' and G_N = '1' and  W_N'event  and  W_N = '1' ) or 
               (W_N = '0' and G_N = '1' and  E_N'event  and  E_N = '1')) then      -- MEMORY WRITE CYCLE
          
           -- address and data latching 
           hold_data := Data_bus_in;
           command   := slv2int(hold_data(7 downto 0));
            
           if (mode16bit) then cmd_addr := slv2int(hold_addr(10 downto 0));
           else cmd_addr := slv2int(hold_addr(11 downto 0));
           end if; 
           
           -- Bus write operation case structure
           case Write_status is
              ------------------ 
              when BypassPG => 
                 case command is
                   when PG  =>   -- unlock bypass program
                        if (Read_status = ReadArray and Running = Free and SR(5) = '0') then     
                           Write_status := Unlock_BP;         -- new program operation 
                        else bad_command;  
                        end if; 
                   when AS  =>   -- unlock bypass reset
                        if (Read_status = ReadArray and Running = Free and SR(5) = '0') then
                            Write_status := Unlock_BR;
                        else bad_command;     
                        end if; 
                   when I1 =>   -- 1st item
                        if (SR(5) = '1' and ((mode16bit and cmd_addr = addr_1) or (not mode16bit and cmd_addr = addr_3))) then  
                           Write_status := BypassPG_cycle2;
                        else bad_command;
                        end if;         
                   when RD  =>   -- read/reset 1 cycle op.
                        if (SR(5) = '1') then  
                           RDRS_proc;
                           Write_status := BypassPG;
                        else bad_command;
                        end if;          
                   when others => bad_command;
                 end case; 
              when BypassPG_cycle2 =>
                 case command is
                   when I2  =>   -- 2nd item
                        if ((mode16bit and cmd_addr = addr_2) or (not mode16bit and cmd_addr = addr_1)) then  
                           Write_status := BypassPG_cycle3;
                        else bad_command;
                        end if;        
                   when others => bad_command;   
                 end case;
              when BypassPG_cycle3 =>
                 case command is
                    when RD  =>  -- read/reset 3 cycle op.
                         RDRS_proc;
                         Write_status := BypassPG;
                    when others => bad_command;   
                 end case;
              when Unlock_BP =>  -- unlock bypass program
                   Pgm_proc;
                   Write_status := BypassPG;
              when Unlock_BR =>  -- unlock bypass reset confirm
                   if (command /= UBR) then       -- UBR confirm 
                      assert (0>1)
                      report "(Attention! The Unlock Bypass Reset operation will be aborted!)"
                      severity warning;
                      Write_status := BypassPG;
                   else 
                     if (Vpp_sig = '0') then
                        Running := Free;     -- return to read/reset modality 
                        Write_status := cmd_cycle1;
                     else
                        Write_status := BypassPG; 
                     end if;
                   end if;  
              ------------------ 
              when cmd_cycle1 =>
                 
                case command is
                   when I1 =>   -- 1st item
                        if (Running = Free or SR(5) = '1') then      
                            NextWriteCycle;  
                        else bad_command;
                        end if;        
                   when RD  =>   -- read/reset 1 cycle op.
                        RDRS_proc;

                   when EES =>   -- Erase Suspend
                        if (SR(5) = '1') then 
                           assert (0>1)
                           report "(P/E Controller Error. Read/Reset must be issued before other commands are issued!)"
                           severity warning;
                        elsif (Running /= BlockErase and Running /= EEwait) then    -- Block Erase or Block Erase before timeout
                           assert (0>1)
                           report "(Invalid suspend command: no Block Erase operation in progress!)"
                           severity warning;
                        elsif (Read_status /= ReadArray and Read_status /= ReadStatusReg) then 
                           bad_command;     
                        elsif (EEabort_flag) then
                           bad_command; 
                        elsif (Running = BlockErase) then
                           timeEES := now;
                           Running := EEsuspend;
                           completion <= not completion after EEsuspend_latency;      
                        elsif (Running = EEwait) then                                -- Block Erase before timeout
                           timeEES := timeEE;         
                           Running := EEsuspend;
                           completion <= not completion; 
                        end if;
                   when EER =>   -- Erase Resume
                        if (SR(5) = '1') then 
                           assert (0>1)
                           report "(P/E Controller Error. Read/Reset must be issued before other commands are issued!)"
                           severity warning;
                        elsif EE_susp then
                            if (Running = Free and Read_status = ReadArray and Write_status /= BypassPG) then
                               EE_susp := false;  
                               Running := BlockErase;
                               completion <= not completion after BlockErase_time - timeEES + timeEE;
                               -- status reg. management 
                               SR(3) := '1'; 
                               SR(7) := '0';
                               RB_internal <= '0'after tWHRL;       -- or  tELRL   
                               Read_status := ReadStatusReg;
                            else 
                              assert (0>1)
                              report "(Invalid resume command: device busy, bypass or autoselect or security data modality set !)"
                              severity warning;
                            end if;
                        else
                            assert (0>1)
                            report "(Invalid resume command: no Block Erase operation suspended!)"
                            severity warning;
                        end if;
                   when RCFI  =>   -- CFI Data 
                        if (Running = Free) then 
                          if (SR(5) = '1') then 
                            assert (0>1)
                            report "(P/E Controller Error. Read/Reset must be issued before other commands are issued!)"
                            severity warning;
                          elsif (mode16bit and hold_addr(7 downto 0) /= "01010101") or 
                              (not mode16bit and hold_addr(7 downto 0) /= "10101010") then
                             bad_command;
                          elsif (Read_status = ReadSpecialData) then
                            Read_status := ReadCFIData_AS;
                          else 
                            Read_status := ReadCFIData;
                          end if;
                        else bad_command; 
                        end if;    
                   when others => bad_command;
                end case; 
              ------------------
              when cmd_cycle2 => 
                case command is
                   when I2  =>   -- 2nd item
                        NextWriteCycle;
                   when others => bad_command;   
                end case;
             ------------------ 
              when cmd_cycle3 =>  
                 case command is
                    when RD  =>  -- read/reset 3 cycle op.
                         RDRS_proc;
                         Write_status := cmd_cycle1;
                    when AS  =>  -- Auto Select
                         if Read_status = ReadArray and ((mode16bit and addr_1 = cmd_addr) or (not mode16bit and addr_3 = cmd_addr)) then 
                            Read_status := ReadSpecialData;
                            Write_status := cmd_cycle1;
                         else bad_command;
                         end if;
                    when PG  =>  -- Program op.
                         if Read_status = ReadArray and (Running = Free and SR(5) = '0' and 
                            ((mode16bit and addr_1 = cmd_addr) or (not mode16bit and addr_3 = cmd_addr)) ) then  
                           Write_status := Program;         -- new program operation 
                         else bad_command;  
                         end if; 
                    when UB  =>  -- Unlock Bypass Command
                         if Read_status = ReadArray and ((mode16bit and addr_1 = cmd_addr) or (not mode16bit and addr_3 = cmd_addr)) then 
                            Write_status := BypassPG;
                         else bad_command;
                         end if;
                    when I3  =>  -- 3rd item
                        if Read_status = ReadArray then NextWriteCycle; 
                        else bad_command;
                        end if; 
                    when others => bad_command; 
                 end case;
              ------------------ 
              when cmd_cycle4 =>
                 case command is
                    when I1 =>   -- 1st item
                       -- Running is only Free or Erase
                       NextWriteCycle;
                    when others => bad_command; 
                 end case;
              when Program =>    -- Program word/byte op.
                   Pgm_proc; 
                   Write_status := cmd_cycle1;
              ------------------
              when cmd_cycle5 =>
                 case command is
                    when I2 =>   -- 2nd item
                       -- Running is only Free or Erase
                       NextWriteCycle;  
                    when others => bad_command; 
                 end case;
              ------------------
              when cmd_cycle6 =>
                 case command is
                    when EE =>  -- Chip erase op.
                         Running := ChipErase;
                         Read_status := ReadStatusReg;

                         EEabort_flag := true;
                         for i in 0 to Blocks_Num - 1 loop
                            currBlock_protect := (Block_Protect(num_block) and RP_Nsig /= "10") or (num_block = boot_block_num and WP_N = '0');   
                            if currBlock_protect then      -- check block protection 
                               assert (0>1)
                               report "(Invalid address: this block is write protected!)"
                               severity note;
                            else
                              BlkEE_proc(i);
                              EEabort_flag := false;
                            end if;
                         end loop;
                           
                         if EEabort_flag then completion <= not completion after EEabort_latency;
                         else completion <= not completion after ChipErase_time;
                         end if;    
                
                         RB_internal <= '0' after tWHRL;       -- or  tELRL 
                         -- status reg. management 
                         SR(3) := '1'; 
                         SR(7) := '0';
                         Write_status := cmd_cycle1;
                    when EER => -- Block erase op.
                         Running := EEwait;
                         timeEE  := now;
                         Read_status := ReadStatusReg;
                         SR(7) := '0';
                         find_block(address);
                         currBlock_protect := (Block_Protect(num_block) and RP_Nsig /= "10") or (num_block = boot_block_num and WP_N = '0');   
                         
                         RB_internal <= '0' after tWHRL;  -- tEHRL busy  

                         if currBlock_protect then      -- check block protection 
                            assert (0>1)
                            report "(Invalid address: this block is write protected!)"
                            severity note;
                         else
                            ErasingBlock(num_block) := true; 
                         end if;
                         
                         if (EE_1stBlock) then     
                           completion <= not completion after EEstart_latency;
                           EE_1stBlock := false; 
                         end if;   
                    when EES =>   -- Erase Suspend
                        if (Running = EEwait) then
                           timeEES := timeEE;         
                           Running := EEsuspend;

                           EE_1stBlock := true; 
                          
                           EEabort_flag := true;
                           for i in 0 to Blocks_Num - 1 loop    -- block erasing
                              if ErasingBlock(i) then 
                                 BlkEE_proc(i);
                                 EEabort_flag := false;
                              end if;
                           end loop; 

                           completion <= not completion; 
                        else bad_command;
                        end if;  
                    when others => 
                        if (Running = EEwait) then
                           Running := Free;
                           Read_status := ReadArray;
                           if (Vpp_sig = '0' or SR(5) = '1') then Write_status := cmd_cycle1; 
                           else Write_status := BypassPG;
                           end if;
                           EE_1stBlock := true;
                        end if;   
                        bad_command;
                 end case;
              when others => bad_command; 
           end case;
        else       
        end if;                                          
     end if;                                                                                                  -- MEMORY READY STATE  

    -- code for out_data event
    if (out_data'event) then
       if outdata_flag_err = true then
         case message_err is
            when inv_erasing_addr =>
                 assert (0>1)
                 report "(Invalid Address: It is not possible to read cells in Erasing Block addresses!) "
                 severity note;
            when inv_addrSpecData =>
                 assert (0>1)
                 report "(Invalid Manufacturer Code, Device Code or Block Protection Status address!)"
                 severity warning;
            when inv_addrCFIData =>
                 assert (0>1)
                 report "(Invalid Address: It is necessary an address inside the Security Memory Block!)"
                 severity warning;
            when device_busy =>
                 assert (0>1)
                 report "(Invalid operation! The memory is busy!)"
                 severity warning;
            when others =>
                 assert (0>1)
                 report "(Output data invalid!!) "
                 severity warning;
           end case;
           outdata_flag_err := false;
       end if;
       
       if (G_N = '0' and E_N = '0') then
          Data_bus_out <= hold_data;
       else 
          Data_bus_out <= (others => 'Z');
       end if; 
     end if;


     -- code for completion event 
     if (completion'event) then 
       if Running = EEwait then
          if (now - timeEE >= EEstart_latency) then
              timeEE  := now;
              Running := BlockErase; 
              EE_1stBlock := true; 
              
              EEabort_flag := true;
              for i in 0 to Blocks_Num - 1 loop
                if ErasingBlock(i) then 
                   BlkEE_proc(i);
                   EEabort_flag := false;
                end if;
              end loop; 
               
              if EEabort_flag then completion <= not completion after EEabort_latency;
              else completion <= not completion after BlockErase_time;
              end if;
               
              -- status reg. management 
              SR(3) := '1'; 
              RB_internal <= '0';
              Write_status := cmd_cycle1;
          else
             completion <= not completion after (EEstart_latency - now + timeEE);     
          end if;
       elsif Running = EEsuspend then
          Running := Free; 
          RB_internal <= '1';
          EE_susp := true;
          if (SR(5) = '0') then  Read_status := ReadArray;
          end if;  
          if (Vpp_sig = '0' or SR(5) = '1') then  Write_status := cmd_cycle1; 
          else Write_status := BypassPG;
          end if;
       elsif Running = Program then
          
          
          if (SR(5) = '0') then  
             Read_status := ReadArray;
             RB_internal <= '1';
             Running := Free;
          end if;  
          if (Vpp_sig = '0' and Write_status /= BypassPG) or SR(5) = '1' then Write_status := cmd_cycle1; 
          else Write_status := BypassPG;
          end if;
       elsif Running = BlockErase then
          RB_internal <= '1';
          Running := Free;
          if (SR(5) = '0') then  Read_status := ReadArray; 
          end if;
          if (Vpp_sig = '0' or SR(5) = '1') then Write_status := cmd_cycle1; 
          else Write_status := BypassPG;
          end if;
          for i in 0 to Blocks_Num - 1 loop
             ErasingBlock(i) := false;
          end loop;
       elsif Running = Reset then
         if (now - timeRST >= Reset_time) then
            RB_internal <= '1';
            Running := Free;
            Read_status := ReadArray;
            if (Vpp_sig = '0' and Write_status /= BypassPG and Write_status /= BypassPG_cycle3) or SR(5) = '1' then Write_status := cmd_cycle1; 
            else Write_status := BypassPG;
            end if;
         else
            completion <= not completion after (Reset_time - now + timeRST);
         end if;
       else   
          RB_internal <= '1';
          Running := Free;
          if (SR(5) = '0') then  Read_status := ReadArray;
          end if;
          if (Vpp_sig = '0' or SR(5) = '1') then Write_status := cmd_cycle1; 
          else Write_status := BypassPG;
          end if;
       end if;
    end if; 


  end process main;
  
end;
