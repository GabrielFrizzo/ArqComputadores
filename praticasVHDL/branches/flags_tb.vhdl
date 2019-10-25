library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity flags_tb is
end entity flags_tb;

architecture a_flags_tb of flags_tb is
	component flags is
		port (
			clk      : in std_logic;
    		rst	     : in std_logic;
    		wr_en    : in std_logic;
            zero_in  : in std_logic;
            sign_in  : in std_logic;
            zero_out : out std_logic;
            sign_out : out std_logic 
		);
	end component flags;
	signal  clk, rst, wr_en, zero_in, sign_in, zero_out, sign_out: std_logic;
begin
	uut : flags port map(clk => clk,
						 rst => rst,
						 wr_en => wr_en,
						 zero_in => zero_in,
						 sign_in => sign_in,
						 zero_out => zero_out,
						 sign_out => sign_out
						);

	process
	begin
		clk <= '0';
		wait for 50 ns;
		clk <= '1';
		wait for 50 ns;
	end process;

	process
	begin
		rst <= '1';
		wr_en <= '0';
		wait for 50 ns;
		rst <= '0';
		wait for 100 ns;
		wr_en <= '1';
		wait;
	end process;

	process
	begin
		zero_in <= '1';
		sign_in <= '0';
		wait for 100 ns;
		zero_in <= '0';
		sign_in <= '0';
		wait for 100 ns;
		zero_in <= '1';
		sign_in <= '1';
		wait for 100 ns;
		zero_in <= '0';
		sign_in <= '1';
		wait for 100 ns;
		wait;
	end process;
end architecture a_flags_tb;
