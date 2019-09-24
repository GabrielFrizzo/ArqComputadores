library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula is 
	port( entr0, entr1 : in unsigned(15 downto 0);          
		  sel_op : in unsigned(1 downto 0);
		  saida : out unsigned(15 downto 0);
		  equal : out std_logic
	);
	end entity;
	
architecture aula of ula is 
	signal mult: unsigned(31 downto 0);
begin   
	mult <= entr0*entr1;
	saida <= entr0+entr1 when sel_op="00" else
			 entr0-entr1 when sel_op="01" else
			 mult(15 downto 0) when sel_op="10" else
			 "0000000000000000";
	equal <= '1' when entr0-entr1="0000000000000000" and sel_op="11" else
			 '0';
end architecture;