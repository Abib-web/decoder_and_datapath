library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;  

entity adder_n is
    generic(N : integer := 32);
    port(
        A, B : in  std_logic_vector(N-1 downto 0);
        Cin  : in  std_logic;
        Sum  : out std_logic_vector(N-1 downto 0);
        Cout : out std_logic
    );
end entity;

architecture behavioral of adder_n is
    signal temp : unsigned(N downto 0);
begin
    temp <= unsigned('0' & A) + unsigned('0' & B) + ("0000000" & Cin); 
    Sum  <= std_logic_vector(temp(N-1 downto 0));
    Cout <= temp(N);
end architecture;