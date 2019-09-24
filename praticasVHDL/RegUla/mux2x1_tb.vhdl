library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux2x1_tb is    
end entity mux2x1_tb;

architecture a_mux2x1_tb of mux2x1_tb is
    component mux2x1 is
         port( sel         : in std_logic;
               entr0       : in unsigned(15 downto 0);
               entr1       : in unsigned(15 downto 0);
               enable      : in std_logic;
               saida       : out unsigned(15 downto 0)
    );
    end component mux2x1;
    signal enable, sel : std_logic;
    signal entr0, entr1, saida : unsigned(15 downto 0);

begin
    uut: mux2x1 port map ( sel => sel,
                           entr0 => entr0,
                           entr1 => entr1,
                           enable => enable,
                           saida => saida);

    process
    begin
        enable <= '0';
        sel <= '0';
        entr0 <= "0000000000000000";
        entr1 <= "0000000000000000";
        wait for 50 ns;
        enable <= '0';
        sel <= '0';
        entr0 <= "0000000000000000";
        entr1 <= "0000000000000001";
        wait for 50 ns;
        enable <= '0';
        sel <= '0';
        entr0 <= "0000000000000001";
        entr1 <= "0000000000000000";
        wait for 50 ns;
        enable <= '0';
        sel <= '0';
        entr0 <= "0000000000000001";
        entr1 <= "0000000000000001";
        wait for 50 ns;
        enable <= '0';
        sel <= '1';
        entr0 <= "0000000000000000";
        entr1 <= "0000000000000000";
        wait for 50 ns;
        enable <= '0';
        sel <= '1';
        entr0 <= "0000000000000000";
        entr1 <= "0000000000000001";
        wait for 50 ns;
        enable <= '0';
        sel <= '1';
        entr0 <= "0000000000000001";
        entr1 <= "0000000000000000";
        wait for 50 ns;
        enable <= '0';
        sel <= '1';
        entr0 <= "0000000000000001";
        entr1 <= "0000000000000001";
        wait for 50 ns;
        enable <= '1';
        sel <= '0';
        entr0 <= "0000000000000000";
        entr1 <= "0000000000000000";
        wait for 50 ns;
        enable <= '1';
        sel <= '0';
        entr0 <= "0000000000000000";
        entr1 <= "0000000000000001";
        wait for 50 ns;
        enable <= '1';
        sel <= '0';
        entr0 <= "0000000000000001";
        entr1 <= "0000000000000000";
        wait for 50 ns;
        enable <= '1';
        sel <= '0';
        entr0 <= "0000000000000001";
        entr1 <= "0000000000000001";
        wait for 50 ns;
        enable <= '1';
        sel <= '1';
        entr0 <= "0000000000000000";
        entr1 <= "0000000000000000";
        wait for 50 ns;
        enable <= '1';
        sel <= '1';
        entr0 <= "0000000000000000";
        entr1 <= "0000000000000001";
        wait for 50 ns;
        enable <= '1';
        sel <= '1';
        entr0 <= "0000000000000001";
        entr1 <= "0000000000000000";
        wait for 50 ns;
        enable <= '1';
        sel <= '1';
        entr0 <= "0000000000000001";
        entr1 <= "0000000000000001";
        wait for 50 ns;
        wait;
    end process;

end architecture a_mux2x1_tb;