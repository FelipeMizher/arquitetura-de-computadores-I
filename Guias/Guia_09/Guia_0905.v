// 821811 - Felipe Rivetti Mizher

`include "clock.v"

module pulse1 (signal, clock);
    input clock;
    output signal;      
    reg signal;

    always @ (posedge clock) begin;
        signal = 1'b1;
        #6 signal = 1'b0;
    end
endmodule // pulse1


module Guia_0905;
    wire clock, p;

    clock clk (clock);
    pulse1 pls(p, clock);

    initial begin
        $dumpfile("Guia_0905.vcd");
        $dumpvars(0, Guia_0905);
        $monitor("clock = %b / p = %b ", clock, p);
        #1000 $finish;
    end
endmodule // Guia_0905