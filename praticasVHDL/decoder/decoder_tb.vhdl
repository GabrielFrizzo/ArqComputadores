library ieee;
use ieee.std_logic_1164.all;

entity decoder_tb is
end;

architecture a_decoder_tb of decoder_tb is
    component decoder is
        port ( in_0: in std_logic;
               in_1: in std_logic;
               out_0: out std_logic;
               out_1: out std_logic;
               out_2: out std_logic;
               out_3: out std_logic
        );
    end component decoder;
    signal in_0,in_1,out_0,out_1,out_2,out_3: std_logic;

begin
    uut: decoder port map( in_0 => in_0,
                           in_1 => in_1,
                           out_0 => out_0,
                           out_1 => out_1,
                           out_2 => out_2,
                           out_3 => out_3);

    process
    begin
        in_0 <= '0';
        in_1 <= '0';
        wait for 50 ns;
        in_0 <= '1';
        in_1 <= '0';
        wait for 50 ns;
        in_0 <= '0';
        in_1 <= '1';
        wait for 50 ns;
        in_0 <= '1';
        in_1 <= '1';
        wait for 50 ns;
        wait;
    end process;
end architecture a_decoder_tb;