library ieee;
use ieee.std_logic_1164.all;

entity mux2x1 is
    port( sel         : in std_logic;
          entr0,entr1 : in std_logic;
          enable      : in std_logic;
          saida       : out std_logic
    );
end entity mux2x1;

architecture a_mux2x1 of mux2x1 is
begin
    saida <= '0'   when enable='0' else
             entr0 when sel='0'    else
             entr1 when sel='1'    else
             '0';
end architecture a_mux2x1;