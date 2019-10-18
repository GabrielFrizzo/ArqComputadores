library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity unidade_de_controle_tb is
end entity unidade_de_controle_tb;

architecture a_unidade_de_controle_tb of unidade_de_controle_tb is
	component unidade_de_controle is
		port (
			instruction : in unsigned(13 downto 0);
            zero		: in std_logic;
            sign		: in std_logic;
            jump		: out std_logic;
            regwrite	: out std_logic;
            ulasrca		: out std_logic;
            ulasrcb		: out std_logic;
            ula_op		: out std_logic;
            operror		: out std_logic
		);
	end component unidade_de_controle;
	signal instruction : unsigned(13 downto 0);
	signal zero, sign, jump, regwrite, ulasrca, ulasrcb, ula_op, operror: std_logic;
begin
	uut : unidade_de_controle port map(instruction => instruction,
										  zero => zero,
										  sign => sign,
										  jump => jump,
										  regwrite => regwrite,
										  ulasrca => ulasrca,
										  ulasrcb => ulasrcb,
										  ula_op => ula_op,
										  operror => operror
										 );

	process
	begin
		instruction <= "00000000000000";
		wait for 50 ns;
		instruction <= "00100000000000";
		wait for 50 ns;
		instruction <= "00110000000000";
		wait for 50 ns;
		instruction <= "01000000000000";
		wait for 50 ns;
		instruction <= "01010000000000";
		wait for 50 ns;
		instruction <= "01100000000000";
		wait for 50 ns;
		instruction <= "10000000000000";
		wait for 50 ns;
		instruction <= "11110000000000";
		wait for 50 ns;
		wait;
	end process;
end architecture a_unidade_de_controle_tb;
