----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/10/2026 04:28:54 PM
-- Design Name: 
-- Module Name: datapath_decoders_tb - Behavioral
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
use STD.TEXTIO.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;

entity datapath_decoders_tb is
end datapath_decoders_tb;

architecture Behavioral of datapath_decoders_tb is

    constant N : integer := 32;

    signal clk : std_logic := '0';
    signal Rd_v  : std_logic_vector(N-1 downto 0);
    signal Resultat : std_logic_vector(N-1 downto 0);

    signal resultat_expected : std_logic_vector(N-1 downto 0);

begin

    clk_process: process
    begin
        clk <= '1'; wait for 10 ns;
        clk <= '0'; wait for 10 ns;
    end process;

    dut: entity work.datapath_decoders
    port map(
        clk      => clk,
        Rd       => Rd_v,
        Resultat => Resultat
    );

    process
        file file_vectors : text;
        variable L : line;
        variable dummy : character;
        variable instr_v : std_logic_vector(N-1 downto 0);
        variable expected_alu_v  : std_logic_vector(N-1 downto 0);
        variable expected_data_v : std_logic_vector(N-1 downto 0);
        variable errors : integer := 0;
        variable index  : integer := 0;
        
    begin

        file_open(file_vectors, "C:\Users\OumarK\Desktop\1084\Laboratoire_3\Data.txt", read_mode);

        while not endfile(file_vectors) loop
            wait until rising_edge(clk);
            readline(file_vectors, L);

            read(L, instr_v);
            read(L, dummy);
            read(L, expected_alu_v);
            read(L, dummy);
            read(L, expected_data_v);

            Rd_v <= instr_v;
            resultat_expected <= expected_alu_v;

            wait until falling_edge(clk);

            if Resultat /= resultat_expected then
                report "Error at test vector";
                errors := errors + 1;
            end if;

            index := index + 1;
        end loop;

        if errors = 0 then
            report "NO ERRORS -- " & integer'image(index) & " tests completed successfully." severity note;
        else
            report integer'image(index) & " tests completed with " & integer'image(errors) & " errors." severity warning;
        end if;

        file_close(file_vectors);
        wait;
    end process;

end Behavioral;
