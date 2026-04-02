----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/19/2026 11:08:50 PM
-- Design Name: 
-- Module Name: decoder_tb - Behavioral
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

entity decoder_tb is
end decoder_tb;

architecture Behavioral of decoder_tb is

    -- Component declaration
    component decoder
        port(
            op                          : in std_logic_vector(1 downto 0);
            func0, func5                : in std_logic;
            Rd                          : in std_logic_vector(3 downto 0);
            Memtoreg, MemWrite, ALUSrc, 
            RegWrite, ALUOp, PCS,
            Branch                      : out std_logic;
            ImmSrc, RegSrc  : out std_logic_vector(1 downto 0)
        );
    end component;

    -- Signals
    signal op                          : std_logic_vector(1 downto 0);
    signal func0, func5                : std_logic;
    signal Rd                          : std_logic_vector(3 downto 0);
    signal Memtoreg, MemWrite, ALUSrc  : std_logic;
    signal RegWrite, ALUOp, PCS        : std_logic;
    signal Branch                      : std_logic;
    signal ALUControl, ImmSrc, RegSrc  : std_logic_vector(1 downto 0);

begin

    -- DUT
    uut: decoder
        port map (
            op => op,
            func0 => func0,
            func5 => func5,
            Rd => Rd,
            Memtoreg => Memtoreg,
            MemWrite => MemWrite,
            ALUSrc => ALUSrc,
            RegWrite => RegWrite,
            ALUOp => ALUOp,
            PCS => PCS,
            Branch => Branch,
            ImmSrc => ImmSrc,
            RegSrc => RegSrc
        );

    -- Stimulus
    stim_proc: process
    begin

        op    <= "00"; func5 <= '0'; func0 <= '0'; Rd <= "0001";
        wait for 10 ns;

        op    <= "00"; func5 <= '1'; func0 <= '0'; Rd <= "0010";
        wait for 10 ns;

        op    <= "01"; func5 <= '0'; func0 <= '0'; Rd <= "0011";
        wait for 10 ns;

        op    <= "01"; func5 <= '0'; func0 <= '1'; Rd <= "0100";
        wait for 10 ns;

        op    <= "10"; func5 <= '0'; func0 <= '0'; Rd <= "0101";
        wait for 10 ns;

        op    <= "00"; func5 <= '0'; func0 <= '0'; Rd <= "1111";
        wait for 10 ns;

        op    <= "11"; func5 <= '1'; func0 <= '1'; Rd <= "0000";
        wait for 10 ns;

        wait;

    end process;

end Behavioral;