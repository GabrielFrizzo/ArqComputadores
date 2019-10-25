library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux2x7_tb is
end entity mux2x7_tb;

architecture a_mux2x7_tb of mux2x7_tb is
	component mux2x7 is
		port (
			  sel         : in std_logic;
	          entr0		  : in unsigned(6 downto 0);
	          entr1 	  : in unsigned(6 downto 0);
	          saida       : out unsigned(6 downto 0)
		);
	end component mux2x7;
	signal sel : std_logic;
	signal entr0, entr1, saida : unsigned(6 downto 0);
begin
	uut : mux2x7 port map (sel => sel, entr0 => entr0, entr1 => entr1, saida => saida);

	process
	begin
		sel <= '0';
		entr0 <= "1111111";
		entr1 <= "1010101";
		wait for 50 ns;
		sel <= '1';
		wait for 50 ns;
		entr0 <= "0000000";
		entr1 <= "0000010";
		wait for 50 ns;
		wait;
	end process;
end architecture a_mux2x7_tb;