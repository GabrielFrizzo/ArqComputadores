library ieee;
use ieee.std_logic_1164.all;

entity maq_estados_tb is
end entity maq_estados_tb;

architecture a_maq_estados_tb of maq_estados_tb is
    component maq_estados is
        port ( 
            clk : in std_logic;
            rst : in std_logic;
            estado : out std_logic
        );
    end component maq_estados;
    signal clk ,rst ,estado : std_logic;
begin
    uut : maq_estados port map( clk => clk,
                                rst => rst,
                                estado => estado
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
