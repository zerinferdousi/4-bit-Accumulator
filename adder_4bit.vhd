library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity adder_4bit is
    Port ( A   : in  STD_LOGIC_VECTOR (3 downto 0);
           B   : in  STD_LOGIC_VECTOR (3 downto 0);
           SUM : out STD_LOGIC_VECTOR (3 downto 0));
end adder_4bit;

architecture Structural of adder_4bit is
    -- 4-bit Ripple Carry Logic
    signal c : STD_LOGIC_VECTOR (2 downto 0);
begin
    -- Bit 0
    SUM(0) <= A(0) xor B(0);
    c(0)   <= A(0) and B(0);

    -- Bit 1
    SUM(1) <= A(1) xor B(1) xor c(0);
    c(1)   <= (A(1) and B(1)) or (A(1) and c(0)) or (B(1) and c(0));

    -- Bit 2
    SUM(2) <= A(2) xor B(2) xor c(1);
    c(2)   <= (A(2) and B(2)) or (A(2) and c(1)) or (B(2) and c(1));

    -- Bit 3 (4-bit output limit: 16 overflow carry is discarded)
    SUM(3) <= A(3) xor B(3) xor c(2);
end Structural;