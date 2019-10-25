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
            zero        : in std_logic;
            sign        : in std_logic;
            estado      : in unsigned(1 downto 0);
            jump        : out unsigned(1 downto 0);
            ulasrca     : out unsigned(1 downto 0);
            ulasrcb     : out std_logic;
            ula_op      : out std_logic;
            pc_en       : out std_logic;
            banco_en    : out std_logic;
            flags_en    : out std_logic;
            operror     : out std_logic
      );
    end component unidade_de_controle;
    signal ulasrcb, ula_op, pc_en, banco_en, flags_en, operror : std_logic;
    signal jump, ulasrca : unsigned(1 downto 0);

    component pc is
        port (
            rst      : in std_logic;
            clk      : in std_logic;
            wr_en    : in std_logic;
            data_in  : in unsigned(6 downto 0);
            data_out : out unsigned(6 downto 0)
        );  
    end component pc;
    signal data_out_p : unsigned(6 downto 0);
    signal data_out_pc_16 : unsigned(15 downto 0);

    component somador is
        port (
            data_in  : in unsigned(6 downto 0);
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
    signal ula_zero, ula_sign : std_logic;

    component mux2x16 is
        port (
            sel         : in std_logic;
            entr0       : in unsigned(15 downto 0);
            entr1       : in unsigned(15 downto 0);
            saida       : out unsigned(15 downto 0)
        );
    end component mux2x16;
    signal ula_b : unsigned(15 downto 0);

    component mux3x16 is
      port (
            sel         : in unsigned(1 downto 0);
            entr0       : in unsigned(15 downto 0);
            entr1       : in unsigned(15 downto 0);
            entr2       : in unsigned(15 downto 0);
            saida       : out unsigned(15 downto 0)
      );
    end component mux3x16;
    signal ula_a : unsigned(15 downto 0);

    component mux3x7 is
        port (
              sel         : in unsigned(1 downto 0);
              entr0       : in unsigned(6 downto 0);
              entr1       : in unsigned(6 downto 0);
              entr2       : in unsigned(6 downto 0);
              saida       : out unsigned(6 downto 0)
        );
    end component mux3x7;
    signal prox_end : unsigned(6 downto 0);

    component sign_ext is
        port (
              entr  : in unsigned(6 downto 0);
              saida : out unsigned(15 downto 0)
        );
    end component sign_ext;
    signal const_extendida : unsigned(15 downto 0);

    component flags is
        port (
            clk      : in std_logic;
            rst      : in std_logic;
            wr_en    : in std_logic;
            zero_in  : in std_logic;
            sign_in  : in std_logic;
            zero_out : out std_logic;
            sign_out : out std_logic
        );
    end component flags;
    signal zero, sign : std_logic;

    component maq_estados is
        port (
            clk : in std_logic;
            rst : in std_logic;
            estado : out unsigned(1 downto 0)
        );
    end component maq_estados;
    signal estado : unsigned(1 downto 0);
begin
    err_sig <= operror;
    saida_rom <= instruction;
    saida_pc <= data_out_p;
    saida_reg_1 <= b_reg1;
    saida_reg_2 <= b_reg2;
    saida_ula <= ula_out;

    unidade_de_controle_inst : unidade_de_controle port map (instruction => instruction,
                                                             zero => zero,
                                                             sign => sign,
                                                             jump => jump,
                                                             estado => estado,
                                                             ulasrca => ulasrca,
                                                             ulasrcb => ulasrcb,
                                                             ula_op => ula_op,
                                                             pc_en => pc_en,
                                                             banco_en => banco_en,
                                                             flags_en => flags_en,
                                                             operror => operror
                                                            );

    pc_inst : pc port map (rst => rst,
                           clk => clk,
                           wr_en => pc_en,
                           data_in => prox_end,
                           data_out => data_out_p);
    
    somador_inst : somador port map (data_in => data_out_p,
                                     data_out => data_out_s);

    rom_inst : rom port map (clk => clk,
                             endereco => data_out_p,
                             dado => instruction);

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
                             zero => ula_zero,
                             sign => ula_sign);

    mux_prox_end : mux3x7 port map (sel => jump,
                                    entr0 => data_out_s,
                                    entr1 => instruction(6 downto 0),
                                    entr2 => ula_out(6 downto 0),
                                    saida => prox_end);

    data_out_pc_16 <= "000000000" & data_out_p;
    mux_ula_src_a : mux3x16 port map (sel => ulasrca,
                                      entr0 => "0000000000000000",
                                      entr1 => b_reg1,
                                      entr2 => data_out_pc_16,
                                      saida => ula_a);

    mux_ula_src_b : mux2x16 port map (sel => ulasrcb,
                                      entr0 => b_reg2,
                                      entr1 => const_extendida,
                                      saida => ula_b);

    sign_ext_inst : sign_ext port map (entr => instruction(6 downto 0),
                                       saida => const_extendida);

    flags_inst : flags port map (clk => clk,
                                 rst => rst,
                                 wr_en => flags_en,
                                 zero_in => ula_zero,
                                 sign_in => ula_sign,
                                 zero_out => zero,
                                 sign_out => sign
                                );

    maq_estados_inst : maq_estados port map (clk => clk,
                                             rst => rst,
                                             estado => estado);
end architecture a_top_level;
