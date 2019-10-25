library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity somador_tb is
end entity somador_tb;

architecture a_somador_tb of somador_tb is
	component somador is
		port (
			data_in : in unsigned(6 downto 0);
			data_out : out unsigned(6 downto 0)
		);
	end component somador;
	signal data_in, data_out : unsigned(6 downto 0);
begin
	uut : somador port map (data_in => data_in, data_out => data_out);

	process
	begin
		data_in <= "0000000";
		wait for 50 ns;
		data_in <= "0000001";
		wait for 50 ns;
		wait;
	end process;
	
end architecture a_somador_tb;