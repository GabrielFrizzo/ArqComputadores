library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_level_tb is
end entity top_level_tb;

architecture a_top_level_tb of top_level_tb is
	component top_level is
		port (
			rst 		: in std_logic;
			clk 		: in std_logic;
			err_sig 	: out std_logic;
			saida_rom   : out unsigned(13 downto 0);
            saida_pc    : out unsigned(6 downto 0);
            saida_reg_1 : out unsigned(15 downto 0);
            saida_reg_2 : out unsigned(15 downto 0);
            saida_ula   : out unsigned(15 downto 0)
		);
	end component top_level;
	signal rst, clk, err_sig : std_logic;
	signal saida_rom : unsigned(13 downto 0);
	signal saida_pc : unsigned(6 downto 0);
	signal saida_reg_1, saida_reg_2, saida_ula : unsigned(15 downto 0);
begin
	uut : top_level port map(rst => rst,
							 clk => clk,
							 err_sig => err_sig,
							 saida_rom => saida_rom,
							 saida_pc => saida_pc,
							 saida_reg_1 => saida_reg_1,
							 saida_reg_2 => saida_reg_2,
							 saida_ula => saida_ula);

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