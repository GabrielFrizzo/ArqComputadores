library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux2x16_tb is
end entity mux2x16_tb;

architecture a_mux2x16_tb of mux2x16_tb is
	component mux2x16 is
		port (
			  sel         : in std_logic;
	          entr0		  : in unsigned(15 downto 0);
	          entr1 	  : in unsigned(15 downto 0);
	          saida       : out unsigned(15 downto 0)
		);
	end component mux2x16;
	signal sel : std_logic;
	signal entr0, entr1, saida : unsigned(15 downto 0);
begin
	uut : mux2x16 port map (sel => sel, entr0 => entr0, entr1 => entr1, saida => saida);

	process
	begin
		sel <= '0';
		entr0 <= "1111111111111111";
		entr1 <= "1010101010101010";
		wait for 50 ns;
		sel <= '1';
		wait for 50 ns;
		entr0 <= "0000000000000000";
		entr1 <= "0000000000000010";
		wait for 50 ns;
		wait;
	end process;
end architecture a_mux2x16_tb;