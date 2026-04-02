----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Oumar Kone
-- 
-- Create Date: 02/26/2026 06:58:29 PM
-- Design Name: 
-- Module Name: decoder - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity decoder is
    port(
        op                          : in std_logic_vector(1 downto 0);
        func0, func5                : in std_logic;
        Rd                          : in std_logic_vector(3 downto 0);
        Memtoreg, MemWrite, ALUSrc, 
            RegWrite, ALUOp, PCS,
            Branch                  : out std_logic;
        ImmSrc, RegSrc  : out std_logic_vector(1 downto 0)
    );
end decoder;

architecture Behavioral of decoder is

begin
    process(op, func0, func5) begin
        if op = "00" and func5 = '0' and func0 = '0' then
                Branch   <= '0';
                Memtoreg <= '0';
                MemWrite <= '0';
                ALUSrc   <= '0';
                RegWrite <= '1';
                ALUOp    <= '1';
                ImmSrc   <= "00";
                RegSrc   <= "00";
         elsif op = "00" and func5 = '1' and func0 = '0'then
                Branch   <= '0';
                Memtoreg <= '0';
                MemWrite <= '0';
                ALUSrc   <= '1';
                RegWrite <= '1';
                ALUOp    <= '1';
                ImmSrc   <= "00";
                RegSrc   <= "00";
         elsif op = "01" and func5 = '0' and func0 = '0' then
                Branch   <= '0';
                Memtoreg <= '0';
                MemWrite <= '1';
                ALUSrc   <= '1';
                RegWrite <= '0';
                ALUOp    <= '0';
                ImmSrc   <= "01";
                RegSrc   <= "10";
         elsif op = "01" and func5 = '0' and func0 = '1' then
                Branch   <= '0';
                Memtoreg <= '1';
                MemWrite <= '0';
                ALUSrc   <= '1';
                RegWrite <= '1';
                ALUOp    <= '0';
                ImmSrc   <= "01";
                RegSrc   <= "00";
          elsif op = "10" and func5 = '0' and func0 = '0' then
                Branch   <= '1';
                Memtoreg <= '0';
                MemWrite <= '0';
                ALUSrc   <= '1';
                RegWrite <= '0';
                ALUOp    <= '0';
                ImmSrc   <= "10";
                RegSrc   <= "01";
         else
                Memtoreg <= '0';
                MemWrite <= '0';
                ALUSrc   <= '0';
                RegWrite <= '0';
                ALUOp    <= '0';
                ImmSrc   <= "00";
                RegSrc   <= "00";
        end if;
        
        PCS <= '1' when (to_integer(unsigned(Rd)) = 15 and RegWrite = '1') or Branch = '1' else '0';
    end Process;
end Behavioral;
