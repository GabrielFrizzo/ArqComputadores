library ieee;
use ieee.std_logic_1164.all;

entity decoder is
    port( in_0: in std_logic;
          in_1: in std_logic;
          out_0: out std_logic;
          out_1: out std_logic;
          out_2: out std_logic;
          out_3: out std_logic
    );
end entity decoder;

architecture a_decoder of decoder is
begin
    out_0 <= not in_0 and not in_1;
    out_1 <= in_0 and not in_1;
    out_2 <= not in_0 and in_1;
    out_3 <= in_0 and in_1;
end architecture a_decoder;