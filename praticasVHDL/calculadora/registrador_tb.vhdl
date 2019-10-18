library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity registrador_tb is
end entity registrador_tb;

architecture a_registrador_tb of registrador_tb is
    component registrador is
        port ( 
            clk : in std_logic;
            rst : in std_logic;
            wr_en : in std_logic;
            data_in : in unsigned(15 downto 0);
            data_out : out unsigned(15 downto 0)
        );
    end component registrador;
    signal clk, rst, wr_en : std_logic;
    signal data_in, data_out : unsigned(15 downto 0);
begin
    uut: registrador port map(clk => clk,
                              rst => rst,
                              wr_en => wr_en,
                              data_in => data_in,
                              data_out => data_out
        );
    process
    begin
        clk <= '0';
        wait for 50 ns;
        clk <= '1';
        wait for 50 ns;
    end process;

    process
    begin
        rst <= '1';
        wait for 100 ns;
        rst <= '0';
        wait;
    end process;

    process
    begin
        wait for 100 ns;
        wr_en <= '0';
        data_in  <= "1111111111111111";
        wait for 100 ns;
        wr_en <= '1';
        data_in  <= "1010101010101010";
        wait for 100 ns;
        data_in  <= "1010101111010100";
        wait for 100 ns;
        wr_en <= '0';
        data_in  <= "1010101111010100";
    end process;

end architecture a_registrador_tb;