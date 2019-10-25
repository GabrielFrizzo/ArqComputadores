library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux3x7_tb is
end entity mux3x7_tb;

architecture a_mux3x7_tb of mux3x7_tb is
	component mux3x7 is
		port (
			  sel         : in unsigned(1 downto 0);
	          entr0       : in unsigned(6 downto 0);
	          entr1       : in unsigned(6 downto 0);
	          entr2       : in unsigned(6 downto 0);
	          saida       : out unsigned(6 downto 0)
		);
	end component mux3x7;
	signal sel : unsigned(1 downto 0);
	signal entr0, entr1, entr2, saida : unsigned(6 downto 0);
begin
	uut : mux3x7 port map (sel => sel, entr0 => entr0, entr1 => entr1, entr2 => entr2, saida => saida);

	process
	begin
		sel <= "00";
		entr0 <= "1111111";
		entr1 <= "1010101";
		entr2 <= "0101010";
		wait for 50 ns;
		sel <= "01";
		wait for 50 ns;
		entr0 <= "0000000";
		entr1 <= "0000000";
		entr2 <= "1110000";
		wait for 50 ns;
		sel <= "10";
		entr0 <= "0000110";
		entr1 <= "0011100";
		entr2 <= "1110000";
		wait for 50 ns;
		wait;
	end process;
end architecture a_mux3x7_tb;