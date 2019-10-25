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
        0  => "00100110000000", -- carrega R3 com 0
        1  => "00101000000000", -- carrega R4 com 0
        2  => "01101000000011", -- soma R3 com R4 e guarda em R4
        3  => "00110111000011", -- soma 1 em R3
        4  => "00110110011100", -- se R3<30 salta para a instrução do passo 3
        5  => "10100001111101", 
        6  => "01101010000100", -- copia valor de R4 para R5
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
