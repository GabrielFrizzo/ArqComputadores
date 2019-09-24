library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity banco_reg_tb is
end entity banco_reg_tb;

architecture a_banco_reg_tb of banco_reg_tb is
    component banco_reg is
        port (
            sel_reg_read1 : in unsigned(2 downto 0);
            sel_reg_read2 : in unsigned(2 downto 0);
            sel_reg_write : in unsigned(2 downto 0);
            write_in      : in unsigned(15 downto 0);
            wr_enable     : in std_logic;
            clk           : in std_logic;
            rst           : in std_logic;
            saida1      : out unsigned(15 downto 0);
            saida2      : out unsigned(15 downto 0)
        );
    end component banco_reg;

    signal sel_reg_read1, sel_reg_read2, sel_reg_write : unsigned(2 downto 0);
    signal write_in : unsigned(15 downto 0);
    signal wr_enable, clk, rst : std_logic;
    signal saida1, saida2 : unsigned(15 downto 0);
begin
    uut: banco_reg port map ( sel_reg_read1 => sel_reg_read1,
                              sel_reg_read2 => sel_reg_read2,
                              sel_reg_write => sel_reg_write,
                              write_in => write_in,
                              wr_enable => wr_enable,
                              clk => clk,
                              rst => rst,
                              saida1 => saida1,
                              saida2 => saida2
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
        wr_enable <= '0';
        wait for 300 ns;
        wr_enable <= '1';
        wait;
    end process;

    process
    begin
        wait for 100 ns;
        sel_reg_read1 <= "000";
        sel_reg_read2 <= "001";
        sel_reg_write <= "010";
        write_in <= "1010101010101010";
        wait for 100 ns;
        sel_reg_read1 <= "010";
        sel_reg_read2 <= "011";
        sel_reg_write <= "101";
        write_in <= "1011011011011011";
        wait for 100 ns;
        sel_reg_read1 <= "100";
        sel_reg_read2 <= "101";
        sel_reg_write <= "110";
        write_in <= "1101101101101101";
        wait for 100 ns;
        sel_reg_read1 <= "110";
        sel_reg_read2 <= "111";
        sel_reg_write <= "111";
        write_in <= "1111111111111111";
        wait for 100 ns;
    end process;
end architecture a_banco_reg_tb;
