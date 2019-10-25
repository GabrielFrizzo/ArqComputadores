library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity maq_estados is
    port ( 
        clk : in std_logic;
        rst : in std_logic;
        estado : out unsigned(1 downto 0)
    );
end entity maq_estados;

architecture a_maq_estados of maq_estados is
    signal registro: unsigned(1 downto 0);
begin
    process(clk,rst)
    begin
        if rst = '1' then
            registro <= "00";
        elsif rising_edge(clk) then
            if registro="01" then
                registro <= "00";
            else
                registro <= registro+1;
            end if;
        end if;
    end process;

    estado <= registro;
end architecture a_maq_estados;
