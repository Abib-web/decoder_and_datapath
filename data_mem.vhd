----------------------------------------------------------------------------------
-- Company: UQTR GEGI
-- Engineer: Oumar Kone
-- 
-- Create Date: 02/23/2026 01:42:07 PM
-- Design Name: 
-- Module Name: data_mem - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--use IEEE.NUMERIC_STD.ALL;
use IEEE.NUMERIC_STD_UNSIGNED.all;


entity data_mem is
    generic(N: integer := 6; M: integer := 32);
    Port (clk : in std_logic;
        A       : in std_logic_vector(M-1 downto 0);
        WD      : in std_logic_vector(M-1 downto 0);
        WE     : in std_logic;
        RD: out std_logic_vector(M-1 downto 0)
    );
end data_mem;

architecture Behavioral of data_mem is
    type mem_array is array (0 to(2**N-1)) 
        of STD_LOGIC_VECTOR (M-1 downto 0);
    signal ram_mem: mem_array:= (others => (others => '0'));
begin
    process(clk, A, WD, WE) begin
        if  rising_edge(clk)  then
            if WE = '1' then
                ram_mem(to_integer (A(5 downto 0))) <= WD;
            end if;
        end if;   
    end process;
    RD <= ram_mem(to_integer (A(5 downto 0)));
end Behavioral;
