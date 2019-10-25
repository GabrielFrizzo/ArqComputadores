library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula_tb is 
end entity;

architecture ula_tb of ula_tb is
	component ula is
		port(   entr0  : in unsigned(15 downto 0);
				entr1  : in unsigned(15 downto 0);
				sel_op : in std_logic;
				saida  : out unsigned(15 downto 0);
				zero   : out std_logic;
				sign   : out std_logic
		);
	end component;
	signal entr0, entr1, saida : unsigned(15 downto 0);
	signal sel_op, zero, sign : std_logic;
	
begin   
	uut: ula port map(entr0  => entr0,
					  entr1  => entr1,
					  sel_op => sel_op,
					  saida  => saida,
					  zero   => zero,
					  sign   => sign
					 );
	process
	begin       
		entr0 <="0000000000000001";      
		entr1 <="0000000000000010";
		sel_op <='0';
		wait for 50 ns;  
		entr0 <="0000000000000001";      
		entr1 <="0000000000000010";
		sel_op <='1';
		wait for 50 ns;  		
		entr0 <="0000000000000011";       
		entr1 <="0000000000000001";
		sel_op <='0';
		wait for 50 ns;
		entr0 <="0000000000000011";       
		entr1 <="0000000000000001";
		sel_op <='1';
		wait for 50 ns;
		entr0 <="0000000000000011";
		entr1 <="0000000000000011";
		sel_op <='0';
		wait for 50 ns;
		wait;
	end process;
end architecture;