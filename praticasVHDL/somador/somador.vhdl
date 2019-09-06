library ieee;
use ieee.std_logic_1164.all;

entity somador is
    port ( a: in std_logic;
           b: in std_logic;
           cin: in std_logic;
           cout: out std_logic;
           res: out std_logic
    );
end entity somador;

architecture a_somador of somador is
begin
    cout <= (a and b) or (a and cin) or (b and cin);
    res <= a xor b xor cin;
end architecture a_somador;