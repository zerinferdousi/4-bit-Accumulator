library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity accumulator_4bit is
    Port ( A     : in  STD_LOGIC_VECTOR (3 downto 0);
           B     : in  STD_LOGIC_VECTOR (3 downto 0);
           CLK   : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           Q     : out STD_LOGIC_VECTOR (3 downto 0));
end accumulator_4bit;

architecture Structural of accumulator_4bit is

    -- 4-bit Adder Component
    component adder_4bit is
        Port ( A   : in  STD_LOGIC_VECTOR (3 downto 0);
               B   : in  STD_LOGIC_VECTOR (3 downto 0);
               SUM : out STD_LOGIC_VECTOR (3 downto 0));
    end component;

    -- 4-bit Register Component
    component reg_4bit is
        Port ( D     : in  STD_LOGIC_VECTOR (3 downto 0);
               CLK   : in  STD_LOGIC;
               RESET : in  STD_LOGIC;
               Q     : out STD_LOGIC_VECTOR (3 downto 0));
    end component;

    -- Internal bus wire connecting Adder to Register
    signal sum_wire : STD_LOGIC_VECTOR (3 downto 0);

begin

    -- Adder Block Instantiation
    ADDER_INST: adder_4bit port map (
        A   => A,
        B   => B,
        SUM => sum_wire
    );

    -- Register Block Instantiation
    REG_INST: reg_4bit port map (
        D     => sum_wire,
        CLK   => CLK,
        RESET => RESET,
        Q     => Q
    );

end Structural;