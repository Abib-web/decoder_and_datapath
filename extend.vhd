----------------------------------------------------------------------------------
-- Company: UQTR gegi
-- Engineer: Oumar Kone
-- 
-- Create Date: 02/23/2026 01:08:06 PM
-- Design Name: 
-- Module Name: extend - Behavioral
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


entity extend is
    generic(M : integer := 32);
    port(
        immsrc: in std_logic_vector(1 downto 0);
        instruc_i : in std_logic_vector(24-1 downto 0);
        instruc_o : out std_logic_vector(M-1 downto 0)
     );
end extend;

architecture Behavioral of extend is

begin
    with immsrc select
    instruc_o <= (31 downto 8 => '0') & instruc_i(7 downto 0) when "00",
         (31 downto 12 => '0') & instruc_i(11 downto 0) when "01",
         (31 downto 26 => '0') & instruc_i(23 downto 0)& "00" when "10",
         (31 downto 0 => '0')  when others;
end Behavioral;
