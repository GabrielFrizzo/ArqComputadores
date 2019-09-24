library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity banco_reg is
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
end entity banco_reg;

architecture a_banco_reg of banco_reg is
    component mux3x1 is
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
    end component mux3x1;

    component registrador is
        port ( 
            clk : in std_logic;
            rst : in std_logic;
            wr_en : in std_logic;
            data_in : in unsigned(15 downto 0);
            data_out : out unsigned(15 downto 0)
        );
    end component registrador;
    signal reg0_out ,reg1_out ,reg2_out ,reg3_out ,reg4_out ,reg5_out ,reg6_out ,reg7_out : unsigned(15 downto 0);
    signal wr_en0 ,wr_en1 ,wr_en2 ,wr_en3 ,wr_en4 ,wr_en5 ,wr_en6 ,wr_en7 : std_logic;
begin
    mux_read1: mux3x1 port map(sel=>sel_reg_read1, entr0=>reg0_out, entr1=>reg1_out, entr2=>reg2_out, entr3=>reg3_out, entr4=>reg4_out, entr5=>reg5_out, entr6=>reg6_out, entr7=>reg7_out, saida=>saida1);
    mux_read2: mux3x1 port map(sel=>sel_reg_read2, entr0=>reg0_out, entr1=>reg1_out, entr2=>reg2_out, entr3=>reg3_out, entr4=>reg4_out, entr5=>reg5_out, entr6=>reg6_out, entr7=>reg7_out, saida=>saida2);
    reg0: registrador port map(clk=>clk, rst=>rst, wr_en=>wr_en0, data_in=>write_in, data_out=>reg0_out);
    reg1: registrador port map(clk=>clk, rst=>rst, wr_en=>wr_en1, data_in=>write_in, data_out=>reg1_out);
    reg2: registrador port map(clk=>clk, rst=>rst, wr_en=>wr_en2, data_in=>write_in, data_out=>reg2_out);
    reg3: registrador port map(clk=>clk, rst=>rst, wr_en=>wr_en3, data_in=>write_in, data_out=>reg3_out);
    reg4: registrador port map(clk=>clk, rst=>rst, wr_en=>wr_en4, data_in=>write_in, data_out=>reg4_out);
    reg5: registrador port map(clk=>clk, rst=>rst, wr_en=>wr_en5, data_in=>write_in, data_out=>reg5_out);
    reg6: registrador port map(clk=>clk, rst=>rst, wr_en=>wr_en6, data_in=>write_in, data_out=>reg6_out);
    reg7: registrador port map(clk=>clk, rst=>rst, wr_en=>wr_en7, data_in=>write_in, data_out=>reg7_out);

    wr_en0 <= wr_enable when sel_reg_write = "000" else '0';
    wr_en1 <= wr_enable when sel_reg_write = "001" else '0';
    wr_en2 <= wr_enable when sel_reg_write = "010" else '0';
    wr_en3 <= wr_enable when sel_reg_write = "011" else '0';
    wr_en4 <= wr_enable when sel_reg_write = "100" else '0';
    wr_en5 <= wr_enable when sel_reg_write = "101" else '0';
    wr_en6 <= wr_enable when sel_reg_write = "110" else '0';
    wr_en7 <= wr_enable when sel_reg_write = "111" else '0';
end architecture a_banco_reg;
