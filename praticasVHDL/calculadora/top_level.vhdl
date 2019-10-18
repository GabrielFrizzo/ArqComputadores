library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_level is
    port (
            rst         : in std_logic;
            clk         : in std_logic;
            err_sig     : out std_logic;
            saida_rom   : out unsigned(13 downto 0);
            saida_pc    : out unsigned(6 downto 0);
            saida_reg_1 : out unsigned(15 downto 0);
            saida_reg_2 : out unsigned(15 downto 0);
            saida_ula   : out unsigned(15 downto 0)
         );
end entity top_level;

architecture a_top_level of top_level is
    component unidade_de_controle is
      port (
            instruction : in unsigned(13 downto 0);
            zero    : in std_logic;
            sign    : in std_logic;
            jump    : out std_logic;
            regwrite  : out std_logic;
            ulasrca   : out std_logic;
            ulasrcb   : out std_logic;
            ula_op    : out std_logic;
            operror   : out std_logic
      );
    end component unidade_de_controle;
    signal jump, regwrite, ulasrca, ulasrcb, ula_op, operror : std_logic;

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
    signal data_out_s : unsigned(6 downto 0);

    component rom is
        port (
            clk : in std_logic;
            endereco : in unsigned(6 downto 0);
            dado     : out unsigned(13 downto 0)
        );
    end component rom;
    signal instruction : unsigned(13 downto 0);

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
    signal b_reg1, b_reg2 : unsigned(15 downto 0);

    component ula is
        port (
            entr0  : in unsigned(15 downto 0);
            entr1  : in unsigned(15 downto 0);
            sel_op : in std_logic;
            saida  : out unsigned(15 downto 0);
            zero   : out std_logic;
            sign   : out std_logic
        );
    end component ula;
    signal ula_out : unsigned(15 downto 0);
    signal zero, sign : std_logic;

    component maq_estados is
        port (
            clk : in std_logic;
            rst : in std_logic;
            estado : out unsigned(1 downto 0)
        );
    end component maq_estados;
    signal estado : unsigned(1 downto 0);

    component mux2x7 is
        port (
              sel         : in std_logic;
              entr0       : in unsigned(6 downto 0);
              entr1       : in unsigned(6 downto 0);
              saida       : out unsigned(6 downto 0)
        );
    end component mux2x7;
    signal prox_end : unsigned(6 downto 0);

    component mux2x16 is
        port (
            sel         : in std_logic;
            entr0       : in unsigned(15 downto 0);
            entr1       : in unsigned(15 downto 0);
            saida       : out unsigned(15 downto 0)
        );
    end component mux2x16;
    signal ula_a, ula_b : unsigned(15 downto 0);

    component sign_ext is
        port (
              entr  : in unsigned(6 downto 0);
              saida : out unsigned(15 downto 0)
        );
    end component sign_ext;
    signal const_extendida : unsigned(15 downto 0);

    signal pc_interrupt : std_logic;
    signal fetch, execute : std_logic;
    signal banco_en : std_logic; --colocar isso na un de controle
begin
    err_sig <= operror;
    pc_interrupt <= not(operror) and fetch;
    saida_rom <= instruction;
    saida_pc <= data_out_p;
    saida_reg_1 <= b_reg1;
    saida_reg_2 <= b_reg2;
    saida_ula <= ula_out;

    fetch <= '1' when estado = "00" else
             '0';
    execute <= '1' when estado = "01" else
               '0';

    unidade_de_controle_inst : unidade_de_controle port map (instruction => instruction,
                                                             zero => zero,
                                                             sign => sign,
                                                             jump => jump,
                                                             regwrite => regwrite,
                                                             ulasrca => ulasrca,
                                                             ulasrcb => ulasrcb,
                                                             ula_op => ula_op,
                                                             operror => operror
                                                            );

    pc_inst : pc port map (rst => rst,
                           clk => clk,
                           wr_en => fetch,
                           data_in => prox_end,
                           data_out => data_out_p);
    
    somador_inst : somador port map (data_in => data_out_p,
                                     data_out => data_out_s);

    rom_inst : rom port map (clk => clk,
                             endereco => data_out_p,
                             dado => instruction);

    banco_en <= '1' when regwrite = '1' and execute = '1' else '0';
    banco_reg_inst : banco_reg port map (sel_reg_read1 => instruction(9 downto 7),
                                         sel_reg_read2 => instruction(2 downto 0),
                                         sel_reg_write => instruction(9 downto 7),
                                         write_in => ula_out,
                                         wr_enable => banco_en,
                                         clk => clk,
                                         rst => rst,
                                         saida1 => b_reg1,
                                         saida2 => b_reg2);

    ula_inst : ula port map (entr0 => ula_a,
                             entr1 => ula_b,
                             sel_op => ula_op,
                             saida => ula_out,
                             zero => zero,
                             sign => sign);

    maq_estados_inst : maq_estados port map (clk => clk,
                                             rst => rst,
                                             estado => estado);

    mux_prox_end : mux2x7 port map (sel => jump,
                                    entr0 => data_out_s,
                                    entr1 => instruction(6 downto 0),
                                    saida => prox_end);

    mux_ula_src_a : mux2x16 port map (sel => ulasrca,
                                      entr0 => "0000000000000000",
                                      entr1 => b_reg1,
                                      saida => ula_a);

    mux_ula_src_b : mux2x16 port map (sel => ulasrcb,
                                      entr0 => b_reg2,
                                      entr1 => const_extendida,
                                      saida => ula_b);

    sign_ext_inst : sign_ext port map (entr => instruction(6 downto 0),
                                       saida => const_extendida);
end architecture a_top_level;
