library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity flags is
    port (
    		clk      : in std_logic;
    		rst	     : in std_logic;
    		wr_en    : in std_logic;
            zero_in  : in std_logic;
            sign_in  : in std_logic;
            zero_out : out std_logic;
            sign_out : out std_logic
         );
end entity flags;

architecture a_flags of flags is
	signal zero, sign : std_logic;
begin
	process(clk,rst,wr_en)
    begin
        if rst = '1' then
            zero <= '0';
            sign <= '0';
        elsif wr_en = '1' then
            if rising_edge(clk) then
                zero <= zero_in;
            	sign <= sign_in;
            end if;
        end if;
    end process;

    zero_out <= zero;
    sign_out <= sign;
end architecture a_flags;
