library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula_tb is 
end entity;

architecture ula_tb of ula_tb is
	component ula is
		port(   entr0, entr1 : in unsigned(15 downto 0);          
				sel_op : in unsigned(1 downto 0);
				saida : out unsigned(15 downto 0);
				equal : out std_logic
		);
	end component;
	signal entr0, entr1 : unsigned(15 downto 0);
	signal saida : unsigned(15 downto 0);
	signal sel_op : unsigned(1 downto 0);
	signal equal : std_logic;
	
begin   
	uut: ula port map(entr0=>entr0,entr1=>entr1,sel_op=>sel_op,saida=>saida,equal=>equal);
	process
	begin       
		entr0 <="0000000000000001";      
		entr1 <="0000000000000010";
		sel_op <="00";
		wait for 50 ns;  
		entr0 <="0000000000000001";      
		entr1 <="0000000000000010";
		sel_op <="01";
		wait for 50 ns;
		entr0 <="0000000000000101";      
		entr1 <="0000000000000010";
		sel_op <="10";
		wait for 50 ns;
		entr0 <="0000000000000101";      
		entr1 <="0000000000000000";
		sel_op <="10";
		wait for 50 ns;
		entr0 <="1111111111111110";      
		entr1 <="0000000000000010";
		sel_op <="10";
		wait for 50 ns;
		entr0 <="0000000000000001";      
		entr1 <="0000000000000010";
		sel_op <="11";
		wait for 50 ns;  		
		entr0 <="0000000000000011";       
		entr1 <="0000000000000001";
		sel_op <="00";
		wait for 50 ns;
		entr0 <="0000000000000011";       
		entr1 <="0000000000000001";
		sel_op <="01";
		wait for 50 ns;
		entr0 <="0000000000000011";       
		entr1 <="0000000000000001";
		sel_op <="10";
		wait for 50 ns;
		entr0 <="0000000000000011";       
		entr1 <="0000000000000001";
		sel_op <="11";
		wait for 50 ns;
		entr0 <="0000000000000011";
		entr1 <="0000000000000011";
		sel_op <="11";
		wait for 50 ns;
		wait;
	end process;
end architecture;