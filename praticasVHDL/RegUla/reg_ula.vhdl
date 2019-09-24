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
        ula_equal_out   : out unsigned(15 downto 0)
    );
end entity reg_ula;

architecture a_reg_ula of reg_ula is
    component mux2x1 is
        port (
            sel         : in std_logic;
            entr0,entr1 : in std_logic;
            enable      : in std_logic;
            saida       : out std_logic
        );
    end component mux2x1;
    signal saida_mux_const : std_logic;

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
    signal saida1, saida2 : unsigned(15 downto 0);

    component ula is
        port (
            entr0, entr1 : in unsigned(15 downto 0);          
            sel_op       : in unsigned(1 downto 0);
            saida        : out unsigned(15 downto 0);
            equal        : out std_logic
        );
    end component ula;
begin
    --ula_inst : ula port map(entr0   => saida1,
    --                        entr1   => saida_mux_const,
    --                        sel_op  => sel_ula_op,
    --                        saida   => 
    --                        );
end architecture a_reg_ula;