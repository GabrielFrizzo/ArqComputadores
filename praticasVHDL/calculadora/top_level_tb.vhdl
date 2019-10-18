library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_level_tb is
end entity top_level_tb;

architecture a_top_level_tb of top_level_tb is
	component top_level is
		port (
			rst : in std_logic;
			clk : in std_logic;
			err_sig : out std_logic;
			saida : out unsigned(13 downto 0)
		);
	end component top_level;
	signal rst, clk, err_sig : std_logic;
	signal saida : unsigned(13 downto 0);
begin
	uut : top_level port map(rst => rst, clk => clk, err_sig => err_sig, saida => saida);

	process
	begin
		rst <= '1';
		wait for 10 ns;
		rst <= '0';
		wait;
	end process;

	process
	begin
		clk <= '0';
		wait for 50 ns;
		clk <= '1';
		wait for 50 ns;
	end process;
end architecture a_top_level_tb;