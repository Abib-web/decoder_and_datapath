----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Oumar Kone
-- 
-- Create Date: 02/23/2026 11:34:42 AM
-- Design Name: 
-- Module Name: reg_file - Behavioral
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
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity reg_file is
    generic(N: integer := 4; M: integer := 32);
    Port (clk : in std_logic;
        A1,A2, A3: in std_logic_vector(N-1 downto 0);
        WD3, R15: in std_logic_vector(M-1 downto 0);
        WE3: in std_logic;
        RD1, RD2: out std_logic_vector(M-1 downto 0)
    );
end reg_file;

architecture Behavioral of reg_file is
    type mem_array is array (0 to (2**N-1)) 
        of STD_LOGIC_VECTOR (M-1 downto 0);
    signal ram_mem: mem_array:= (others => (others => '0'));
begin
    process(clk) begin
        if  rising_edge(clk)  then
            if WE3 = '1' then
                ram_mem(to_integer (A3)) <= WD3;
            end if;
        end if;   
    end process;
    RD1 <= ram_mem(to_integer (A1));
    RD2 <= ram_mem(to_integer (A2));
end Behavioral;
