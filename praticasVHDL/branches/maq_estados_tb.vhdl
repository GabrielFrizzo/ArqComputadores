library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity maq_estados_tb is
end entity maq_estados_tb;

architecture a_maq_estados_tb of maq_estados_tb is
    component maq_estados is
        port ( 
            clk : in std_logic;
            rst : in std_logic;
            estado : out unsigned(1 downto 0)
        );
    end component maq_estados;
    signal clk ,rst : std_logic;
    signal estado_s : unsigned(1 downto 0);
begin
    uut : maq_estados port map( clk => clk,
                                rst => rst,
                                estado => estado_s
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
        wait for 200 ns;
        rst <= '0';
        wait;
    end process;
end architecture a_maq_estados_tb;
