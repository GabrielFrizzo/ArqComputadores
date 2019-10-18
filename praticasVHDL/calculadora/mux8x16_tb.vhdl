library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux8x16_tb is
end entity mux8x16_tb;

architecture a_mux8x16_tb of mux8x16_tb is
    component mux8x16 is
        port( sel         : in unsigned(2 downto 0);
              entr0       : in unsigned(15 downto 0);
              entr1       : in unsigned(15 downto 0);
              entr2       : in unsigned(15 downto 0);
              entr3       : in unsigned(15 downto 0);
              entr4       : in unsigned(15 downto 0);
              entr5       : in unsigned(15 downto 0);
              entr6       : in unsigned(15 downto 0);
              entr7       : in unsigned(15 downto 0);
              saida       : out unsigned(15 downto 0)
    );
    end component mux8x16;
    signal sel : unsigned(2 downto 0);
    signal entr0, entr1, entr2, entr3, entr4, entr5, entr6, entr7, saida : unsigned(15 downto 0);
begin
    uut: mux8x16 port map (
            sel => sel,
            entr0 => entr0,
            entr1 => entr1,
            entr2 => entr2,
            entr3 => entr3,
            entr4 => entr4,
            entr5 => entr5,
            entr6 => entr6,
            entr7 => entr7,
            saida => saida
        );

    process
    begin
        sel <= "000";
        entr0 <= "1000000000000000";
        entr1 <= "0100000000000000";
        entr2 <= "0010000000000000";
        entr3 <= "0001000000000000";
        entr4 <= "0000100000000000";
        entr5 <= "0000010000000000";
        entr6 <= "0000001000000000";
        entr7 <= "0000000100000000";
        wait for 50 ns;
        sel <= "001";
        entr0 <= "1000000000000001";
        entr1 <= "0100000000000001";
        entr2 <= "0010000000000001";
        entr3 <= "0001000000000001";
        entr4 <= "0000100000000001";
        entr5 <= "0000010000000001";
        entr6 <= "0000001000000001";
        entr7 <= "0000000100000001";
        wait for 50 ns;
        sel <= "010";
        entr0 <= "1000000000000010";
        entr1 <= "0100000000000010";
        entr2 <= "0010000000000010";
        entr3 <= "0001000000000010";
        entr4 <= "0000100000000010";
        entr5 <= "0000010000000010";
        entr6 <= "0000001000000010";
        entr7 <= "0000000100000010";
        wait for 50 ns;
        sel <= "011";
        entr0 <= "1000000000000100";
        entr1 <= "0100000000000100";
        entr2 <= "0010000000000100";
        entr3 <= "0001000000000100";
        entr4 <= "0000100000000100";
        entr5 <= "0000010000000100";
        entr6 <= "0000001000000100";
        entr7 <= "0000000100000100";
        wait for 50 ns;
        sel <= "100";
        wait for 50 ns;
        sel <= "101";
        wait for 50 ns;
        sel <= "110";
        wait for 50 ns;
        sel <= "111";
        wait for 50 ns;
        wait;
    end process;
end architecture a_mux8x16_tb;

