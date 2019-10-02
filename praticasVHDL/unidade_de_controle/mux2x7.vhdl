library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux2x7 is
    port( sel         : in std_logic;
          entr0       : in unsigned(6 downto 0);
          entr1       : in unsigned(6 downto 0);
          saida       : out unsigned(6 downto 0)
    );
end entity mux2x7;

architecture a_mux2x7 of mux2x7 is
begin
    saida <= entr0      when sel='0'    else
             entr1      when sel='1'    else
             "0000000";
end architecture a_mux2x7;