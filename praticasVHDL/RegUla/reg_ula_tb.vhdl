library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg_ula_tb is
end entity reg_ula_tb;

architecture a_reg_ula_tb of reg_ula_tb is
    component reg_ula is
        port (
            clk             : in std_logic;
            wr_enable       : in std_logic;
            rst             : in std_logic;
            sel_reg_read1   : in unsigned(2 downto 0);
            sel_reg_read2   : in unsigned(2 downto 0);
            sel_reg_write   : in unsigned(2 downto 0);
            sel_ula_op      : in unsigned(1 downto 0);
            sel_mux_const   : in std_logic;
            ext_const       : in unsigned(15 downto 0);
            saida1          : out unsigned(15 downto 0);
            saida2          : out unsigned(15 downto 0);
            ula_out         : out unsigned(15 downto 0);
            ula_equal_out   : out std_logic
        );
    end component reg_ula;
    signal clk, wr_enable, rst, sel_mux_const, ula_equal_out : std_logic;
    signal sel_reg_read1, sel_reg_read2, sel_reg_write : unsigned(2 downto 0);
    signal sel_ula_op : unsigned(1 downto 0);
    signal ext_const, saida1, saida2, ula_out : unsigned(15 downto 0);
begin
    uut : reg_ula port map (
        clk => clk,
        wr_enable => wr_enable,
        rst => rst,
        sel_reg_read1 => sel_reg_read1,
        sel_reg_read2 => sel_reg_read2,
        sel_reg_write => sel_reg_write,
        sel_ula_op => sel_ula_op,
        sel_mux_const => sel_mux_const,
        ext_const => ext_const,
        saida1 => saida1,
        saida2 => saida2,
        ula_out => ula_out,
        ula_equal_out => ula_equal_out
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
        wait for 75 ns;
        rst <= '0';
        wait;
    end process;

    process
    begin
        sel_ula_op <= "00";
        wait;
    end process;

    process
    begin
        sel_reg_read1 <= "000";
        sel_reg_read2 <= "001";
        sel_reg_write <= "000";
        wr_enable     <= '0';
        sel_mux_const <= '0';
        ext_const     <= "0000000001000000";
        wait for 200 ns;
        sel_mux_const <= '1';
        wait for 200 ns;
        sel_reg_write <= "010";
        wr_enable     <= '1';
        wait for 200 ns;
        sel_mux_const <= '0';
        sel_reg_read1 <= "010";
        sel_reg_read2 <= "010";
        sel_reg_write <= "011";
        wait for 200 ns;
        sel_reg_read1 <= "011";
        sel_reg_read2 <= "011";
        sel_reg_write <= "011";
        wait for 200 ns;
        sel_reg_read1 <= "010";
        sel_reg_read2 <= "011";
        wr_enable     <= '0';
        wait;
    end process;
end architecture a_reg_ula_tb;
