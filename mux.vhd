library IEEE;
use IEEE.std_logic_1164.all;

entity mux is
    generic (N: integer :=32);  
    port (
        A, B: in std_logic_vector(N-1 downto 0);
        en: in std_logic;
        S: out std_logic_vector(N-1 downto 0)  
    );
end entity;

architecture synth of mux is
begin
    S <= A when en = '1' else B;
end;