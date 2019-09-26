library ieee;
use ieee.std_logic_1164.all;

entity maq_estados is
    port ( 
        clk : in std_logic;
        rst : in std_logic;
        estado : out std_logic
    );
end entity maq_estados;

architecture a_maq_estados of maq_estados is
    signal registro: std_logic;
begin
    process(clk,rst)
    begin
        if rst = '1' then
            registro <= '0';
        elsif rising_edge(clk) then
            registro <= not(registro);
        end if;
    end process;

    estado <= registro;
end architecture a_maq_estados;
