library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula is 
	port( entr0  : in unsigned(15 downto 0);
		  entr1  : in unsigned(15 downto 0);
		  sel_op : in std_logic;
		  saida  : out unsigned(15 downto 0);
		  zero   : out std_logic;
		  sign 	 : out std_logic
	);
end entity;
	
architecture a_ula of ula is
	signal compare : unsigned(15 downto 0);
begin
	saida <= entr0+entr1 when sel_op='0' else
			 entr0-entr1 when sel_op='1' else
			 "0000000000000000";

	zero <= '1' when entr0-entr1="0000000000000000" else
			'0';

	compare <= entr0 - entr1;
	sign <= compare(15);
end architecture;