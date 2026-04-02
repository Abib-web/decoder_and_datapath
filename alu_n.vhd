------------------------------------------------------------------------------------
---- Company: 
---- Engineer: Oumar Kone
---- 
---- Create Date: 02/08/2026 10:51:26 PM
---- Design Name: 
---- Module Name: alu_n - Behavioral
---- Project Name: 
---- Target Devices: 
---- Tool Versions: 
---- Description: 
---- 
---- Dependencies: 
---- 
---- Revision:
---- Revision 0.01 - File Created
---- Additional Comments:
---- 
------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity alu_n is
    generic(N : integer := 32);
    port(
        A_in, B_in       : in  std_logic_vector(N-1 downto 0);
        ALUControl :  in std_logic_vector(1 downto 0); 
        Result_out     : buffer std_logic_vector(N-1 downto 0);
        ALUFlags       : out std_logic_vector(3 downto 0)
    );
end entity;

architecture structural of alu_n is
    -- Signaux interm?diaires
    signal and_out, or_out, sum_out : std_logic_vector(N-1 downto 0);
    signal cout : std_logic;
    signal B_mod    : std_logic_vector(N-1 downto 0); 
    signal cin      : std_logic;
    --sorties signaux internes  NZCV
    --signal xnor_o      : std_logic;
    --signal xor_o      : std_logic;
    
    -- D?claration  des composants
    component mux is 
        generic(N: integer); 
        port(
            A, B: in std_logic_vector(N-1 downto 0);
            en: in std_logic;
            S: out std_logic_vector(N-1 downto 0)
        );
    end component;
    

    component and_gate_n is
        generic(N : integer);
        port(
            A, B : in  std_logic_vector(N-1 downto 0);
            Y    : out std_logic_vector(N-1 downto 0)
        );
    end component;
    
    component or_gate_n is
        generic(N : integer);
        port(
            A, B : in  std_logic_vector(N-1 downto 0);
            Y    : out std_logic_vector(N-1 downto 0)
        );
    end component;
    
    component adder_n is
        generic(N : integer);
        port(
            A, B : in  std_logic_vector(N-1 downto 0);
            Cin  : in  std_logic;
            Sum  : out std_logic_vector(N-1 downto 0);
            Cout : out std_logic
        );
    end component;

begin
    cin   <=  ALUControl(0);
  
    -- Instanciation des modules
    U_mux_b: mux
        generic map(N => N)
        port map(not B_in, B_in, ALUControl(0), B_mod);
    

    U1: and_gate_n 
        generic map(N => N)
        port map(A => A_in, B => B_in, Y => and_out);
    
    U2: or_gate_n  
        generic map(N => N)
        port map(A => A_in, B => B_in, Y => or_out);
    
    U3: adder_n 
        generic map(N => N)
        port map(A => A_in, B => B_mod, Cin => cin, Sum => sum_out, Cout => cout);
    
    with ALUControl select
    Result_out <= and_out when "10",
              or_out  when "11",
              sum_out when others;
      
    -- ALU flags NZCV
    ALUFlags(0) <=((A_in(31) xnor (B_in(31) xor ALUControl(0))) 
            and (A_in(31) xor sum_out(31)))
            and (not ALUControl(1));-- overflow
    ALUFlags(1) <= not ALUControl(1) and cout;--carry out
    ALUFlags(2) <= '1' when Result_out = x"00000000" else '0';--not (or Result_out);--nand Result_out;--zero
    ALUFlags(3) <= Result_out(31);--negative
    

end architecture;

