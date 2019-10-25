library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux3x16_tb is
end entity mux3x16_tb;

architecture a_mux3x16_tb of mux3x16_tb is
	component mux3x16 is
		port (
			  sel         : in unsigned(1 downto 0);
	          entr0       : in unsigned(15 downto 0);
	          entr1       : in unsigned(15 downto 0);
	          entr2       : in unsigned(15 downto 0);
	          saida       : out unsigned(15 downto 0)
		);
	end component mux3x16;
	signal sel : unsigned(1 downto 0);
	signal entr0, entr1, entr2, saida : unsigned(15 downto 0);
begin
	uut : mux3x16 port map (sel => sel, entr0 => entr0, entr1 => entr1, entr2 => entr2, saida => saida);

	process
	begin
		sel <= "00";
		entr0 <= "1111111111111111";
		entr1 <= "1010101010101010";
		entr2 <= "0101010101010101";
		wait for 50 ns;
		sel <= "01";
		wait for 50 ns;
		entr0 <= "0000000000000000";
		entr1 <= "0000000000000010";
		entr2 <= "1110000000000000";
		wait for 50 ns;
		sel <= "10";
		entr0 <= "0000110000000000";
		entr1 <= "0011100000000010";
		entr2 <= "1110000110000000";
		wait for 50 ns;
		wait;
	end process;
end architecture a_mux3x16_tb;