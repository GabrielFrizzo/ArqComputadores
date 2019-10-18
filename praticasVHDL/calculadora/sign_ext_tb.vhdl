library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sign_ext_tb is
end entity sign_ext_tb;

architecture a_sign_ext_tb of sign_ext_tb is
	component sign_ext is
		port (
			entr  : in unsigned(6 downto 0);
            saida : out unsigned(15 downto 0)
		);
	end component sign_ext;
	signal entr  : unsigned(6 downto 0);
	signal saida : unsigned(15 downto 0);
begin
	uut : sign_ext port map(entr  => entr,
							saida => saida
						   );

	process
	begin
		entr <= "0000001";
		wait for 50 ns;
		entr <= "0000000";
		wait for 50 ns;
		entr <= "1000001";
		wait for 50 ns;
		wait;
	end process;
end architecture a_sign_ext_tb;
