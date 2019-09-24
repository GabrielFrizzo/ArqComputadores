helper function for VHDL analyzing in bash:

    function ghda {
        for var in "$@"
        do
            ghdl -a "$var.vhdl" && \
            echo "$var analisado!" && \
            ghdl -e "$var" && \
            echo "$var elaborado!" && \
            ghdl -a "${var}_tb.vhdl" && \
            echo "Testbench $var analisado!" && \
            ghdl -e "${var}_tb" && \
            echo "Testbench $var elaborado!"
        done
        ghdl -r "${var}_tb" --stop-time=3000ns --wave="$1.ghw"
        echo "Onda criada!. Abrindo..."
        gtkwave "$1.ghw"
    }

You can use it like so:
    ghda mux2x1 mux3x1 registrador banco_reg ula reg_ula