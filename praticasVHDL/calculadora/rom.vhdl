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
        0  => "00100110000101", -- carrega R3 com 5
        1  => "00101000001000", -- carrega R4 com 8
        2  => "01101010000011", -- soma R3 com R4 e guarda em R5
        3  => "01001010000100", 
        4  => "00111010000001", -- subtrai 1 de R5
        5  => "10000000010100", -- salta para o endereço 20
        6  => "11111111111111",
        7  => "11111111111111",
        8  => "11111111111111",
        9  => "11111111111111",
        10 => "11111111111111",
        11 => "11111111111111",
        12 => "11111111111111",
        13 => "11111111111111",
        14 => "11111111111111",
        15 => "11111111111111",
        16 => "11111111111111",
        17 => "11111111111111",
        18 => "11111111111111",
        19 => "11111111111111",
        20 => "01100110000101", -- copia R5 para R3
        21 => "10000000000010", -- salta para a terceira instrução desta lista
        22 => "11111111111111",
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
