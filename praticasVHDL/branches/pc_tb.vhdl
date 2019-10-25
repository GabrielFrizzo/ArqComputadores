library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc_tb is
end entity pc_tb;

architecture a_pc_tb of pc_tb is
	component pc is
		port (
			rst : in std_logic;
	        clk : in std_logic;
	        wr_en : in std_logic;
	        data_in : in unsigned(6 downto 0);
	        data_out : out unsigned(6 downto 0)
		);
	end component pc;
	signal rst, clk, wr_en : std_logic;
	signal data_in, data_out : unsigned(6 downto 0);
begin
	uut : pc port map(
						rst => rst,
						clk => clk,
						wr_en => wr_en,
						data_in => data_in,
						data_out => data_out
					 );

	process
	begin
		clk <= '1';
		wait for 50 ns;
		clk <= '0';
		wait for 50 ns;
	end process;

	process
	begin
		wr_en <= '1';
		rst <= '1';
		wait for 10 ns;
		rst <= '0';
		wait;
	end process;

	process
	begin
		data_in  <= "1111111";
        wait for 200 ns;
        data_in  <= "1010101";
        wait for 100 ns;
        data_in  <= "1010101";
        wait for 100 ns;
        data_in  <= "1010101";
        wait;
	end process;
	
end architecture a_pc_tb;