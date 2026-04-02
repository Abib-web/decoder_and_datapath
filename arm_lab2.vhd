----------------------------------------------------------------------------------
-- Company: UQTR
-- Engineer: oUMAR koNE
-- 
-- Create Date: 02/23/2026 01:50:47 PM
-- Design Name: 
-- Module Name: arm_lab2 - Behavioral
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

entity arm_lab2 is
    generic(N : integer := 32);
    port (
        clk: in std_logic;
        instruction_i : in std_logic_vector(N-1 downto 0);
        Memtoreg, MemWrite, ALUSrc, RegWrite: in std_logic;
        ALUControl, ImmSrc, RegSrc: in std_logic_vector(1 downto 0);
        ALUFlags_o: out std_logic_vector(3 downto 0);
        resultat_o : out std_logic_vector(N-1 downto 0)
    );
end arm_lab2;

architecture Structural of arm_lab2 is
    -- signaux 
    signal ExtImm   : std_logic_vector(31 downto 0);
    signal RA1, RA2 : std_logic_vector(3 downto 0);
    -- R15
    signal R15 : std_logic_vector(31 downto 0) := (others => '0');
    signal RD1, RD2, ReadData, ALUResult,ALUResult_o, WriteData, Resultat, SrcA, SrcB : std_logic_vector(31 downto 0) := (others => '0');

    --block memory
    component data_mem is
        generic(N: integer := 6; M: integer := 32);
        port(
            clk     : in std_logic;
            A       : in std_logic_vector(M-1 downto 0);
            WD      : in std_logic_vector(M-1 downto 0);
            WE      : in std_logic;
            RD      : out std_logic_vector(M-1 downto 0)
        );
    end component;
    -- Resgiter 16x32
    component reg_file is
        generic(N: integer := 4; M: integer := 32);
        Port (clk : in std_logic;
            A1,A2, A3: in std_logic_vector(N-1 downto 0);
            WD3, R15: in std_logic_vector(M-1 downto 0);
            WE3: in std_logic;
            RD1, RD2: out std_logic_vector(M-1 downto 0)
        );
    end component;
    -- extend
    component extend is
        generic(M : integer);
        port(
            immsrc: in std_logic_vector(1 downto 0);
            instruc_i : in std_logic_vector(24-1 downto 0);
            instruc_o : out std_logic_vector(M-1 downto 0)
         );
    end component;
    
    
    component alu_n is
        generic(N : integer);
        port(
            A_in, B_in       : in  std_logic_vector(N-1 downto 0);
            ALUControl :  in std_logic_vector(1 downto 0); 
            Result_out     : out std_logic_vector(N-1 downto 0);
            ALUFlags       : out std_logic_vector(3 downto 0)
        );
    end component;


begin
    --
    extend_inst: extend
        generic map(32)
        port map(immsrc => ImmSrc, instruc_i=>instruction_i(23 downto 0), instruc_o=>ExtImm);
    alu_n_inst: alu_n
        generic map(32)
        port map(
            A_in => SrcA,
            B_in => SrcB,
            ALUControl => ALUControl,
            Result_out => ALUResult,
            ALUFlags => ALUFlags_o
        );
    --
    reg_file_inst: reg_file
        generic map(
            N => 4,
            M  => 32
        )
        port map(
            clk  => clk,
            A1   => RA1,
            A2   => RA2,
            A3   => instruction_i(15 downto 12),
            WD3  => Resultat,
            R15  => R15,
            WE3  => RegWrite,
            RD1  => RD1,
            RD2  => RD2
        );
        
    data_mem_inst: data_mem
        generic map(6, 32)
        port map( clk => clk ,A => ALUResult , WD => WriteData , WE => MemWrite, RD => ReadData);
    
    --  mux RA1 ET RA2
    with RegSrc(0) select
    RA1 <= instruction_i(19 downto 16) when '0',
            "1111" when '1',   
            "0000" when others; 

    with RegSrc(1) select
        RA2 <= instruction_i(15 downto 12) when '1',
            instruction_i(3 downto 0) when '0',
            "0000" when others; 
    --mix srcb
    with ALUSrc select
        SrcB <= RD2 when '0',
        ExtImm when '1',
        (others => '0') when others;
    -- mux resultat
    with MemtoReg select
        Resultat <= ReadData when '1',
        ALUResult when '0',
        (others => '0') when others;
    
    WriteData <= RD2;
    SrcA <= RD1;
    resultat_o <= Resultat;
    
end Structural;
