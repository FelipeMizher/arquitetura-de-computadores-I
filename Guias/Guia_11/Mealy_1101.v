// 821811 - Felipe Rivetti Mizher


`define found 1
`define notfound 0

module mealy_1101(y, x, clk, reset);
    output y;   
    input x;
    input clk;
    input reset;
    reg y;
    
    parameter
        start = 2'b00,
        id1 = 2'b01,
        id11 = 2'b11,
        id110 = 2'b10;
        reg [1:0] E1;
        reg [1:0] E2;
    
    always @(x or E1)
        begin
            y = `notfound;
            case (E1)
                start:
                    if (x)
                        E2 = id1;
                    else
                        E2 = start;
                        id1:
                    if (x)
                        E2 = id11;
                    else
                        E2 = start;
                        id11:
                    if (x)
                        E2 = id11;
                    else
                        E2 = id110;
                        id110:
                    if (x)
                        begin
                            E2 = id1;
                            y = `found;
                        end
                    else
                        begin
                            E2 = start;
                            y = `notfound;
                        end
                    default: 
                        E2 = 2'bxx;
            endcase
        end

    always @( posedge clk or negedge reset )
        begin
            if ( reset )
                E1 = E2;
            else
                E1 = 0; 
            end 
endmodule // mealy_1101

module Guia_1101;
    reg x, clk, reset;
    wire y;

    mealy_1101 mealy (y, x, clk, reset);

    initial
    begin
        $monitor("clock = %b / y = %b / x = %b / res = %b", clk, y, x, reset);
        clk = 0;
        reset = 1;
        #5 reset = 0;
        #10 x = 1;
        #5 x = 0;
        #10 x = 1;
        #5 x = 1;
        #5 x = 0;
        #100 $finish;
    end
    always #5 clk = ~clk;
endmodule // end Guia_1101