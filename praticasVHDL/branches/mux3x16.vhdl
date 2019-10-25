library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux3x16 is
    port( sel         : in unsigned(1 downto 0);
          entr0       : in unsigned(15 downto 0);
          entr1       : in unsigned(15 downto 0);
          entr2       : in unsigned(15 downto 0);
          saida       : out unsigned(15 downto 0)
    );
end entity mux3x16;

architecture a_mux3x16 of mux3x16 is
begin
    saida <= entr0      when sel="00"    else
             entr1      when sel="01"    else
             entr2      when sel="10"    else
             "0000000000000000";
end architecture a_mux3x16;