----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/19/2026 10:59:31 PM
-- Design Name: 
-- Module Name: decoder_alu_tb - Behavioral
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

entity tb_decoder_alu is
end tb_decoder_alu;

architecture Behavioral of tb_decoder_alu is

    -- Component declaration
    component decoder_alu
        Port (
            funct       : in std_logic_vector(4 downto 0);
            ALUOp       : in std_logic;
            ALUControl  : out std_logic_vector(1 downto 0);
            FlagW       : out std_logic_vector(1 downto 0)
        );
    end component;

    -- Signals
    signal funct       : std_logic_vector(4 downto 0);
    signal ALUOp       : std_logic;
    signal ALUControl  : std_logic_vector(1 downto 0);
    signal FlagW       : std_logic_vector(1 downto 0);

begin

    -- Instantiate DUT
    uut: decoder_alu
        port map (
            funct       => funct,
            ALUOp       => ALUOp,
            ALUControl  => ALUControl,
            FlagW       => FlagW
        );

    -- Stimulus process
    stim_proc: process
    begin

        ALUOp <= '0';
        funct <= "00000";
        wait for 10 ns;

        ALUOp <= '1';
        funct <= "01000"; -- funct(4:1) = 0100
        wait for 10 ns;

        funct <= "00100";
        wait for 10 ns;

        funct <= "00000";
        wait for 10 ns;

        funct <= "11000";
        wait for 10 ns;

        funct <= "11110";
        wait for 10 ns;

        -- S
        wait;

    end process;

end Behavioral;