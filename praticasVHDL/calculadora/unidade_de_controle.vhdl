library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity unidade_de_controle is
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
end entity unidade_de_controle;

architecture a_unidade_de_controle of unidade_de_controle is
	signal opcode : unsigned(3 downto 0);
begin
	opcode <= instruction(13 downto 10);

	jump <= '1' when opcode = "1000" else
				'0';

	regwrite <= '1' when opcode = "0010" or
					     opcode = "0011" or
					     opcode = "0100" or
					     opcode = "0101" or
					     opcode = "0110" else
			    '0';

	ulasrca <= '1' when opcode = "0010" or opcode = "0110" else
			   '0';

	ulasrcb <= '0' when opcode(3 downto 1) = "001" else
			   '1';

	ula_op <= '1' when opcode = "0010" or
					   opcode = "0100" or
					   opcode = "0110" else
			  '0';

	operror <= '0' when opcode = "0000" or
						opcode = "0010" or
						opcode = "0011" or
						opcode = "0100" or
						opcode = "0101" or
						opcode = "0110" or
						opcode = "1000" else
			   '1';
end architecture a_unidade_de_controle;
