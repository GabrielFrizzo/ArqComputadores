library ieee;
use ieee.std_logic_1164.all;

entity somador_tb is
end entity somador_tb;

architecture a_somador_tb of somador_tb is
    component somador is
        port ( a: in std_logic;
               b: in std_logic;
               cin: in std_logic;
               cout: out std_logic;
               res: out std_logic
        );
    end component somador;
    signal a,b,cin,cout,res: std_logic;

begin
    uut: somador port map ( a => a,
                            b => b,
                            cin => cin,
                            cout => cout,
                            res => res);

    process
    begin
        a <= '0';
        b <= '0';
        cin <= '0';
        wait for 50 ns;
        a <= '0';
        b <= '1';
        cin <= '0';
        wait for 50 ns;
        a <= '1';
        b <= '0';
        cin <= '0';
        wait for 50 ns;
        a <= '1';
        b <= '1';
        cin <= '0';
        wait for 50 ns;
        a <= '0';
        b <= '0';
        cin <= '1';
        wait for 50 ns;
        a <= '1';
        b <= '0';
        cin <= '1';
        wait for 50 ns;
        a <= '0';
        b <= '1';
        cin <= '1';
        wait for 50 ns;
        a <= '1';
        b <= '1';
        cin <= '1';
        wait for 50 ns;
        wait;
    end process;
end architecture a_somador_tb;