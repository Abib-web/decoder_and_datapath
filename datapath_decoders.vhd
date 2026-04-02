----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/10/2026 11:07:21 AM
-- Design Name: 
-- Module Name: datapath_decoders - Behavioral
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

entity datapath_decoders is
    Port (
        clk         : in std_logic;
        Rd          : in std_logic_vector(31 downto 0);
        Resultat    : out std_logic_vector(31 downto 0)
    );
end datapath_decoders;

architecture Behavioral of datapath_decoders is

    signal Memtoreg  : std_logic;
    signal MemWrite  : std_logic;
    signal ALUSrc    : std_logic;
    signal RegWrite  : std_logic;
    signal ALUOp     : std_logic;
    signal PCS       : std_logic;
    signal Branch    : std_logic;

    signal ALUControl : std_logic_vector(1 downto 0);
    signal ImmSrc     : std_logic_vector(1 downto 0);
    signal RegSrc     : std_logic_vector(1 downto 0);

    signal ALUFlags_o : std_logic_vector(3 downto 0);
    signal funct      : std_logic_vector(4 downto 0);
    signal FlagW      : std_logic_vector(1 downto 0);

    component arm_lab2 is
    generic(N : integer := 32);
    port (
        clk: in std_logic;
        instruction_i : in std_logic_vector(N-1 downto 0);
        Memtoreg, MemWrite, ALUSrc, RegWrite: in std_logic;
        ALUControl, ImmSrc, RegSrc: in std_logic_vector(1 downto 0);
        ALUFlags_o: out std_logic_vector(3 downto 0);
        resultat_o : out std_logic_vector(N-1 downto 0)
    );
    end component;
    
    component decoder is
    port(
        op                          : in std_logic_vector(1 downto 0);
        func0, func5                : in std_logic;
        Rd                          : in std_logic_vector(3 downto 0);
        Memtoreg, MemWrite, ALUSrc, 
            RegWrite, ALUOp, PCS,
            Branch                  : out std_logic;
        ImmSrc, RegSrc  : out std_logic_vector(1 downto 0)
    );
    end component;
    
    component decoder_alu is
    Port (
        funct               : in std_logic_vector(4 downto 0);
        ALUOp               : in std_logic; 
        ALUControl, FlagW   : out std_logic_vector(1 downto 0)
    );
    end component;

begin

    funct <= Rd(24 downto 20);

    decoder_inst: decoder
    port map(
        op        => Rd(27 downto 26),
        func0     => Rd(20),
        func5     => Rd(25),
        Rd        => Rd(15 downto 12),
        Memtoreg  => Memtoreg,
        MemWrite  => MemWrite,
        ALUSrc    => ALUSrc,
        RegWrite  => RegWrite,
        ALUOp     => ALUOp,
        PCS       => PCS,
        Branch    => Branch,
        ImmSrc    => ImmSrc,
        RegSrc    => RegSrc
    );

    decoder_alu_inst: decoder_alu
    port map(
        funct      => funct,
        ALUOp      => ALUOp,
        ALUControl => ALUControl,
        FlagW      => FlagW
    );

    arm_lab2_inst: arm_lab2
    port map(
        clk           => clk,
        instruction_i => Rd,
        Memtoreg      => Memtoreg,
        MemWrite      => MemWrite,
        ALUSrc        => ALUSrc,
        RegWrite      => RegWrite,
        ALUControl    => ALUControl,
        ImmSrc        => ImmSrc,
        RegSrc        => RegSrc,
        ALUFlags_o    => ALUFlags_o,
        resultat_o    => Resultat
    );

end Behavioral;
