library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity accumulator_4bit_tb is
end accumulator_4bit_tb;

architecture behavior of accumulator_4bit_tb is 

    -- Component Declaration
    component accumulator_4bit
    port(
         A     : in  std_logic_vector(3 downto 0);
         B     : in  std_logic_vector(3 downto 0);
         CLK   : in  std_logic;
         RESET : in  std_logic;
         Q     : out std_logic_vector(3 downto 0)
        );
    end component;

   -- Inputs
   signal A     : std_logic_vector(3 downto 0) := (others => '0');
   signal B     : std_logic_vector(3 downto 0) := (others => '0');
   signal CLK   : std_logic := '0';
   signal RESET : std_logic := '0';

   -- Outputs
   signal Q : std_logic_vector(3 downto 0);

   -- Clock period definition (20 ns)
   constant CLK_period : time := 20 ns;

begin

   -- Instantiate the Unit Under Test (UUT)
   uut: accumulator_4bit port map (
          A     => A,
          B     => B,
          CLK   => CLK,
          RESET => RESET,
          Q     => Q
        );

   -- Clock generation process
   CLK_process :process
   begin
        CLK <= '0';
        wait for CLK_period/2;
        CLK <= '1';
        wait for CLK_period/2;
   end process;

   -- Stimulus process with required test cases from exam sheet
   stim_proc: process
   begin		
      -- Step 1: RESET=1, A=0000, B=0000 -> Expected Q = 0000 (Register is cleared)
      RESET <= '1';
      A <= "0000"; B <= "0000";
      wait for CLK_period;

      -- Step 2: RESET=0, A=0011 (3), B=0101 (5) -> Expected Q = 1000 (8)
      RESET <= '0';
      A <= "0011"; B <= "0101";
      wait for CLK_period;

      -- Step 3: RESET=0, A=0010 (2), B=0001 (1) -> Expected Q = 0011 (3)
      A <= "0010"; B <= "0001";
      wait for CLK_period;

      -- Step 4: RESET=0, A=1111 (15), B=0001 (1) -> Expected Q = 0000 (15+1=16, 4-bit overflow)
      A <= "1111"; B <= "0001";
      wait for CLK_period;

      -- Step 5: RESET=0, A=1010 (10), B=0101 (5) -> Expected Q = 1111 (15)
      A <= "1010"; B <= "0101";
      wait for CLK_period;

      wait;
   end process;

end behavior;