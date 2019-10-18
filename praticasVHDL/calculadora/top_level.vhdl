library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_level is
    port (
            rst : in std_logic;
            clk : in std_logic;
            err_sig : out std_logic;
            saida : out unsigned(13 downto 0)
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

    component maq_estados is
        port (
            clk : in std_logic;
            rst : in std_logic;
            estado : out unsigned(0 downto 1)
        );
    end component maq_estados;
    signal estado : unsigned(0 downto 1);

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
begin
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

    maq_estados_inst : maq_estados port map (clk => clk,
                                             rst => rst,
                                             estado => estado);

    mux_prox_end : mux2x7 port map (sel => jump_sel,
                                    entr0 => data_out_s,
                                    entr1 => instruction(6 downto 0),
                                    saida => prox_end);

    mux_ula_src_a : mux2x16 port map (sel => ulasrca,
                                      entr0 => "0000000000000000",
                                      entr1 => entr1,
                                      saida => ula_a);

    mux_ula_src_b : mux2x16 port map (sel => ulasrcb,
                                      entr0 => entr0,
                                      entr1 => entr1,
                                      saida => ula_b);

    sign_ext_inst : sign_ext port map (entr => instruction(6 downto 0),
                                       saida => const_extendida);
end architecture a_top_level;
