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
            estado		: in unsigned(1 downto 0);
            jump		: out unsigned(1 downto 0);
            ulasrca		: out unsigned(1 downto 0);
            ulasrcb		: out std_logic;
            ula_op		: out std_logic;
            pc_en		: out std_logic;
            banco_en	: out std_logic;
            flags_en	: out std_logic;
            operror		: out std_logic
		);
	end component unidade_de_controle;
	signal instruction : unsigned(13 downto 0);
	signal zero, sign, ulasrcb, ula_op, pc_en, banco_en, flags_en, operror: std_logic;
	signal jump, estado, ulasrca : unsigned(1 downto 0);
begin
	uut : unidade_de_controle port map(instruction => instruction,
									   zero => zero,
									   sign => sign,
									   jump => jump,
									   estado => estado,
									   ulasrca => ulasrca,
									   ulasrcb => ulasrcb,
									   ula_op => ula_op,
									   pc_en => pc_en,
									   banco_en => banco_en,
									   flags_en => flags_en,
									   operror => operror
									  );

	process
	begin
		instruction <= "00000000000000";
		estado <= "00";
		zero <= '0';
		sign <= '1';
		wait for 50 ns;
		instruction <= "00100000000000";
		estado <= "01";
		zero <= '1';
		sign <= '1';
		wait for 50 ns;
		instruction <= "00110000000000";
		estado <= "00";
		zero <= '1';
		sign <= '0';
		wait for 50 ns;
		instruction <= "01000000000000";
		estado <= "01";
		zero <= '1';
		sign <= '1';
		wait for 50 ns;
		instruction <= "01010000000000";
		estado <= "01";
		zero <= '0';
		sign <= '0';
		wait for 50 ns;
		instruction <= "01100000000000";
		estado <= "00";
		zero <= '1';
		sign <= '0';
		wait for 50 ns;
		instruction <= "10000000000000";
		estado <= "01";
		zero <= '0';
		sign <= '1';
		wait for 50 ns;
		instruction <= "11110000000000";
		estado <= "00";
		zero <= '0';
		sign <= '1';
		wait for 50 ns;
		wait;
	end process;
end architecture a_unidade_de_controle_tb;
