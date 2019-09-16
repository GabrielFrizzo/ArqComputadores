library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity soma_e_divide_tb is
end entity soma_e_divide_tb;

architecture a_soma_e_divide_tb of soma_e_divide_tb is
    component soma_e_divide is
        port (   x,y       :  in unsigned(7 downto 0);
                 soma,quoc :  out unsigned(7 downto 0)
         );
    end component soma_e_divide;
    signal x, y, soma, quoc: unsigned(7 downto 0);

begin
    uut: soma_e_divide port map ( x => x,
                                  y => y,
                                  soma => soma,
                                  quoc => quoc);
    process
    begin
        x <= "00000000";
        y <= "00000001";
        wait for 50 ns;
        x <= "00000010";
        y <= "00000111";
        wait for 50 ns;
        x <= "11111100";
        y <= "00000100";
        wait for 50 ns;
        x <= "00000101";
        y <= "00000101";
        wait for 50 ns;
        x <= "11111111";
        y <= "11111101";
        wait for 50 ns;
        wait;
    end process;
end architecture a_soma_e_divide_tb;