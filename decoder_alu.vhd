----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Oumar Kone
-- 
-- Create Date: 03/10/2026 10:40:38 AM
-- Design Name: 
-- Module Name: decoder_alu - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity decoder_alu is
    Port (
        funct               : in std_logic_vector(4 downto 0);
        ALUOp               : in std_logic; 
        ALUControl, FlagW   : out std_logic_vector(1 downto 0)
    );
end decoder_alu;

architecture Behavioral of decoder_alu is
            
begin
    --FlagW <= "00";
    process(funct, ALUOp) begin
        if ALUOp = '1' and funct(4 downto 1) = "0100" then --ADD
            ALUControl <= "00";
--            if funct(0) = '1' then
--                FlagW <= "11";
--            elsif funct(0) = '0' then
--                FlagW <= "00";
--            end if;
        elsif ALUOp = '1' and funct(4 downto 1) = "0010" then
            ALUControl <= "01";
        elsif ALUOp = '1' and funct(4 downto 1) = "0000" then -- and GATE
            ALUControl <= "10";
        elsif ALUOp = '1' and funct(4 downto 1) = "1100" then -- or op
            ALUControl <= "11";
       else
            ALUControl <= "00";
        end if; 
    end process;

end Behavioral;
