library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity and_gate_n is
    generic(N : integer := 32);
    port(
        A, B : in  std_logic_vector(N-1 downto 0);
        Y    : out std_logic_vector(N-1 downto 0)
    );
end entity;

architecture behavioral of and_gate_n is
begin
    Y <= A and B;
end architecture;