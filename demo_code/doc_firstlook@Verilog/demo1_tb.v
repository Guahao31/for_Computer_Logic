`timescale 1ns/1ps

module demo1_tb;
reg[7:0] in;
wire[15:0] out;

sign_extender m0(in, out);

initial begin
    $dumpfile("demo1_tb.vcd");
    $dumpvars(0, demo1_tb);

    in = 8'b0000_0000;
    #10; in = 8'b1000_0001;
    #10; in = 8'b0000_0001;
    #10; in = 8'b1111_1111;
    #10; in = 8'b1100_0011;
    #10; in = 8'b0100_0010;
    #10;
end
endmodule