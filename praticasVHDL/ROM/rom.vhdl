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
        0  => "00000000000010",
        1  => "00100000000000",
        2  => "00000000000000",
        3  => "00000000000000",
        4  => "00100000000000",
        5  => "00000000000010",
        6  => "00111100000011",
        7  => "00000000000010",
        8  => "00000000000010",
        9  => "00000000000000",
        10 => "00000000100000",
        11 => "00000110000000",
        12 => "00000000100100",
        13 => "00000011111000",
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
