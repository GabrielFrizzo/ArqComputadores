library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity unidade_de_controle is
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
end entity unidade_de_controle;

architecture a_unidade_de_controle of unidade_de_controle is
	signal opcode 		  : unsigned(3 downto 0);
	signal fetch, execute : std_logic;
	signal opcode_error	  : std_logic;
begin
	operror <= opcode_error;

	fetch   <= '1' when estado = "00" else
               '0';
    execute <= '1' when estado = "01" else
               '0';

	opcode <= instruction(13 downto 10);

	jump <= "01" when opcode = "1000" else
			"10" when (opcode = "1001" and zero = '1') or
					  (opcode = "1010" and sign = '1') else
			"00";

	banco_en <= '1' when (opcode  = "0010"  or
					      opcode  = "0011"  or
					      opcode  = "0100"  or
					      opcode  = "0101"  or
					      opcode  = "0110") and
					      execute = '1'	    else
			    '0';

	ulasrca <= "00" when opcode = "0010" or opcode = "0110" else
			   "10" when opcode = "1001" or
					     opcode = "1010" else
			   "01";

	ulasrcb <= '1' when opcode(3 downto 1) = "001" or
						opcode = "1001" or
						opcode = "1010" else
			   '0';

	ula_op <= '1' when opcode = "0011" or
					   opcode = "0101" else
			  '0';

	pc_en  <= '1' when fetch = '1' and opcode_error = '0' else
			  '0';

	flags_en <= '1' when opcode = "0011" or
						 opcode = "0101" else
				'0';

	opcode_error <= '0' when opcode = "0000" or
							 opcode = "0010" or
							 opcode = "0011" or
							 opcode = "0100" or
							 opcode = "0101" or
							 opcode = "0110" or
							 opcode = "1000" or
							 opcode = "1001" or
							 opcode = "1010" else
			   		'1';
end architecture a_unidade_de_controle;
