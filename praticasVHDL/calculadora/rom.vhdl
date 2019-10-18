library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom is port( 
                    clk : in std_logic;
                    endereco : in unsigned(6 downto 0);
                    dado     : out unsigned(13 downto 0)
                    );
end entity;

architecture a_rom of rom is
    type mem is array (0 to 127) of unsigned(13 downto 0);
    constant conteudo_rom : mem := (
        -- caso endereco => conteudo
        0  => "00000000000000",
        1  => "00000000000000",
        2  => "10000000000100",
        3  => "11100000000000",
        4  => "00000000000000",
        5  => "00000000000000",
        6  => "10000000000111",
        7  => "10000000001001",
        8  => "10000000001010",
        9  => "10000000001000",
        10 => "00000000000000",
        11 => "10000000000011",
        12 => "00000000000000",
        13 => "10000000000000",
        -- abaixo: casos omissos => (zero em todos os bits)
        others => (others=>'0')
    );

begin
    process(clk)
    begin
        if(rising_edge(clk)) then
            dado <= conteudo_rom(to_integer(endereco));
        end if;
    end process;
end architecture;
