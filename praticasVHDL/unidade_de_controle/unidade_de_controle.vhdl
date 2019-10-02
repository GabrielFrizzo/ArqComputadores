library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity unidade_de_controle is
    port (
            rst : in std_logic;
            clk : in std_logic;
            err_sig : out std_logic;
            saida : out unsigned(13 downto 0)
         );
end entity unidade_de_controle;

architecture a_unidade_de_controle of unidade_de_controle is
    component pc is
        port (
            rst : in std_logic;
            clk : in std_logic;
            wr_en : in std_logic;
            data_in : in unsigned(6 downto 0);
            data_out : out unsigned(6 downto 0)
        );  
    end component pc;
    signal data_out_p : unsigned(6 downto 0);

    component somador is
        port (
            data_in : in unsigned(6 downto 0);
            data_out : out unsigned(6 downto 0)
        );
    end component somador;
    signal data_in_s, data_out_s : unsigned(6 downto 0);

    component rom is
        port (
            clk : in std_logic;
            endereco : in unsigned(6 downto 0);
            dado     : out unsigned(13 downto 0)
        );
    end component rom;
    signal saida_r : unsigned(13 downto 0);

    component maq_estados is
        port (
            clk : in std_logic;
            rst : in std_logic;
            estado : out std_logic
        );
    end component maq_estados;
    signal estado, not_estado : std_logic;

    component registrador is
        port (
            clk : in std_logic;
            rst : in std_logic;
            wr_en : in std_logic;
            data_in : in unsigned(13 downto 0);
            data_out : out unsigned(13 downto 0)
        );
    end component registrador;

    component mux2x7 is
        port (
              sel         : in std_logic;
              entr0       : in unsigned(6 downto 0);
              entr1       : in unsigned(6 downto 0);
              saida       : out unsigned(6 downto 0)
        );
    end component mux2x7;
    signal prox_end : unsigned(6 downto 0);

    signal opcode : unsigned(2 downto 0);
    signal jump_sel : std_logic;
    signal operror, pc_enable : std_logic;
begin
    pc_inst : pc port map (rst => rst, clk => clk, wr_en => pc_enable, data_in => prox_end, data_out => data_out_p);
    somador_inst : somador port map (data_in => data_out_p, data_out => data_out_s);
    rom_inst : rom port map (clk => clk, endereco => data_out_p, dado => saida_r);
    maq_estados_inst : maq_estados port map (clk => clk, rst => rst, estado => estado);
    reg_saida : registrador port map (clk => clk, rst => rst, wr_en => not_estado, data_in => saida_r, data_out => saida);
    mux_prox_end : mux2x7 port map (sel => jump_sel, entr0 => data_out_s, entr1 => saida_r(6 downto 0), saida => prox_end);
    not_estado <= not(estado);

    opcode <= saida_r(13 downto 11);
    jump_sel <= '1' when opcode = "100" else
                '0';
    operror <= '0' when opcode = "100" or opcode = "000" else
               '1';
    err_sig <= operror;
    pc_enable <= not(operror) and estado;
end architecture a_unidade_de_controle;
