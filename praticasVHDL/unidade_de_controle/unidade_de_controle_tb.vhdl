library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity unidade_de_controle_tb is
end entity unidade_de_controle_tb;

architecture a_unidade_de_controle_tb of unidade_de_controle_tb is
	component unidade_de_controle is
		port (
			rst : in std_logic;
			clk : in std_logic;
			err_sig : out std_logic;
			saida : out unsigned(13 downto 0)
		);
	end component unidade_de_controle;
	signal rst, clk, err_sig : std_logic;
	signal saida : unsigned(13 downto 0);
begin
	uut : unidade_de_controle port map(rst => rst, clk => clk, err_sig => err_sig, saida => saida);

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
end architecture a_unidade_de_controle_tb;