library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg_ula is
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
end entity reg_ula;

architecture a_reg_ula of reg_ula is
    component mux2x1 is
        port(
            sel         : in std_logic;
            entr0,entr1 : in unsigned(15 downto 0);
            enable      : in std_logic;
            saida       : out unsigned(15 downto 0)
    );
    end component mux2x1;
    signal saida_mux_const : unsigned(15 downto 0);

    component banco_reg is
        port (
            sel_reg_read1 : in unsigned(2 downto 0);
            sel_reg_read2 : in unsigned(2 downto 0);
            sel_reg_write : in unsigned(2 downto 0);
            write_in      : in unsigned(15 downto 0);
            wr_enable     : in std_logic;
            clk           : in std_logic;
            rst           : in std_logic;
            saida1        : out unsigned(15 downto 0);
            saida2        : out unsigned(15 downto 0)
        );
    end component banco_reg;
    signal saida1_banco, saida2_banco : unsigned(15 downto 0);

    component ula is
        port (
            entr0, entr1 : in unsigned(15 downto 0);          
            sel_op       : in unsigned(1 downto 0);
            saida        : out unsigned(15 downto 0);
            equal        : out std_logic
        );
    end component ula;
    signal ula_out_s   : unsigned(15 downto 0);
begin
    ula_inst : ula port map(entr0   => saida1_banco,
                            entr1   => saida_mux_const,
                            sel_op  => sel_ula_op,
                            saida   => ula_out_s,
                            equal   => ula_equal_out
                            );
    banco_reg_inst : banco_reg port map(sel_reg_read1   => sel_reg_read1,
                                        sel_reg_read2   => sel_reg_read2,
                                        sel_reg_write   => sel_reg_write,
                                        write_in        => ula_out_s,
                                        wr_enable       => wr_enable,
                                        clk             => clk,
                                        rst             => rst,
                                        saida1          => saida1_banco,
                                        saida2          => saida2_banco
                                        );

    mux_sel_const: mux2x1 port map(sel      => sel_mux_const,
                                   entr0    => saida2_banco,
                                   entr1    => ext_const,
                                   enable   => '1',
                                   saida    => saida_mux_const
                                   );
    ula_out <= ula_out_s;
    saida1 <= saida1_banco;
    saida2 <= saida2_banco;
end architecture a_reg_ula;